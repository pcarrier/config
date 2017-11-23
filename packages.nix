{ pkgs ? import <nixpkgs> {} }:
rec {
	pragmatapro = import ./pkgs/pragmata.nix {
		inherit (pkgs) stdenv requireFile unzip;
	};
}
