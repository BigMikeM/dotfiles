local wezterm = require("wezterm")
return {
	font = wezterm.font("MonoLisa Nerd Font"),
	-- color_scheme = "kanagawabones",
	color_scheme = "AyuMirage (Gogh)",
	harfbuzz_features = {
		"liga=1",
		"calt=1",
		"clig=1",
		"ss02=1",
		"zero=1",
		"ss07=1",
		"ss05=1",
		-- "ss08=1",
	},
	freetype_render_target = "HorizontalLcd",
	freetype_load_target = "HorizontalLcd",
	max_fps = 165,
	animation_fps = 60,
	cursor_blink_ease_in = "EaseIn",
	cursor_blink_ease_out = "EaseOut",
	audible_bell = "Disabled",
	prefer_egl = true,
	use_fancy_tab_bar = false,
	cursor_blink_rate = 800,
	custom_block_glyphs = false,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
}
