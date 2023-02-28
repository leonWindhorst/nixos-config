{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "sddm-rose-pine-theme";
  version = "1.1";
  dontBuild = true;

  src = fetchFromGitHub {
    owner = "leonWindhorst";
    repo = "sddm-rose-pine";
    rev = "v${version}";
    sha256 = "sha256-HMKBU8/elF4ahpO/xWRIozD3dAnpz52+eFDS3YNDJyw=";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/rose-pine
  '';
}
