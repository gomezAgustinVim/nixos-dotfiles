hl.config({
	input = {
		kb_layout = "es",
		kb_model = "",
		kb_variant = ",qwerty",
		kb_options = "caps:escape_shifted_capslock,altwin:menu_win", -- make caps lock an additional esc, but shift + caps lock is the regular caps lock
		numlock_by_default = true,

		-- Delay before a held-down key is repeated, in milliseconds.
		repeat_delay = 300,
		repeat_rate = 50,

		follow_mouse = 1,

		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

		touchpad = {
			natural_scroll = false,
			disable_while_typing = true,
			tap_and_drag = true,
			clickfinger_behavior = true,
			tap_to_click = true,
		},

		-- gestures = {
		-- 	workspace_swipe_distance = 700,
		-- 	workspace_swipe_cancel_ratio = 0.2,
		-- 	workspace_swipe_min_speed_to_force = 5,
		-- 	workspace_swipe_direction_lock = true,
		-- 	workspace_swipe_direction_lock_threshold = 10,
		-- 	workspace_swipe_create_new = true,
		-- },
	},
})

hl.device({
	name = "duan-mouse",
	sensitivity = -0.5,
})
