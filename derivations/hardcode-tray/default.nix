{ lib
, stdenvNoCC
, fetchFromGitHub
, python3
, meson
, ninja
, pkg-config
, gobject-introspection
, gtk3
}:

let
  pname = "hardcode-tray";

in stdenvNoCC.mkDerivation rec {
  inherit pname;
  version = "4.3";
  dontUseCmakeConfigure = true;

  src = fetchFromGitHub {
    owner = "bilelmoussaoui";
    repo = pname;
    rev = "v${version}";
    sha256 = "VY2pySi/sCqc9Mx+azj2fR3a46w+fcmPuK+jTBj9018=";
  };

  nativeBuildInputs = [
    pkg-config
    gobject-introspection
    gtk3
  ];

  buildInputs = [
    meson
    ninja
  ];

  propagatedUserEnvPkgs = [
    (python3.withPackages (p: with p; [ pygobject3 ] ))
  ];

  installPhase = ''
    runHook preInstall

    cd $src
    mkdir -p $out/tmp

    meson $out/tmp/builddir --prefix=$out
    ninja -C $out/tmp/builddir install

    runHook postInstall
  '';
}
