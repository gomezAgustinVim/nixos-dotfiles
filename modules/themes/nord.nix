{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nordic
    papirus-nord
  ];

  gtk = {
    enable = true;
    theme.name = "Nordic-darker";
    iconTheme.name = "Papirus-Dark";
    cursorTheme = {
      name = "Nordic-cursors";
      size = 20;
    };
  };

  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Nordic-darker
    gtk-icon-theme-name=Papirus-Dark
    gtk-cursor-theme-name=Nordic-cursors
    gtk-cursor-theme-size=20
  '';

  xdg.configFile."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Nordic-darker
    gtk-icon-theme-name=Papirus-Dark
    gtk-cursor-theme-name=Nordic-cursors
    gtk-cursor-theme-size=20
  '';

  home.sessionVariables = {
    XCURSOR_THEME = "Nordic-cursors";
    XCURSOR_SIZE = "20";
  };
}
