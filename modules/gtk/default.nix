{ home, pkgs, ... }:

let
  derivations = import ../../derivations { inherit pkgs; };
in {
  gtk = {
    enable = true;

    theme = {
      package = pkgs.dracula-theme;
      name = "Dracula";

      # package = pkgs.colloid-gtk-theme;
      # name = "Colloid-Dark";

      # package = derivations.colloid-gtk-theme;
      # name = "Colloid-RosePine";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";

      # package = pkgs.colloid-icon-theme;
      # name = "Colloid-dark";

      # package = pkgs.papirus-icon-theme;
      # name = "Papirus-Dark";

      # package = derivations.rose-pine-icon-theme;
      # name = "rose-pine";
    };

    # font = {
    #   name = "DejaVu Sans";
    # };
  };
}
