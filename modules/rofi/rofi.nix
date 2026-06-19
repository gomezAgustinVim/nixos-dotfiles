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
        font = "JetBrainsMono Nerdfont Medium 10";
        location = "center";
theme = "./nord.rasi";
terminal = "foot";
extraConfig = {
show-icons = true;
dpi = 120;
# icon-theme = "Tela-circle-nord";
};
}
