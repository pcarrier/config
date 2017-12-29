{ stdenv, requireFile, unzip }:
stdenv.mkDerivation rec {
	name = "tflfonts";
	src = requireFile rec {
		name = "Equity_Concourse_Standard_Triplicate_Advocate_171220.zip";
		sha256 = "15wv5j37i20310n84hd94gyzwgvarkp4xpglaljw02qmw4w24q5i";
		message = "Run $ nix-store --add-fixed sha256 /downloads/${name}";
	};
	buildInputs = [ unzip ];
	phases = [ "installPhase" ];
	installPhase = ''
		install_path=$out/share/fonts/opentype
		mkdir -p $install_path
		unzip -j $src \*.otf -d $install_path
	'';
}
