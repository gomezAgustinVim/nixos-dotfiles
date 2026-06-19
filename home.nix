{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./modules/themes/nord.nix
    ./modules/user/shell/zsh.nix
  ];

  home.username = "nixtane";
  home.homeDirectory = "/home/nixtane";
  home.stateVersion = "25.11";

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.packages = with pkgs; [
    dunst
    blueman
    networkmanagerapplet
    hypridle
    firefox
    fzf
    rofi
    gcc
    thunar
    yazi
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    fira-code
    fira-code-symbols
  ];

  programs.firefox.enable = true;
  programs.home-manager.enable = true; # enable thyself

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/foot".source = ./config/foot;
  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/yazi".source = ./config/yazi;
  home.file.".config/rofi".source = ./config/rofi;
  home.file.".config/waybar".source = ./config/waybar;

}
