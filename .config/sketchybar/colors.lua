local dark = {
	bar = {
		background = 0x00000000,
	},

	icon = {
		color = 0xff3a3a3c,
		highlight_color = 0xff1d1d1f,
		dimmed = 0xff8e8e93,
		warning = 0xffd79921,
		error = 0xffff453a,
		inverted = 0xffffffff,
	},

	label = {
		color = 0xff6e6e73,
		highlight_color = 0xff1d1d1f,

		dimmed = 0xff8e8e93,
		warning = 0xffd79921,
		error = 0xffff453a,
		inverted = 0xffffffff,
	},

	background = {
		color = 0xaaebebf0,
		highlight_color = 0xaaffffff,
		dimmed = 0x00000000,
	},

	border = {
		color = 0xffc7c7cc,
		highlight_color = 0xff8e8e93,
	},

	graph = {
		blue = 0xff0a84ff,
		green = 0xff30b158,
		yellow = 0xffd79921,
		orange = 0xffff9f0a,
		red = 0xffff453a,
		grey = 0xff8e8e93,
	},

	-- Per-space highlight background colors (selected state), light pastel theme
	space_highlight_colors = {
		0xaaffffff, -- space 1: white
		0xaaffffff, -- space 2: white
		0xaabdddff, -- space 3: soft blue
		0xaab5f0b5, -- space 4: soft green
		0xaaffedaa, -- space 5: soft yellow
		0xaaffdaaa, -- space 6: soft orange
		0xaaffb8b8, -- space 7: soft pink
		0xaad8b8ff, -- space 8: soft lavender
		0xaab8eeee, -- space 9: soft cyan
		0xaaffc8d8, -- space 10: soft rose
	},
}

return dark
