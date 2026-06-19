{
  config,
  lib,
  pkgs,
  ...
}:

{
    programs.firefox = {
        enable = true;
        languagePacks = [
            "es-AR"
            "ja-JP"
            "en-US"
        ];
        profiles.duan = {

            extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
                ublock-origin
                darkreader
                yomitan
                keepassxc
            ];
        }
    }
}
