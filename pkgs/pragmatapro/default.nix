{ stdenv, requireFile, unzip }:
stdenv.mkDerivation rec {
	version = "0.826";
	name = "pragmatapro-${version}";
	src = requireFile rec {
		name = "PragmataPro${version}.zip";
		sha256 = "0r7xmk6npavda6772lcm47c60gh7yzgias7y05yf4r168p8dmd0c";
		message = "Run $ nix-store --add-fixed sha256 /downloads/${name}";
	};
	buildInputs = [ unzip ];
	phases = [ "installPhase" ];
	installPhase = ''
		unzip $src
		install_path=$out/share/fonts/truetype
		mkdir -p $install_path
		cp PragmataPro${version}/Fonts\ with\ ligatures/PragmataPro[RBIZ]*.ttf $install_path
		cp PragmataPro${version}/Fonts\ without\ ligatures/PragmataPro_Mono_*.ttf $install_path
	'';
}
