{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    starship
    killall
    unar
    zip
  ];

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

        ZshConfig = lib.mkOrder 1000 ''

          autoload -U colors && colors	# Load colors

          setopt interactive_comments
          setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
          setopt LIST_PACKED		   # The completion menu takes less space.
          setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
          setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
          setopt appendhistory

          source <(fzf --zsh)
          bindkey '^R' fzf-history-widget

          # Basic auto/tab complete:
          autoload -Uz compinit

          compinit -C -d ~/.cache/zsh/zcompdump

          autoload -Uz add-zsh-hook
          _comp_options+=(globdots)

          zstyle ':completion:*' verbose true
          zstyle ':completion:*:*:*:*:*' menu select
          zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS} 'ma=48;5;197;1'
          zstyle ':completion:*' matcher-list \
              'm:{a-zA-Z}={A-Za-z}' \
              '+r:|[._-]=* r:|=*' \
              '+l:|=*'
          zstyle ':completion:*:warnings' format "%B%F{red}No hay matches para:%f %F{magenta}%d%b"
          zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'

          expand-or-complete-with-dots() {
              echo -n "\e[31m…\e[0m"
              zle expand-or-complete
              zle redisplay
          }

          zle -N expand-or-complete-with-dots
          bindkey "^I" expand-or-complete-with-dots # ^I es tab

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

          con() {
              cd ~/nixos-dotfiles/config || exit
              selected_file=$(fzf --color="light") || return # Return if no selection
              cd "$(dirname "$selected_file")" || exit
              $EDITOR "$(basename "$selected_file")" # Open the file
          }

          se() {
              cd ~/.local/bin || exit
              $EDITOR "$(fzf --color="light")"
          }

          function y() {
            local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
            command yazi "$@" --cwd-file="$tmp"
            IFS= read -r -d ' ' cwd < "$tmp"
            [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
            command rm -f -- "$tmp"
          }

          # ^[[A es flecha arriba
          # ^[[B es flecha abajo
          bindkey '^[[A' history-substring-search-up # or '\eOA'
          bindkey '^[[B' history-substring-search-down # or '\eOB'

          bindkey -s '^o' 'y\n'
          bindkey -s '^f' 'con\n'
          bindkey -s '^s' 'se\n'

          # Configuración manual de git status
          autoload -Uz vcs_info
          precmd () { vcs_info }

          zstyle ':vcs_info:*'     enable git
          zstyle ':vcs_info:git:*' check-for-changes true
          zstyle ':vcs_info:git:*' unstagedstr '%F{red}[✘!]%f'
          zstyle ':vcs_info:git:*' stagedstr '%F{green}[✘+]%f'
          zstyle ':vcs_info:git:*' formats       'on %F{magenta} %b %u%c%f'
          zstyle ':vcs_info:git:*' actionformats 'on %F{magenta} %b %u%c% %af'

          setopt PROMPT_SUBST        # enable command substitution in prompt

          NEWLINE=$'\n'
          PROMPT='%F{cyan}󰣇 %B%F{red}%1~%f%b ''${vcs_info_msg_0_}''${NEWLINE}%B%F{green}>%b%f '
          RPROMPT='%F{255}%B%*%b%f'

          # source "$ZDOTDIR/pnpm.zsh"

          eval "$(starship init zsh)"

        '';
      in
      lib.mkMerge [
        ZshExtraFirstConfig
        ZshConfig
      ];

    shellAliases = {
      ll = "ls -l";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#duanos-luks";
      # update-system = "sudo nixos-rebuild switch";
      ncg = "nix-collect-garbage -d";
      v = "nvim";

      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -vI";
      mkd = "mkdir -pv";
      rmd = "rmdir -v";
      du = "du -h";
      rs = "rsync -Pa";
      fm = "thunar > /dev/null 2>&1 &";

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
      # Add all directories in `~/.local/bin` to $PATH
      export PATH="$HOME/.local/bin:$PATH"
      unsetopt PROMPT_SP 2>/dev/null

      export EDITOR="nvim"
      export VISUAL="nvim"
      export TERMINAL="foot"
      export BROWSER="firefox"
      export MANPAGER='nvim +Man!'

      export GPG_TTY=$(tty)

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

      # Other program settings:
      export DICS="/usr/share/stardict/dic/"
      export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"

      export MOZ_USE_XINPUT2="1" # Mozilla smooth scrolling/touchpads.
      export ELECTRON_OZONE_PLATFORM_HINT=auto
      export AWT_TOOLKIT="MToolkit wmname LG3D" #May have to install wmname
      export _JAVA_AWT_WM_NONREPARENTING=1      # Fix for Java applications in dwm

      # FNM EXPORTS
      export PATH="/run/user/1000/fnm_multishells/3940_1747971854898/bin":$PATH
      export FNM_MULTISHELL_PATH="/run/user/1000/fnm_multishells/3940_1747971854898"
      export FNM_VERSION_FILE_STRATEGY="local"
      export FNM_DIR="/home/utane/.local/share/fnm"
      export FNM_LOGLEVEL="info"
      export FNM_NODE_DIST_MIRROR="https://nodejs.org/dist"
      export FNM_COREPACK_ENABLED="false"
      export FNM_RESOLVE_ENGINES="true"
      export FNM_ARCH="x64"
    '';

    profileExtra = ''
      	if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
      	  exec hyprland
      	fi
    '';

  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    configPath = "${config.xdg.configHome}/zsh/starship.toml";
    presets = [
      "gruvbox-rainbow"
    ];
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

}
