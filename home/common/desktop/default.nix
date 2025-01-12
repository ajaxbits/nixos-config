{ pkgs, desktop, ... }: {
  imports = [
    (./. + "/${desktop}")

    ../dev

    ./alacritty.nix
    ./gtk.nix
    ./qt.nix
    ./xdg.nix
    ./zathura.nix
  ];

  programs = {
    firefox.enable = true;
    mpv.enable = true;
  };

  home.packages = with pkgs; [
    catppuccin-gtk
    desktop-file-utils
    ght
    google-chrome
    libnotify
    loupe
    obsidian
    pamixer
    pavucontrol
    rambox
    signal-desktop
    todoist-electron
    xdg-utils
    xorg.xlsclients
  ];

  fonts.fontconfig.enable = true;
}
