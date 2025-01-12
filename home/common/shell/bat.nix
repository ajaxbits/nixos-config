{ pkgs, ... }:
let
  theme = import ../../../lib/theme { inherit pkgs; };
in
{
  programs = {
    bat = {
      enable = true;
      themes = {
        "${theme.apps.bat.name}" = theme.apps.bat.theme;
      };
      config = { theme = theme.apps.bat.name; };
    };
  };
}
