{
  config,
  lib,
  pkgs,
  ...
}:

{

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };
    };
    initrd.luks.devices.cryptroot.device = "/dev/disk/by-label/Encriptado";
  };

  networking.hostName = "duanos-luks"; # Define your hostname.

  security.sudo.extraRules = [
    {
      groups = [ "wheel" ];
      commands = [
        {
          command = "ALL";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    TERMINAL = "foot";
    BROWSER = "librewolf";
    MANPAGER = "nvim +Man!";
  };

  programs.less.envVariables = {
    LESS = "-R";
    LESS_TERMCAP_mb = "$(printf '%b' '[1;31m')";
    LESS_TERMCAP_md = "$(printf '%b' '[1;36m')";
    LESS_TERMCAP_me = "$(printf '%b' '[0m')";
    LESS_TERMCAP_so = "$(printf '%b' '[01;44;33m')";
    LESS_TERMCAP_se = "$(printf '%b' '[0m')";
    LESS_TERMCAP_us = "$(printf '%b' '[1;32m')";
    LESS_TERMCAP_ue = "$(printf '%b' '[0m')";
  };

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Argentina/Cordoba";

  # Select internationalisation properties.
  i18n.defaultLocale = "es_AR.UTF-8";
  console.keyMap = "es";

  # Configure keymap in X11
  services.xserver.xkb.layout = "es";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.displayManager.ly.enable = true;

  services.getty.autologinUser = "nixtane";

  programs.zsh.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nixtane = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    fastfetch
    git
    foot
    kitty
    hyprland
    swaybg
    waybar
    wget
    mpv
    neovim
    zsh
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.11"; # Did you read the comment?

}
