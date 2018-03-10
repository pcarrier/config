{ stdenv, writeScriptBin, coreutils, xorg }:
writeScriptBin "displays" ''
#!${stdenv.shell}
cmd="$1"
shift
case "$cmd" in
        fhd )
		${xorg.xrandr}/bin/xrandr --output eDP1 --mode 1920x1080 --output DP1  --off
	;;
        internal )
		${xorg.xrandr}/bin/xrandr --output eDP1 --mode 3840x2160 --output DP1  --off
	;;
        external )
		${xorg.xrandr}/bin/xrandr --output DP1  --mode 3840x2160 --output eDP1 --off
	;;
esac
''
