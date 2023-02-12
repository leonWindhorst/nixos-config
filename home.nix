{ config, lib, pkgs, ... }:

{
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
      btop              # System Resources
      nitch             # Minimal Fetch

      # Video/Audio
      feh               # Image Viewer

      # Apps
      discord
      firefox           # Browser
      zoom-us           # Video Conferencing

      # File Management
      unzip
    ];

    pointerCursor = {
      package = pkgs.catppuccin-cursors.mochaLight;
      name = "Catppuccin-Mocha-Light-Cursors";

      # package = pkgs.capitaine-cursors;
      # name = "capitaine-cursors";
    };

    stateVersion = "22.11";
  };
}
