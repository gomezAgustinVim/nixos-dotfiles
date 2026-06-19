local terminal = "foot"
local fileManager = "Thunar"
local menu = 'rofi -show combi -combi-modes "drun,ssh" -modes combi'
local mainMod = "SUPER"
local browser = "firefox"

hl.bind(
	mainMod .. " + Q",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.kill())
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + A", hl.dsp.layout("togglesplit"))

-- Invocación global de tmux sessionizer
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("tmux-sessionizer.sh"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("session-finder.sh"))

-- Mount android device
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("aft-mtp-mount ~/Público"))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("umount ~/Público"))

-- Reiniciar Waybar
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("sh ~/.config/hypr/scripts/start-waybar.sh"))

-- Copy emoji
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("rofi -show emoji"))

-- Change wallpaper at random
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("swbg.sh"))

hl.bind(mainMod .. " + ALT + A", hl.dsp.exec_cmd("anki"))
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + ALT + G", hl.dsp.exec_cmd("gimp"))
hl.bind(mainMod .. " + ALT + N", hl.dsp.exec_cmd("nicotine"))
hl.bind(mainMod .. " + ALT + T", hl.dsp.exec_cmd("transmission-qt"))
hl.bind(mainMod .. " + ALT + F", hl.dsp.exec_cmd("filezilla"))
hl.bind(mainMod .. " + ALT + K", hl.dsp.exec_cmd("keepassxc"))
hl.bind(mainMod .. " + ALT + V", hl.dsp.exec_cmd("virt-manager"))
hl.bind(mainMod .. " + ALT + C", hl.dsp.exec_cmd("code"))
hl.bind(mainMod .. " + ALT + O", hl.dsp.exec_cmd("obs"))
hl.bind(mainMod .. " + ALT + M", hl.dsp.exec_cmd(terminal .. " ncmpcpp"))
hl.bind(mainMod .. " + ALT + H", hl.dsp.exec_cmd(terminal .. " htop"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Move windows use on master/dwindle
hl.bind(mainMod .. " + CTRL + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + l", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + j", hl.dsp.window.move({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
-- Move active window to a workspace quietly
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1.3 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -q -e set +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -q -e set 5%-"), { locked = true, repeating = true })
hl.bind("XF86Calculator", hl.dsp.exec_cmd("rofi -show calc -no-show-match -no-sort"))

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Manejar dunst

-- close topmost notification
hl.bind("CTRL + SHIFT + SPACE", hl.dsp.exec_cmd("dunstctl close"))

-- close all notifications currently being dis
hl.bind("CTRL + ALT + SPACE", hl.dsp.exec_cmd("dunstctl close-all"))

hl.bind("CTRL + period", hl.dsp.exec_cmd("dunstctl history-pop"))

-- Utility
-- Ask for zathura theme
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("chosen_zathura_theme.sh"))

-- Screenshot keybindings NOTE: You may need to press Fn key as well
hl.bind("Print", hl.dsp.exec_cmd("screenshot.sh"))

hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("swaylock -f"))

-- con esto logramos que los binds de hyprland pasen a una VM
-- basicamente se togglea con super + escape
hl.define_submap("passthru", function()
	hl.bind(mainMod .. " + Escape", hl.dsp.submap("reset"))
end)
hl.bind(mainMod .. " + Escape", hl.dsp.submap("passthru"))
