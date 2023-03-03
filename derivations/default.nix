{ pkgs, ... }:

{
  colloid-gtk-theme = pkgs.callPackage ./colloid-gtk-theme {};
  rose-pine-icon-theme = pkgs.callPackage ./rose-pine-icon-theme {};
  sddm-rose-pine-theme = pkgs.callPackage ./sddm-rose-pine-theme {};
}
