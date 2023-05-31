{ pkgs, ... }:
let
  colours = (import ./colours.nix).colours;
in
{
  # Note that there are still places not covered by colour choices here such as:
  #  - bat
  #  - tmux
  #  - vim
  inherit colours;

  wallpaper = ./wallpapers/space-clouds.png;

  gtkTheme = {
    name = "Catppuccin-Macchiato-Standard-Blue-Dark";
    package = pkgs.catppuccin-gtk.override {
      size = "standard";
      variant = "macchiato";
      accents = [ "blue" ];
    };
  };

  qtTheme = {
    name = "Catppuccin-Macchiato-Blue";
    package = (pkgs.catppuccin-kvantum.override { variant = "Macchiato"; accent = "Blue"; });
  };

  iconTheme = rec {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
    iconPath = "${package}/share/icons/${name}";
  };

  cursorTheme = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = 24;
  };

  fonts = {
    default = {
      name = "SF Pro Display";
      package = pkgs.sfpro-font;
      size = "11";
    };
    iconFont = {
      name = "Liga SFMono Nerd Font";
      package = pkgs.sf-mono-liga-font;
    };
    monospace = {
      name = "MesloLGSDZ Nerd Font Mono";
      package = (pkgs.nerdfonts.override { fonts = [ "Meslo" ]; });
    };
    emoji = {
      name = "Joypixels";
      package = pkgs.joypixels;
    };
  };
}