{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./modules/themes/nord.nix
    ./modules/shell/zsh.nix
    ./modules/yazi/yazi.nix
    ./modules/firefox/firefox.nix
    ./modules/foot/foot.nix
    ./modules/gpg/gpg.nix
    ./modules/rofi/rofi.nix
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
    gnupg
    tmux
    fzf
    rofi
    gcc
    thunar
    yazi
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.fira-code
    fira-code-symbols
  ];

  programs.home-manager.enable = true; # enable thyself
  programs.tmux.enable = true;
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
  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/waybar".source = ./config/waybar;
  home.file.".config/tmux".source = ./config/tmux;

}
