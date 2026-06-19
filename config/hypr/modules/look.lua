hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 5,

		border_size = 2,

		allow_tearing = false,

		-- Set to true enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,
		layout = "dwindle",

		col = {
			active_border = { colors = { "rgb(5e81ac)", "rgba(2e3440ff)", "rgba(eceff4aa)" }, angle = 45 },
			inactive_border = { colors = { "rgb(d8dee9)" } },
		},
	},

	decoration = {
		rounding = 0,
		rounding_power = 2,

		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 0.8,

		shadow = {
			enabled = false,
			range = 20,
			offset = { 0, 2 },
			render_power = 10,
			color = "rgba(00000020)",
		},

		blur = {
			enabled = false,
			size = 5,
			passes = 2,
			vibrancy = 0.5,
			xray = true,
			special = false,
			new_optimizations = true,
			brightness = 1,
			noise = 0.05,
			contrast = 0.89,
			vibrancy_darkness = 0.5,
			popups = false,
			popups_ignorealpha = 0.6,
			input_methods = true,
			input_methods_ignorealpha = 0.8,
		},
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_on_active = "after",
		mfact = 0.60,
	},
})

-- col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
-- col.inactive_border = rgba(595959aa)
