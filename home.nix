{ config, lib, pkgs, ... }:

let 
  derivations = {
    gtk-rose-pine-theme = pkgs.callPackage ./derivations/gtk-rose-pine-theme.nix {};
  };
in {
  imports = 
    (import ./modules/editors) ++
    (import ./modules/programs) ++
    (import ./modules/services) ++
    (import ./modules/shells) ++
    (import ./modules/terminals);

  nixpkgs.config.allowUnfree = true;

  home = {
    packages = with pkgs; [
      # Term Utils
      htop              # System Resources
      nitch             # Fetch system info
      ripgrep           # Grep but Rust
      fd                # Alternative to find
      xclip             # Access X clipboard from terminal

      # Video/Audio
      feh               # Image Viewer
      pavucontrol       # Pulse Audio Settings

      # File Management
      unzip
      ranger            # Terminal File Manager

      # Apps
      discord
      firefox           # Browser
      zoom-us           # Video Conferencing
      portfolio         # Portfolio Performance
      thunderbird       # Email
      zathura           # PDF Viewer
      gimp
      flameshot         # Screenshot Tool
      zotero            # Literature Manager

      # Dev stuff
      gh                # GitHub CLI
      rustup            # Rust Toolchain Utility
      rust-analyzer     # Rust LSP
      tectonic          # TeX Engine
      texlab            # TeX LSP
      tree-sitter

      # For GTK configuration
      dconf

      # Wine for both 32 and 64 bit
      wineWowPackages.stableFull
    ];

    pointerCursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";

      # package = pkgs.phinger-cursors;
      # name = "phinger-cursors-light";
      
      # package = pkgs.quintom-cursor-theme;
      # name = "Quintom_Snow";

      # package = pkgs.catppuccin-cursors.mochaLight;
      # name = "Catppuccin-Mocha-Light-Cursors";

      # package = pkgs.capitaine-cursors;
      # name = "capitaine-cursors-white";
    };

    sessionVariables = { };

    stateVersion = "22.11";
  };

  gtk = {
    enable = true;

    # theme = {
    #   package = pkgs.colloid-gtk-theme;
    #   name = "Colloid-Dark";

    #   # package = pkgs.dracula-theme;
    #   # name = "Dracula";

    #   # package = derivations.gtk-rose-pine-theme;
    #   # name = "rose-pine";
    # };

    iconTheme = {
      # package = pkgs.colloid-icon-theme;
      # name = "Colloid-dark";

      # package = pkgs.papirus-icon-theme;
      # name = "Papirus-Dark";

      package = derivations.gtk-rose-pine-theme;
      name = "rose-pine";
    };

    # font = {
    #   name = "DejaVu Sans";
    # };
  };
}
