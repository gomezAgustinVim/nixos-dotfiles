{ config, pkgs, ... }:

{
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.gpg-agent = {
    enable = true;
    pinentryFlavor = "qt";
    enableZshIntegration = true;
    pinentry.program = pkgs.pinentry-qt;
  };
}
