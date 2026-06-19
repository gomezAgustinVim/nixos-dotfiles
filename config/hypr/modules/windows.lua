hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Tags
hl.window_rule({ match = { class = "mpv" }, tag = "+video" })
hl.window_rule({ match = { class = "Nsxiv" }, tag = "img" })
hl.window_rule({ match = { class = "^.*(zathura)$" }, tag = "+pdf" })
hl.window_rule({ match = { class = "firefox" }, tag = "+browser" })
hl.window_rule({ match = { class = "librewolf" }, tag = "+browser" })

-- GUI
hl.window_rule({ match = { class = "^(blue).*$" }, tag = "+gui" })
hl.window_rule({ match = { class = "^(calibre).*$" }, tag = "+gui" })
hl.window_rule({ match = { class = "gcr-prompter" }, tag = "+gui" })
hl.window_rule({ match = { class = "codium" }, tag = "+gui" })
hl.window_rule({ match = { class = "nwg-look" }, tag = "+gui" })
hl.window_rule({ match = { class = "^(pcmanfm).*$" }, tag = "+gui" })
hl.window_rule({ match = { class = ".*(fcitx5-config-qt)$" }, tag = "+gui" })
hl.window_rule({ match = { class = "^.*(pavucontrol)$" }, tag = "+gui" })
hl.window_rule({ match = { class = "gimp" }, tag = "+gui" })
hl.window_rule({ match = { class = "anki" }, tag = "+gui" })
hl.window_rule({ match = { class = "^(file).*$" }, tag = "+gui" })
hl.window_rule({ match = { class = "^.*(mGBA).*$" }, tag = "+gui" })
hl.window_rule({ match = { class = "^(libreoffice)-*$" }, tag = "+gui" })
hl.window_rule({ match = { class = "electron" }, tag = "+gui" })
hl.window_rule({ match = { class = "obsidian" }, tag = "+gui" })
hl.window_rule({ match = { class = "^.*(Nicotine)$" }, tag = "+gui" })
hl.window_rule({ match = { class = "steam" }, tag = "+gui" })
hl.window_rule({ match = { class = "xdg-desktop-portal-gtk" }, tag = "+gui" })
hl.window_rule({ match = { class = "^([Vv]irt.*)" }, tag = "+gui" })
hl.window_rule({ match = { class = "filezilla" }, tag = "+gui" })

-- Float
hl.window_rule({
	name = "apply-video",
	match = {
		tag = "video",
	},
	opacity = "1.0 override",
	no_blur = true,
	float = true,
	center = true,
	content = "video",
	max_size = { 849, 477 },
})

hl.window_rule({ match = { tag = "gui", float = true } })

-- Sizes
-- hl.window_rule({match = {tag = "img"}, max_size = { 849, 477 }})
hl.window_rule({ match = { tag = "img" }, float = true })

-- Opacity and blur
hl.window_rule({ match = { tag = "img" }, float = true, opacity = "1.0 override", no_blur = true })
hl.window_rule({ match = { tag = "browser" }, opacity = "1.0 override", no_blur = true })
hl.window_rule({ match = { tag = "gui" }, opacity = "1.0 override" })
hl.window_rule({ match = { tag = "pdf" }, opacity = "1.0 override" })

hl.window_rule({ match = { class = ".*(KeePassXC)$" }, opacity = "1.0 override" })
hl.window_rule({ match = { title = "Transmission" }, opacity = "1.0 override" })

-- Fix pinentry losing focus
hl.window_rule({
	match = { class = "(pinentry-)(.*)" },
	stay_focused = true,
})

-- Workspace 1
hl.window_rule({ match = { class = "firefox" }, workspace = "1 silent" })

-- Worspace 3
hl.window_rule({ match = { class = "librewolf" }, workspace = "3 silent" })
hl.window_rule({ match = { class = "steam" }, workspace = "3 silent" })

-- Workspace 4
hl.window_rule({ match = { class = "code-oss" }, workspace = "4 silent" })
hl.window_rule({ match = { class = "anki" }, workspace = "4" })
hl.window_rule({ match = { class = "^([Vv]irt.*)" }, workspace = "4 silent" })

-- Workspace 5
hl.window_rule({ match = { class = ".*(KeePassXC)$" }, workspace = "5" })

-- Workspace 6
hl.window_rule({ match = { class = "gimp" }, workspace = "6 silent" })
hl.window_rule({ match = { class = "filezilla" }, workspace = "6 silent" })

-- Workspace 7
hl.window_rule({ match = { class = "^.*(obsproject).*" }, workspace = "7" })

-- Workspace 8
hl.window_rule({ match = { class = "^.*(Nicotine)$" }, workspace = "8 silent" })

-- Workspace 10
hl.window_rule({ match = { title = "^(Transmission)$" }, workspace = "10 silent" })
