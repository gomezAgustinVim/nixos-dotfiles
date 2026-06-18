{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "nixtane";
  home.homeDirectory = "/home/nixtane";
  home.stateVersion = "25.11";

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.packages = with pkgs; [
    dunst
    starship
    hypridle
    librewolf
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

  programs.librewolf.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    configPath = "${config.xdg.configHome}/zsh/starship.toml";
    presets = [
      "gruvbox-rainbow"
    ];
  };

  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    dotDir = "${config.xdg.configHome}/zsh";

    # opciones de historial
    history = {
      size = 5000;
      save = 5000;
      ignoreSpace = true;
      ignoreAllDups = true;
      saveNoDups = true;
      ignoreDups = true;
      share = true;
      path = "$HOME/.local/state/zsh/history";
    };

    sessionVariables = {
      HISTORY_IGNORE = "(ls|cd|pwd|exit|sudo reboot|sudo sdn|sdn|history|cd -|cd ..)";
      SUDO_PROMPT = "Cual es tu contraseña %u?. Sos duan o que nwn: ";
      KEYTIMEOUT = 1;
      HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE = 1;
    };

    initContent =
      let
        ZshExtraFirstConfig = lib.mkOrder 500 ''
          # Evitar que la terminal se congele con Ctrl+S y Ctrl+Q
          stty stop undef
          stty start undef
        '';

        # configuracion general es init extra
        zhsConfig = lib.mkOrder 1000 ''
             autoload -Uz compinit
             autoload -U colors && colors
             autoload -Uz add-zsh-hook
             autoload -Uz vcs_info
             precmd () { vcs_info }

             _comp_options+=(globdots)

             # Efecto visual de los tres puntitos al tabular
               expand-or-complete-with-dots() {
                 echo -n "\e[31m…\e[0m"
                 zle expand-or-complete
                 zle redisplay
             }

            zle -N expand-or-complete-with-dots
            bindkey "^I" expand-or-complete-with-dots

            # vi mode
            bindkey -v

            # Change cursor shape for different vi modes.
            function zle-keymap-select () {
              case $KEYMAP in
                vicmd) echo -ne '\e[1 q' ;;      # block
                viins|main) echo -ne '\e[5 q' ;; # beam
            esac
          }

            zle -N zle-keymap-select

            function zle-beam-init () {
            zle -K viins
            echo -ne '\e[5 q'
           }

            zle -N zle-beam-init
            echo -ne '\e[5 q' # Use beam shape cursor on startup.
            preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor on startup.

            # vim binds
            # ^? y ^H son backspace dependiendo de la terminal
            bindkey '^?' backward-delete-char
            bindkey '^H' backward-delete-char

            # ^[[3~ es tecla suprimir
            # Edit line in vim with ctrl-e:
            autoload edit-command-line; zle -N edit-command-line
            bindkey '^e' edit-command-line
            bindkey -M vicmd '^?' vi-delete-char
            bindkey -M vicmd '^H' vi-delete-char
            bindkey -M visual '^?' vi-delete
            bindkey -M visual '^H' vi-delete

            # command not found
            command_not_found_handler() {
              printf "%s%s? QUE VERGA ES ESTE COMANDO PEDAZO DE DUAN NWN\n" "$acc" "$0" >&2
              return 127
            }

             # other binds

             # ^[[A es flecha arriba
             # ^[[B es flecha abajo
             bindkey '^[[A' history-substring-search-up # or '\eOA'
             bindkey '^[[B' history-substring-search-down # or '\eOB'

             # bindkey -s '^f' 'con\n'

             # Opciones generales de comportamiento
             setopt interactive_comments
             setopt PROMPT_SUBST
             setopt MENU_COMPLETE
             setopt LIST_PACKED
             setopt AUTO_LIST
             setopt COMPLETE_IN_WORD

             # Opciones adicionales de historial que no tienen flag nativo directo en HM
             setopt appendhistory
             setopt hist_find_no_dups

             zstyle ':completion:*' verbose true
             zstyle ':completion:*:*:*:*:*' menu select
             zstyle ':completion:*' matcher-list \
                 'm:{a-zA-Z}={A-Za-z}' \
                 '+r:|[._-]=* r:|=*' \
                 '+l:|=*'
             zstyle ':completion:*:warnings' format "%B%F{red}No hay matches para:%f %F{magenta}%d%b"
             zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
             zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'

        '';

      in
      lib.mkMerge [
        ZshExtraFirstConfig
        zhsConfig
      ];

    shellAliases = {
      ll = "ls -l";
      update-home = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#duanos-luks";
      update-system = "sudo nixos-rebuild switch";
      clean = "nix-collect-garbage -d";
      v = "nvim";

      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -vI";
      mkd = "mkdir -pv";
      rmd = "rmdir -v";
      du = "du -h";
      rs = "rsync -Pa";
      fm = "pcmanfm > /dev/null 2>&1 &";

      # color support
      ls = "ls -hN --color=auto --group-directories-first";
      dir = "dir --color=auto";
      vdir = "vdir --color=auto";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";
      diff = "diff --color=auto";
      fclist = "fc-list -f '%{file}\n'";
      ip = "ip --color=auto";

      # abbreviations
      z = "zathura";
      ka = "killall";
      g = "git status";
      gm = "git commit -m";
      gp = "git push";
      gb = "git branch";
      gic = "git checkout";
      df = "df -lH";
      f = "fastfetch";
      h = "htop";
      tcopy = "wl-copy --trim-newline";
      pcopy = "pwd | wl-copy --trim-newline";
      dopdf = "lowriter --headless --convert-to pdf ";
      src = "source ~/.config/zsh/.zshrc && echo 'sourceado nwn!'";

    };

    envExtra = ''
      export EDITOR="nvim"
      export VISUAL="nvim"
      export TERMINAL="foot"
      export BROWSER="firefox"
      export MANPAGER='nvim +Man!'

      export XINITRC="''${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
      export NOTMUCH_CONFIG="$XDG_CONFIG_HOME/notmuch-config"
      export XMODIFIERS=@im=fcitx5
      export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
      export INPUTRC="''${XDG_CONFIG_HOME:-$HOME/.config}/shell/inputrc"
      export GNUPGHOME="$XDG_DATA_HOME/gnupg"
      export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
      export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
      export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
      export CARGO_HOME="$XDG_DATA_HOME/cargo"
      export GOPATH="$XDG_DATA_HOME/go"
      export GOMODCACHE="$XDG_CACHE_HOME/go/mod"
      export ANSIBLE_CONFIG="$XDG_CONFIG_HOME/ansible/ansible.cfg"
      export UNISON="$XDG_DATA_HOME/unison"
      export MBSYNCRC="$XDG_CONFIG_HOME/mbsync/config"
      export ELECTRUMDIR="$XDG_DATA_HOME/electrum"
      export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
      export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
      export STARSHIP_CONFIG="$ZDOTDIR/starship.toml"

    '';

    profileExtra = ''
      	if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      	  exec hyprland
      	fi
    '';

  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/waybar".source = ./config/waybar;
  home.file.".config/foot".source = ./config/foot;
  home.file.".config/nvim".source = ./config/nvim;
  home.file.".config/yazi".source = ./config/yazi;
  home.file.".config/rofi".source = ./config/rofi;

}
