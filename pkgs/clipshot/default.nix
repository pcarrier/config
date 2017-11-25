{ stdenv, writeScriptBin, scrot, xclip }:

writeScriptBin "clipshot" ''
#!${stdenv.shell}
set -eu
d=`mktemp --suffix .png`
trap "rm '$d'" exit
sleep .2
${scrot}/bin/scrot --quality 100 "$@" "$d"
${xclip}/bin/xclip -selection c -t image/png < "$d"
''
