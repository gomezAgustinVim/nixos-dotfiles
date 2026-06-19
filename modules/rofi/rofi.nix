{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.rofi = {
    enable = true;
    modes = [
      "drun"
      "ssh"
    ];
    font = "FiraCode Nerd Font 10";
    location = "center";
    theme = "/home/nixtane/nixos-dotfiles/modules/rofi/nord.rasi";
    terminal = "foot";
    extraConfig = {
      show-icons = true;
      # icon-theme = "Tela-circle-nord";
      drun-display-format = "{name}";
      display-drun = "";
      display-run = "";
      display-filebrowser = "";
      display-window = "";
      window-format = "{w} {c}";
      ssh-client = "ssh";
      ssh-command = "{terminal} -e {ssh-client} {host} [-p {port}]";
      dpi = 120;
      filebrowser = {
        directories-first = true;
        sorting-method = "name";
      };
    };
  };
}
