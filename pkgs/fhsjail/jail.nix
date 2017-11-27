{ stdenv, buildEnv, writeText, pkgs, system }:

{ name, profile ? ""
, includedPkgs ? pkgs: []
, extraBuildCommands ? ""
}:

let
  includedPaths = includedPkgs pkgs;

  etcProfile = writeText "profile" ''
    export LD_LIBRARY_PATH=/lib64
    export PS1='${name}-jail:\u@\h:\w\$ '
    export LOCALE_ARCHIVE='/usr/lib/locale/locale-archive'
    export PATH='/run/wrappers/bin:/usr/bin:/usr/sbin'
    export NIX_CC_WRAPPER_${stdenv.cc.infixSalt}_TARGET_HOST=1
    export NIX_CFLAGS_COMPILE='-idirafter /usr/include'
    export NIX_LDFLAGS_BEFORE='-L/usr/lib -L/usr/lib32'
    export PKG_CONFIG_PATH=/usr/lib/pkgconfig
    export ACLOCAL_PATH=/usr/share/aclocal

    ${profile}
  '';

  # Compose /etc for the chroot environment
  etcPkg = stdenv.mkDerivation {
    name = "${name}-fhsjail-etc";
    buildCommand = ''
      mkdir -p $out/etc
      cd $out/etc
      ln -s ${etcProfile} profile
      ln -s /host/etc/static static
      ln -s /host/etc/passwd passwd
      ln -s /host/etc/group group
      ln -s /host/etc/shadow shadow
      ln -s /host/etc/hosts hosts
      ln -s /host/etc/resolv.conf resolv.conf
      ln -s /host/etc/nsswitch.conf nsswitch.conf
      ln -s /host/etc/login.defs login.defs
      ln -s /host/etc/sudoers sudoers
      ln -s /host/etc/sudoers.d sudoers.d
      ln -s /host/etc/localtime localtime
      ln -s /host/etc/zoneinfo zoneinfo
      ln -s /host/etc/machine-id machine-id
      ln -s /host/etc/os-release os-release
      ln -s /host/etc/pam.d pam.d
      ln -s /host/etc/fonts fonts
      ln -s /host/etc/asound.conf asound.conf
      mkdir -p ssl
      ln -s /host/etc/ssl/certs ssl/certs
      ln -s /proc/mounts mtab
    '';
  };

  staticUsrProfileTarget = buildEnv {
    name = "${name}-usr-target";
    paths = [ etcPkg ] ++ (includedPkgs pkgs);
    extraOutputsToInstall = [ "out" "lib" "bin" ];
    ignoreCollisions = true;
  };

  setupLibDirs = ''
    cp -rsHf ${staticUsrProfileTarget}/lib lib
    ln -s lib lib64
  '';

  setupTargetProfile = ''
    mkdir -m0755 usr
    cd usr
    ${setupLibDirs}
    for i in bin sbin share include; do
      if [ -d "${staticUsrProfileTarget}/$i" ]; then
        cp -rsHf "${staticUsrProfileTarget}/$i" "$i"
      fi
    done
    cd ..

    for i in var etc; do
      if [ -d "${staticUsrProfileTarget}/$i" ]; then
        cp -rsHf "${staticUsrProfileTarget}/$i" "$i"
      fi
    done
    for i in usr/{bin,sbin,lib,lib32,lib64}; do
      if [ -d "$i" ]; then
        ln -s "$i"
      fi
    done
  '';

in stdenv.mkDerivation {
  name = "${name}-fhsjail";
  buildCommand = ''
    mkdir -p $out
    cd $out
    ${setupTargetProfile}
    cd $out
    ${extraBuildCommands}
    cd $out
  '';
  preferLocalBuild = true;
}
