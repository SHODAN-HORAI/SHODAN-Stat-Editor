"""Package SHODAN and its explicit optional Bingus throwable service."""
from pathlib import Path
import argparse
import json
import re
import struct
import sys
import zipfile

ROOT = Path(__file__).resolve().parents[1]


def build(loader, output):
    sys.path.insert(0, str(loader / 'scripts'))
    from archive import ARCHIVE, make_archive, read_resource, resource_hash
    from build_addon import entry_source
    entry = entry_source('mods/shodan/stat_editor', (ROOT / 'src/stat_editor.lua').read_bytes())
    helper = (loader / 'src/throwable_launch.lua').read_bytes()
    assert b'-- HD2-Addon:' not in helper, 'Helper must only load through explicit require'
    resources = {
        resource_hash('mods/shodan/stat_editor'): struct.pack('<II', len(entry), 2)+entry,
        resource_hash('mods/cowboybingus/throwable_launch'): struct.pack('<II', len(helper), 2)+helper,
    }
    archive = make_archive(resources)
    for key, body in resources.items(): assert read_resource(archive,key)==body
    description = 'Throwable grenades for launcher weapons in solo missions. Requires Bingus Shared Loader v15+ / API 1.'
    version = re.search(rb"version = '([^']+)'", entry).group(1).decode('utf-8')
    title = f'SHODAN Stat Editor v{version}'
    manifest = {'Version':1, 'Guid':'5489eb29-bb0e-50e2-a1fa-e40a37121db6',
                'Name':title, 'Description':description,
                'Options':[{'Name':title,'Description':description,'Include':['Addon']}]}
    files = {'manifest.json': (json.dumps(manifest,indent=2)+'\n').encode(),
             'Addon/'+ARCHIVE:archive, 'Addon/'+ARCHIVE+'.stream':b'',
             'Addon/'+ARCHIVE+'.gpu_resources':b''}
    output.parent.mkdir(parents=True,exist_ok=True)
    with zipfile.ZipFile(output,'w',compression=zipfile.ZIP_DEFLATED) as package:
        for name,body in sorted(files.items()):
            info=zipfile.ZipInfo(name,date_time=(1980,1,1,0,0,0))
            info.compress_type=zipfile.ZIP_DEFLATED; info.external_attr=0o100644<<16
            package.writestr(info,body)
    with zipfile.ZipFile(output) as package:
        assert package.testzip() is None
        assert package.read('Addon/'+ARCHIVE)==archive
    return output


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--loader',type=Path,default=ROOT.parent/'BingusSharedLoader')
    parser.add_argument('--output',type=Path,default=ROOT/'dist/SHODAN-Stat-Editor-grenades.zip')
    args=parser.parse_args()
    print(build(args.loader,args.output))
