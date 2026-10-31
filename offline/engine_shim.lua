-- SHODAN Stat Editor Offline: a desktop window standing in for the game's engine, as far as Stat Editor's panel
-- uses it. The panel draws into a screen gui (rectangles and texts, pixels from the bottom left); here a gui is a
-- display list painted with GDI into a 32-bit back buffer and copied to the window. The window's procedure is
-- Windows' own (DefWindowProcW): no Lua runs inside a window message, the panel reads keys and the mouse itself.
local ffi = require('ffi')
local bit = require('bit')

for _, declaration in ipairs({
    -- (the same signatures as Stat Editor's own declarations: whichever comes first is used by both)
    'void *GetForegroundWindow(void);',
    'int GetCursorPos(void*);',
    'int ScreenToClient(void*,void*);',
    'int GetClientRect(void*,void*);',
    'int16_t GetAsyncKeyState(int key);',
    'void *GetModuleHandleA(const char *name);',
    'void *GetProcAddress(void *module, const char *name);',
    'int MultiByteToWideChar(uint32_t page, uint32_t flags, const char *text, int bytes, uint16_t *wide, int chars);',
    'typedef struct { uint32_t size, style; void *proc; int extra, wextra; void *instance, *icon, *cursor, *brush;'
        .. ' const uint16_t *menu, *name; void *small; } host_wndclass;',
    'uint16_t RegisterClassExW(const host_wndclass *c);',
    'void *CreateWindowExW(uint32_t ex, const uint16_t *cls, const uint16_t *title, uint32_t style, int x, int y,'
        .. ' int w, int h, void *parent, void *menu, void *instance, void *param);',
    'int AdjustWindowRectEx(int32_t *rect, uint32_t style, int menu, uint32_t ex);',
    'int ShowWindow(void *window, int show);',
    'int SetForegroundWindow(void *window);',
    'int IsWindow(void *window);',
    'int DestroyWindow(void *window);',
    'int SetWindowTextW(void *window, const uint16_t *text);',
    'int PeekMessageW(void *msg, void *window, uint32_t lo, uint32_t hi, uint32_t remove);',
    'int TranslateMessage(const void *msg);',
    'intptr_t DispatchMessageW(const void *msg);',
    'void *LoadCursorW(void *instance, const void *name);',
    'void *LoadImageW(void *instance, const uint16_t *name, uint32_t type, int w, int h, uint32_t flags);',
    'int SystemParametersInfoW(uint32_t action, uint32_t param, void *data, uint32_t ini);',
    'void *GetDC(void *window);',
    'int ReleaseDC(void *window, void *dc);',
    'int IsIconic(void *window);',
    'int GetSystemMetrics(int index);',
    'int SetProcessDPIAware(void);',
    'void *MonitorFromWindow(void *window, uint32_t flags);',
    'void *MonitorFromRect(const int32_t *rect, uint32_t flags);',
    'int GetMonitorInfoW(void *monitor, int32_t *info);',
    'int GetWindowRect(void *window, int32_t *rect);',
    'int SetWindowPos(void *window, void *after, int x, int y, int w, int h, uint32_t flags);',
    'int SetProcessDpiAwarenessContext(void *context);',
    'int MessageBoxW(void *window, const uint16_t *text, const uint16_t *title, uint32_t type);',
    'void Sleep(uint32_t ms);',
    'typedef struct { uint32_t size; int32_t width, height; uint16_t planes, bits; uint32_t compression, image,'
        .. ' xppm, yppm, used, important; } host_bitmapinfo;',
    'void *CreateDIBSection(void *dc, const host_bitmapinfo *info, uint32_t usage, void **bits, void *section, uint32_t offset);',
    'void *CreateCompatibleDC(void *dc);',
    'void *SelectObject(void *dc, void *object);',
    'int DeleteObject(void *object);',
    'int DeleteDC(void *dc);',
    'int BitBlt(void *dc, int x, int y, int w, int h, void *src, int sx, int sy, uint32_t op);',
    'void *CreateFontW(int h, int w, int esc, int orient, int weight, uint32_t italic, uint32_t underline,'
        .. ' uint32_t strike, uint32_t charset, uint32_t out, uint32_t clip, uint32_t quality, uint32_t pitch, const uint16_t *face);',
    'int SetBkMode(void *dc, int mode);',
    'uint32_t SetTextColor(void *dc, uint32_t color);',
    'uint32_t SetTextAlign(void *dc, uint32_t align);',
    'int TextOutW(void *dc, int x, int y, const uint16_t *text, int count);',
    'int GetTextExtentPoint32W(void *dc, const uint16_t *text, int count, int32_t *size);',
    'int GdiFlush(void);',
    'uint64_t GetTickCount64(void);',
    'typedef struct { void *hwnd; uint32_t message; uint32_t pad; uintptr_t wparam; intptr_t lparam;'
        .. ' uint32_t time, x, y, private_; } host_msg;',
}) do pcall(ffi.cdef, declaration) end

local user, gdi, kernel = ffi.load('user32'), ffi.load('gdi32'), ffi.C

local M = { window = nil, w = 0, h = 0, title = 'SHODAN Stat Editor Offline' }

-- UTF-8 -> zero-ended UTF-16, and its length without the zero
local function wide(text)
    local n = kernel.MultiByteToWideChar(65001, 0, text, #text, nil, 0)
    local out = ffi.new('uint16_t[?]', n + 1)
    if n > 0 then kernel.MultiByteToWideChar(65001, 0, text, #text, out, n) end
    return out, n
end
M.wide = wide

function M.message_box(text, kind)   -- kind: 0x10 error, 0x30 warning, 0x40 information, + 0x4 yes/no (6 = yes)
    return user.MessageBoxW(M.window, (wide(text)), (wide(M.title)), kind or 0x40)
end

-- ---------------------------------------------------------------- the window and its back buffer
-- ---------------------------------------------------------------- text typed into the window
-- The window procedure is Windows' own, so the characters the window receives arrive as WM_CHAR: the keyboard's,
-- and an input method's Chinese or any other script. They are taken out of the message queue in pump() and
-- handed to the panel, which uses them instead of reading the keys: an input method takes the keys it composes
-- with before they make characters, so keys read on their own would type the pinyin (and the digit that picks a
-- candidate) next to the character the input method commits, and a Chinese input method takes the digits too.
local typed, typed_at, typed_high = {}, 0, nil
local TYPED_KEEP = 2   -- seconds a character waits for the panel (dropped if the panel was not there)

local function now_ms() return tonumber(kernel.GetTickCount64()) end

local function utf8_of(code)
    if code < 0x80 then return string.char(code) end
    if code < 0x800 then return string.char(0xC0 + math.floor(code / 0x40), 0x80 + code % 0x40) end
    if code < 0x10000 then
        return string.char(0xE0 + math.floor(code / 0x1000), 0x80 + math.floor(code / 0x40) % 0x40,
                           0x80 + code % 0x40)
    end
    return string.char(0xF0 + math.floor(code / 0x40000), 0x80 + math.floor(code / 0x1000) % 0x40,
                       0x80 + math.floor(code / 0x40) % 0x40, 0x80 + code % 0x40)
end

-- One UTF-16 code unit of WM_CHAR (a surrogate pair arrives as two). Control characters are dropped: Enter,
-- Tab and the like are keys the panel reads itself, not text.
function M.push_typed(code)
    if not code or code < 0x20 or code == 0x7F then return end
    if code >= 0xD800 and code < 0xDC00 then typed_high = code; return end
    local point = code
    if code >= 0xDC00 and code < 0xE000 then
        if not typed_high then return end
        point, typed_high = 0x10000 + (typed_high - 0xD800) * 0x400 + (code - 0xDC00), nil
    else
        typed_high = nil
    end
    typed[#typed + 1] = utf8_of(point)
    while #typed > 64 do table.remove(typed, 1) end
    typed_at = now_ms()
end

-- The characters typed since the last call ('' when there were none)
function M.take_typed()
    if #typed == 0 then return '' end
    local text = table.concat(typed)
    for k = #typed, 1, -1 do typed[k] = nil end
    typed_high = nil
    if now_ms() - typed_at > TYPED_KEEP * 1000 then return '' end
    return text
end

local PANEL_W, PANEL_H = 1060, 1080   -- the panel (1000 wide) and its margins, in 1080p units
local STYLE = 0x00CE0000   -- WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_MINIMIZEBOX | WS_THICKFRAME (issue #110)

-- the client for a work area (left, top, right, bottom) and a frame `extra_w` x `extra_h`: panel-shaped, `want` px
-- tall (the size the user dragged it to) as far as the work area allows, else as tall as it allows (at most 1350 px)
local function client_for(work, extra_w, extra_h, want)
    local room = math.min(work[3] - work[1] - extra_h, (work[2] - work[0] - extra_w) * PANEL_H / PANEL_W)
    local ch = want and math.max(400, want) or math.min(work[3] - work[1] - extra_h, 1.25 * 1080) * 0.95
    ch = math.floor(math.min(ch, room))
    return math.floor(ch * PANEL_W / PANEL_H + 0.5), ch
end

local monitor_info = ffi.new('int32_t[10]')   -- MONITORINFO: size, the screen, its work area (+5), flags
local function screen_work(screen)
    monitor_info[0] = 40
    return user.GetMonitorInfoW(screen, monitor_info) ~= 0
end
local function handle(p) return tonumber(ffi.cast('intptr_t', p)) end

-- the back buffer: 32-bit, top-down, cw x ch
local function back_buffer(cw, ch)
    local info = ffi.new('host_bitmapinfo')
    info.size, info.width, info.height, info.planes, info.bits = ffi.sizeof(info), cw, -ch, 1, 32
    local bits = ffi.new('void *[1]')
    local dib = gdi.CreateDIBSection(M.dc, info, 0, bits, nil, 0)
    if dib == nil then return false end
    gdi.SelectObject(M.dc, dib)
    if M.dib then gdi.DeleteObject(M.dib) end
    M.dib, M.bits, M.w, M.h = dib, ffi.cast('uint32_t *', bits[0]), cw, ch
    M.version = (M.version or 0) + 1   -- everything is painted again
    return true
end

-- Sizes the window for the work area of the screen it is on (its frame as that screen's scale draws it), inside
-- that work area, and its back buffer with it (the panel follows Gui.resolution).
local window_rect, client_rect = ffi.new('int32_t[4]'), ffi.new('int32_t[4]')
local function fit()
    local screen = user.MonitorFromWindow(M.window, 2)   -- MONITOR_DEFAULTTONEAREST
    M.monitor = handle(screen)
    if not screen_work(screen) then return end
    local work = monitor_info + 5
    user.GetWindowRect(M.window, window_rect)
    user.GetClientRect(M.window, client_rect)
    local extra_w = window_rect[2] - window_rect[0] - client_rect[2]
    local extra_h = window_rect[3] - window_rect[1] - client_rect[3]
    local cw, ch = client_for(work, extra_w, extra_h, M.want)
    local w, h = cw + extra_w, ch + extra_h
    local x = math.max(work[0], math.min(window_rect[0], work[2] - w))
    local y = math.max(work[1], math.min(window_rect[1], work[3] - h))
    user.SetWindowPos(M.window, nil, x, y, w, h, 0x14)   -- SWP_NOZORDER | SWP_NOACTIVATE
    if cw ~= M.w or ch ~= M.h or not M.dib then back_buffer(cw, ch) end
end

function M.open(title, place)
    M.title = title or M.title
    if not pcall(function() return user.SetProcessDpiAwarenessContext(ffi.cast('void *', -4)) end) then
        pcall(function() return user.SetProcessDPIAware() end)
    end
    local instance = kernel.GetModuleHandleA(nil)
    local cls = ffi.new('host_wndclass')
    cls.size = ffi.sizeof(cls)
    cls.style = 0x3   -- CS_HREDRAW | CS_VREDRAW
    cls.proc = kernel.GetProcAddress(kernel.GetModuleHandleA('user32.dll'), 'DefWindowProcW')
    cls.instance = instance
    cls.cursor = user.LoadCursorW(nil, ffi.cast('const void *', 32512))   -- IDC_ARROW
    cls.icon = user.LoadImageW(instance, ffi.cast('const uint16_t *', 1), 1, 0, 0, 0x40)   -- the exe's icon, if any
    cls.small = user.LoadImageW(instance, ffi.cast('const uint16_t *', 1), 1, user.GetSystemMetrics(49), user.GetSystemMetrics(50), 0)
    local name = wide('ShodanStatEditorOffline')
    cls.name = name
    user.RegisterClassExW(cls)
    -- the first guess (the main screen's work area, centred), or the work area of the screen `place` (x, y: the
    -- window's top left when it last closed) is on; fit() sizes it for its screen once it is open
    local work = ffi.new('int32_t[4]', place and place[1] or 0, place and place[2] or 0, place and place[1] + 1 or 1,
                         place and place[2] + 1 or 1)
    local screen = place and user.MonitorFromRect(work, 0)   -- MONITOR_DEFAULTTONULL: that screen is gone
    if not (place and screen ~= nil and screen_work(screen)) then
        place = nil
        user.SystemParametersInfoW(0x30, 0, work, 0)   -- SPI_GETWORKAREA
    else
        ffi.copy(work, monitor_info + 5, 16)
    end
    local frame = ffi.new('int32_t[4]', 0, 0, 100, 100)
    user.AdjustWindowRectEx(frame, STYLE, 0, 0)
    local extra_w, extra_h = frame[2] - frame[0] - 100, frame[3] - frame[1] - 100
    M.want = place and place[3]
    local cw, ch = client_for(work, extra_w, extra_h, M.want)
    local x = place and place[1] or work[0] + math.floor((work[2] - work[0] - cw - extra_w) / 2)
    local y = place and place[2] or work[1] + math.floor((work[3] - work[1] - ch - extra_h) / 2)
    M.window = user.CreateWindowExW(0, name, (wide(M.title)), STYLE, x, y, cw + extra_w, ch + extra_h, nil, nil, instance, nil)
    assert(M.window ~= nil, 'could not open the window')
    M.name = name
    local dc = user.GetDC(M.window)
    M.dc = gdi.CreateCompatibleDC(dc)
    user.ReleaseDC(M.window, dc)
    fit()
    assert(M.dib ~= nil, 'no back buffer')
    gdi.SetBkMode(M.dc, 1)   -- TRANSPARENT
    gdi.SetTextAlign(M.dc, 24)   -- TA_BASELINE | TA_LEFT
    user.ShowWindow(M.window, 5)
    user.SetForegroundWindow(M.window)
    return M.window
end

local msg = ffi.new('host_msg')
-- Handles the window's messages; false once the window is closed. A window moved onto another screen is sized
-- for that one (moving it is Windows' own loop inside DispatchMessageW: this runs once it is let go).
-- A window the user resized (Windows' loop too, let go before this runs) takes the panel's shape again, as tall
-- as the side they dragged most asks for. M.place: the window's top left and client height, while not minimized.
function M.pump()
    while user.PeekMessageW(msg, nil, 0, 0, 1) ~= 0 do
        if msg.message == 0x0102 then   -- WM_CHAR: a character for the panel, an input method's own included
            M.push_typed(tonumber(msg.wparam))
        else
            user.TranslateMessage(msg)
            user.DispatchMessageW(msg)
        end
    end
    if M.window == nil or user.IsWindow(M.window) == 0 then return false end
    if user.IsIconic(M.window) == 0 then
        user.GetClientRect(M.window, client_rect)
        local cw, ch = client_rect[2], client_rect[3]
        if cw > 0 and ch > 0 and (cw ~= M.w or ch ~= M.h) then
            local tall = math.abs(ch - M.h) / M.h >= math.abs(cw - M.w) / M.w
            M.want = tall and ch or math.floor(cw * PANEL_H / PANEL_W + 0.5)
            fit()
            M.want = M.h   -- (what the screen allowed)
        elseif handle(user.MonitorFromWindow(M.window, 2)) ~= M.monitor then fit() end
        user.GetWindowRect(M.window, window_rect)
        M.place = { window_rect[0], window_rect[1], M.want }
    end
    return true
end

function M.sleep(ms) kernel.Sleep(ms) end
function M.set_title(text) user.SetWindowTextW(M.window, (wide(text))) end
function M.focused() return M.window ~= nil and user.GetForegroundWindow() == M.window end

-- the cursor in the client, pixels from the top left (nil outside)
local point = ffi.new('int32_t[2]')
function M.cursor()
    if user.GetCursorPos(point) == 0 or user.ScreenToClient(M.window, point) == 0 then return nil end
    local x, y = point[0], point[1]
    if x < 0 or y < 0 or x >= M.w or y >= M.h then return nil end
    return x, y
end
function M.key_down(vk) return user.GetAsyncKeyState(vk) < 0 end

-- ---------------------------------------------------------------- painting
-- The face: Windows' UI font for the panel's language (M.lang(): its id), the same for measuring and drawing.
local fonts = {}
local FACES = { ['zh-Hans'] = 'Microsoft YaHei UI', ['zh-Hant'] = 'Microsoft JhengHei UI' }
M.lang = function() return 'en' end
local function font_of(size, bold)
    local h = math.max(6, math.floor(size + 0.5))
    local face = FACES[M.lang()] or 'Segoe UI'
    local key = face .. h .. (bold and 'b' or '')
    if not fonts[key] then
        -- CLEARTYPE_QUALITY, DEFAULT_CHARSET
        fonts[key] = gdi.CreateFontW(-h, 0, 0, 0, bold and 600 or 400, 0, 0, 0, 1, 0, 0, 5, 0, (wide(face)))
    end
    return fonts[key]
end
M.font_of = font_of

local extent = ffi.new('int32_t[2]')
function M.text_width(text, size, bold)
    if text == '' then return 0 end
    gdi.SelectObject(M.dc, font_of(size, bold))
    local w, n = wide(text)
    gdi.GetTextExtentPoint32W(M.dc, w, n, extent)
    return extent[0]
end

-- c: { a, r, g, b }
function M.fill(x0, y0, x1, y1, c)
    -- a thin line keeps its thickness wherever it lands (rounding each edge alone made it 1 to 3 pixels)
    if y1 - y0 < 4 then y0, y1 = math.floor(y0 + 0.5), math.floor(y0 + 0.5) + math.max(1, math.floor(y1 - y0 + 0.5)) end
    if x1 - x0 < 4 then x0, x1 = math.floor(x0 + 0.5), math.floor(x0 + 0.5) + math.max(1, math.floor(x1 - x0 + 0.5)) end
    x0, y0 = math.max(0, math.floor(x0 + 0.5)), math.max(0, math.floor(y0 + 0.5))
    x1, y1 = math.min(M.w, math.floor(x1 + 0.5)), math.min(M.h, math.floor(y1 + 0.5))
    if x1 <= x0 or y1 <= y0 then return end
    local a = c[1] or 255
    if a <= 0 then return end
    local bits, w = M.bits, M.w
    if a >= 255 then
        local v = c[2] * 65536 + c[3] * 256 + c[4]
        for y = y0, y1 - 1 do
            local row = y * w
            for x = x0, x1 - 1 do bits[row + x] = v end
        end
        return
    end
    local k = a / 255
    local r, g, b = c[2] * k, c[3] * k, c[4] * k
    local q = 1 - k
    for y = y0, y1 - 1 do
        local row = y * w
        for x = x0, x1 - 1 do
            local p = bits[row + x]
            local pr, pg, pb = bit.band(bit.rshift(p, 16), 255), bit.band(bit.rshift(p, 8), 255), bit.band(p, 255)
            bits[row + x] = bit.bor(bit.lshift(math.floor(pr * q + r), 16), bit.lshift(math.floor(pg * q + g), 8), math.floor(pb * q + b))
        end
    end
end

-- text with its baseline at y (pixels from the top)
function M.text(text, x, y, size, c, bold)
    if text == '' then return end
    gdi.SelectObject(M.dc, font_of(size, bold))
    gdi.SetTextColor(M.dc, c[2] + c[3] * 256 + c[4] * 65536)
    local w, n = wide(text)
    gdi.TextOutW(M.dc, math.floor(x + 0.5), math.floor(y + 0.5), w, n)
end

function M.flush() gdi.GdiFlush() end

-- the pages' icons (the HUD's weapon icons): icons.bin next to this file (tools/hud_icons.py has its layout), read
-- once; a page's icon unpacked the first time it is drawn. Its width and height (pixels), or nil: none for that page.
local icon_pack = nil
function M.icon_size(name)
    if icon_pack == nil then
        icon_pack = { pages = {}, images = {} }
        local f = io.open((debug.getinfo(1, 'S').source:match('^@(.*[/\\])') or './') .. 'icons.bin', 'rb')
        local data = f and f:read('*a')
        if f then f:close() end
        local function u16(o) return data:byte(o + 1) + data:byte(o + 2) * 256 end
        local function u32(o) return u16(o) + u16(o + 2) * 65536 end
        if data and #data >= 16 and data:sub(1, 4) == 'SSIC' and u32(4) == 2 then
            local images, pages, at = u32(8), u32(12), 16
            for _ = 1, pages do
                icon_pack.pages[data:sub(at + 1, at + 16)] = u16(at + 16) + 1
                at = at + 18
            end
            for k = 1, images do
                if at + 8 > #data then break end
                local i = { w = u16(at), h = u16(at + 2), rgb = { data:byte(at + 5, at + 7) }, masks = {} }
                local count = data:byte(at + 8)
                at = at + 8
                for m = 1, count do
                    if at + 4 > #data then break end
                    local n = u32(at)
                    i.masks[m] = { runs = data:sub(at + 5, at + 4 + n) }
                    at = at + 4 + n
                end
                icon_pack.images[k] = i
            end
        end
    end
    local i = icon_pack.images[icon_pack.pages[name] or 0]
    if not i then return nil end
    for _, m in ipairs(i.masks) do
        if not m.px then
            m.px = ffi.new('uint8_t[?]', i.w * i.h)
            local runs, at = m.runs, 0
            for k = 1, #runs - 1, 2 do
                local n, v = runs:byte(k, k + 1)
                if at + n > i.w * i.h then break end
                ffi.fill(m.px + at, n, v)
                at = at + n
            end
        end
    end
    return i.w, i.h, i
end

-- a page's icon fitted into the box x0..x1, y0..y1 at its right, each pixel the average of those it covers: its first
-- mask in its own colour times c, its second (stratagems: the white part) in c on top
function M.icon(name, x0, y0, x1, y1, c)
    local _, _, i = M.icon_size(name)
    if not i then return false end
    local k = math.min((x1 - x0) / i.w, (y1 - y0) / i.h)
    local dw, dh = math.floor(i.w * k), math.floor(i.h * k)
    local left, top = math.floor(x1 - dw + 0.5), math.floor(y0 + ((y1 - y0) - dh) / 2 + 0.5)
    local bits, a = M.bits, (c[1] or 255) / 255
    for m, mask in ipairs(i.masks) do
        local px, cr, cg, cb = mask.px, c[2], c[3], c[4]
        if m == 1 then cr, cg, cb = cr * i.rgb[1] / 255, cg * i.rgb[2] / 255, cb * i.rgb[3] / 255 end
        for y = math.max(0, top), math.min(M.h, top + dh) - 1 do
            local sy0, sy1 = math.floor((y - top) / k), math.max(math.floor((y - top) / k) + 1, math.floor((y - top + 1) / k))
            for x = math.max(0, left), math.min(M.w, left + dw) - 1 do
                local sx0, sx1 = math.floor((x - left) / k), math.max(math.floor((x - left) / k) + 1, math.floor((x - left + 1) / k))
                local sum, n = 0, 0
                for sy = sy0, math.min(sy1, i.h) - 1 do
                    for sx = sx0, math.min(sx1, i.w) - 1 do sum, n = sum + px[sy * i.w + sx], n + 1 end
                end
                local q = n > 0 and sum / n / 255 * a or 0
                if q > 0 then
                    local p = bits[y * M.w + x]
                    local pr, pg, pb = bit.band(bit.rshift(p, 16), 255), bit.band(bit.rshift(p, 8), 255), bit.band(p, 255)
                    bits[y * M.w + x] = bit.bor(bit.lshift(math.floor(pr + (cr - pr) * q), 16), bit.lshift(math.floor(pg + (cg - pg) * q), 8),
                                                math.floor(pb + (cb - pb) * q))
                end
            end
        end
    end
    return true
end

-- the back buffer as a .bmp (tests)
function M.save_bmp(path)
    gdi.GdiFlush()
    local size = M.w * M.h * 4
    local head = ffi.new('uint8_t[54]')
    local function put(at, v, n) for k = 0, n - 1 do head[at + k] = math.floor(v / 256 ^ k) % 256 end end
    head[0], head[1] = 66, 77
    put(2, 54 + size, 4); put(10, 54, 4); put(14, 40, 4); put(18, M.w, 4); put(22, 4294967296 - M.h, 4)
    put(26, 1, 2); put(28, 32, 2); put(34, size, 4)
    local f = assert(io.open(path, 'wb'))
    f:write(ffi.string(head, 54), ffi.string(M.bits, size))
    f:close()
end

function M.present()
    gdi.GdiFlush()
    if user.IsIconic(M.window) ~= 0 then return end
    local dc = user.GetDC(M.window)
    gdi.BitBlt(dc, 0, 0, M.w, M.h, M.dc, 0, 0, 0x00CC0020)   -- SRCCOPY
    user.ReleaseDC(M.window, dc)
end

-- ---------------------------------------------------------------- the engine
-- A gui: { items = { { z, n, kind, ... } } } in gui pixels from the bottom left.
local guis, live = {}, 0
M.version = 0   -- changes whenever a gui is made or taken down

local function vector(n)
    local V = {}
    V.x = function(v) return v[1] end
    V.y = function(v) return v[2] end
    if n == 3 then V.z = function(v) return v[3] end end
    return setmetatable(V, { __call = function(_, x, y, z) return { x or 0, y or 0, z or 0 } end })
end

local main_world, overlay_world = { name = 'main world' }, { name = 'overlay world' }

local function add(gui, item)
    item.n = #gui.items + 1
    gui.items[item.n] = item
end

function M.engine()
    local Vector2, Vector3 = vector(2), vector(3)
    local sr = {
        Vector2 = Vector2, Vector3 = Vector3,
        Color = function(a, r, g, b) return { a, r, g, b } end,
        IdString64 = { from_hex = function(h) return h end },
        Application = {
            main_world = function() return main_world end,
            worlds = function() return { main_world, overlay_world } end,
            can_get = function() return true end,
            -- the characters typed into the window (an input method's Chinese included; see take_typed)
            typed_text = function() return M.take_typed() end,
        },
        World = {
            create_screen_gui = function(world)
                live = live + 1
                local gui = { id = live, items = {} }
                guis[gui] = true
                M.version = M.version + 1
                return gui
            end,
            destroy_gui = function(world, gui)
                guis[gui] = nil
                M.version = M.version + 1
            end,
        },
        Gui = {
            resolution = function() return M.w, M.h end,
            rect = function(gui, pos, size, color)
                add(gui, { kind = 'rect', z = pos[3] or 0, x = pos[1], y = pos[2], w = size[1], h = size[2], c = color })
            end,
            text = function(gui, text, font, size, material, pos, color)
                add(gui, { kind = 'text', z = pos[3] or 0, x = pos[1], y = pos[2], text = tostring(text), size = size,
                           c = color or { 255, 255, 255, 255 } })
            end,
            text_extents = function(gui, text, font, size)
                return Vector3(0, -size * 0.2, 0), Vector3(M.text_width(tostring(text), size), size * 0.8, 0)
            end,
            material = function() return 'material' end,
            -- offline only: a page's icon (icons.bin, M.icon) fitted into the box at its right; icon_size: its
            -- width and height in pixels and whether it is a stratagem's (two masks, drawn bigger), or nil (none)
            icon = function(gui, name, pos, size, color)
                add(gui, { kind = 'icon', z = pos[3] or 0, x = pos[1], y = pos[2], w = size[1], h = size[2], name = name,
                           c = color or { 255, 255, 255, 255 } })
            end,
            icon_size = function(name) local w, h, i = M.icon_size(name) return w, h, i and #i.masks > 1 end,
        },
        Material = { set_texture = function() end },
        Mouse = {
            button_id = function(name) return ({ left = 1, right = 2, middle = 4 })[name] or 1 end,
            button = function(id) return (M.focused() and M.key_down(id)) and 1 or 0 end,
        },
    }
    return sr
end

-- Paints every live gui (by z, then in the order drawn) into the back buffer; the host paints its own parts after.
function M.paint_guis(background)
    M.fill(0, 0, M.w, M.h, background)
    local items = {}
    for gui in pairs(guis) do
        for _, item in ipairs(gui.items) do items[#items + 1] = item end
    end
    table.sort(items, function(a, b) if a.z ~= b.z then return a.z < b.z end return a.n < b.n end)
    local texting = false
    for _, item in ipairs(items) do
        if item.kind == 'rect' or item.kind == 'icon' then
            if texting then gdi.GdiFlush(); texting = false end
            if item.kind == 'rect' then M.fill(item.x, M.h - item.y - item.h, item.x + item.w, M.h - item.y, item.c)
            else M.icon(item.name, item.x, M.h - item.y - item.h, item.x + item.w, M.h - item.y, item.c) end
        else
            M.text(item.text, item.x, M.h - item.y, item.size, item.c)
            texting = true
        end
    end
    gdi.GdiFlush()
end

return M
