{ stdenv, requireFile, unzip }:
stdenv.mkDerivation rec {
	version = "0.826";
	name = "pragmatapro-${version}";
	src = requireFile {
		name = "PragmataPro${version}.zip";
		sha256 = "0r7xmk6npavda6772lcm47c60gh7yzgias7y05yf4r168p8dmd0c";
		message = "Download upstream and import with nix-prefetch-url";
	};
	buildInputs = [ unzip ];
	phases = [ "installPhase" ];
	installPhase = ''
		unzip $src
		install_path=$out/share/fonts/truetype/public/pragmatapro-$version
		mkdir -p $install_path
		cp PragmataPro${version}/Fonts\ with\ ligatures/PragmataPro[RBIZ]*.ttf $install_path
		cp PragmataPro${version}/Fonts\ without\ ligatures/PragmataPro_Mono_*.ttf $install_path
	'';
}
