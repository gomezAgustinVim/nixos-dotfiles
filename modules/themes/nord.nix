{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nordic
    papirus-nord
    nwg-look
  ];

  gtk = {
    enable = true;
    theme.name = "Nordic-darker";
    iconTheme.name = "Papirus-Dark";
    cursorTheme = {
      name = "Nordic";
      package = pkgs.nordic;
      size = 24;
    };
  };

  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Nordic-darker
    gtk-icon-theme-name=Papirus-Dark
    gtk-cursor-theme-name=Nordic-cursors
    gtk-cursor-theme-size=24
  '';

  xdg.configFile."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Nordic-darker
    gtk-icon-theme-name=Papirus-Dark
    gtk-cursor-theme-name=Nordic-cursors
    gtk-cursor-theme-size=24
  '';

  home.sessionVariables = {
    XCURSOR_THEME = "Nordic-darker";
    XCURSOR_SIZE = "24";
  };
}
