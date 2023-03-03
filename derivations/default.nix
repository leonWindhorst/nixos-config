{ pkgs, ... }:

{
  colloid-gtk-theme = pkgs.callPackage ./colloid-gtk-theme {};
  sddm-rose-pine-theme = pkgs.callPackage ./sddm-rose-pine-theme {};
}
