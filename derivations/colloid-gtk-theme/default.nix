{ lib
, stdenvNoCC
, fetchFromGitHub
, gitUpdater
, gnome-themes-extra
, gtk-engine-murrine
, jdupes
, sassc
, themeVariants ? [] # default: blue
, colorVariants ? [] # default: all
, sizeVariants ? [] # default: standard
, tweaks ? []
}:

let
  pname = "colloid-gtk-theme";

in
lib.checkListOfEnum "${pname}: theme variants" [ "default" "purple" "pink" "red" "orange" "yellow" "green" "teal" "grey" "all" ] themeVariants
lib.checkListOfEnum "${pname}: color variants" [ "standard" "light" "dark" ] colorVariants
lib.checkListOfEnum "${pname}: size variants" [ "standard" "compact" ] sizeVariants
lib.checkListOfEnum "${pname}: tweaks" [ "nord" "black" "dracula" "rimless" "normal" ] tweaks

stdenvNoCC.mkDerivation rec {
  inherit pname;
  version = "0.1";

  src = fetchFromGitHub {
    owner = "leonWindhorst";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-sSVBsiq6lW4vKp7OFNr/SGtj42uNh1tzNPWNFATrFrE=";
  };

  nativeBuildInputs = [
    jdupes
    sassc
  ];

  buildInputs = [
    gnome-themes-extra
  ];

  propagatedUserEnvPkgs = [
    gtk-engine-murrine
  ];

  postPatch = ''
    patchShebangs install.sh clean-old-theme.sh
  '';

  installPhase = ''
    runHook preInstall

    name= HOME="$TMPDIR" ./install.sh \
      ${lib.optionalString (themeVariants != []) "--theme " + builtins.toString themeVariants} \
      ${lib.optionalString (colorVariants != []) "--color " + builtins.toString colorVariants} \
      ${lib.optionalString (sizeVariants != []) "--size " + builtins.toString sizeVariants} \
      ${lib.optionalString (tweaks != []) "--tweaks " + builtins.toString tweaks} \
      --dest $out/share/themes

    jdupes --link-soft --recurse $out/share

    runHook postInstall
  '';

  passthru.updateScript = gitUpdater { };

  meta = with lib; {
    description = "A modern and clean Gtk theme";
    homepage = "https://github.com/vinceliuice/Colloid-gtk-theme";
    license = licenses.gpl3Only;
    platforms = platforms.unix;
    maintainers = [ maintainers.romildo ];
  };
}
