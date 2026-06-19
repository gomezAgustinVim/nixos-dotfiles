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
    ./modules/user/yazi/yazi.nix
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
  programs.git = {
    enable = true;
    userName = "gomezAgustinVim";
    userEmail = "niconecrofilo589@gmail.com";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
      s = "status";
    };
    signing = {
      key = "ssh-ed25519
          AAAAC3NzaC1lZDI1NTE5AAAAIN2s61xEV3fUCNYVI01psi5g+CNFsusWoFi9zBE5lR7A
          niconecrofilo589@gmail.com";
      signByDefault = true;
    };
    settings = {
      gpg = {
        format = "ssh";
      };
    };
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/foot".source = ./config/foot;
  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/rofi".source = ./config/rofi;
  home.file.".config/waybar".source = ./config/waybar;

}
