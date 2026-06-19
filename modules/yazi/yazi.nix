{
  config,
  pkgs,
  ...
}:

{

  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    plugins = {
      git = {
        package = pkgs.yaziPlugins.git;
        setup = true;
      };
      rsync = pkgs.yaziPlugins.rsync;
      ouch = pkgs.yaziPlugins.ouch;
      full-border = pkgs.yaziPlugins.full-border;
      smart-enter = pkgs.yaziPlugins.smart-enter;
      smart-paste = pkgs.yaziPlugins.smart-paste;
    };

    flavors = {
      nord = pkgs.yaziPlugins.nord;
    };

    settings = {
      opener = {
        add-sub = [
          {
            run = "printf \"sub-add '%%s'\\n\" %s1 | socat - /tmp/mpv.sock";
            desc = "Add sub to mpv";
          }
        ];
      };

      open = {
        prepend_rules = [
          {
            url = "*.{ass,srt,ssa,sty,sup,vtt}";
            use = [
              "add-sub"
              "edit"
            ];
          }
        ];
      };
    };

    keymap = {
      manager.prepend_keymap = [
        {
          on = [ "b" ];
          run = "shell 'setbg.sh \"$1\"'";
          desc = "Seleccionar wallpaper";
        }
      ];

      mgr.prepend_keymap = [
        {
          on = "l";
          run = "plugin smart-enter";
          desc = "Enter the child directory, or open the file";
        }
        {
          on = "p";
          run = "plugin smart-paste";
          desc = "Paste into the hovered directory or CWD";
        }
        {
          on = [
            "g"
            "r"
          ];
          run = "shell 'ya emit cd \"$(git rev-parse --show-toplevel)\"'";
          desc = "cd back to the root of the current Git repository";
        }
        {
          on = [ "<C-g>" ];
          run = ''shell -- rofi -theme fullscreen-preview -show filebrowser -filebrowser-command "ya emit reveal" -filebrowser-directory "$(pwd)"'';
          desc = "Grid view";
        }
      ];
    };

    theme = {
      icon = {
        dirs = [
          {
            name = "Escritorio";
            text = "";
            fg = "#D8DEE9";
          }
          {
            name = "Descargas";
            text = "";
            fg = "#D8DEE9";
          }
          {
            name = "Vídeos";
            text = "";
            fg = "#D8DEE9";
          }
          {
            name = "Documentos";
            text = "";
            fg = "#D8DEE9";
          }
          {
            name = "Imágenes";
            text = "󰋵";
            fg = "#D8DEE9";
          }
          {
            name = "Música";
            text = "";
            fg = "#D8DEE9";
          }
          {
            name = "Público";
            text = "";
            fg = "#D8DEE9";
          }
          {
            name = "Proyectos";
            text = "";
            fg = "#D8DEE9";
          }
          {
            name = "Plantillas";
            text = "󰧨";
            fg = "#D8DEE9";
          }
        ];
      };
    };

    initLua = ''
            require("full-border"):setup({
            	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
            	type = ui.Border.PLAIN,
            })
            require("smart-enter"):setup {
      	        open_multi = false,
            }

                  -- symlinks in status bar
                  Status:children_add(function(self)
                      local h = self._current.hovered
                      if h and h.link_to then
                          return " -> " .. tostring(h.link_to)
                      else
                          return ""
                      end
                  end, 3300, Status.LEFT)

                  -- show user/group in status bar
                  Status:children_add(function()
                      local h = cx.active.current.hovered
                      if not h or ya.target_family() ~= "unix" then
                          return ""
                      end

                      return ui.Line({
                          ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
                          ":",
                          ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
                          " ",
                      })
                  end, 500, Status.RIGHT)
    '';
  };
}
