Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ""
	end
	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ": "):fg("blue")
end, 500, Header.LEFT)

Status:children_add(function()
	local h = cx.active.current.hovered
	if not h or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line({
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("white"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("white"),
		" ",
	})
end, 500, Status.RIGHT)

require("full-border"):setup({
	type = ui.Border.PLAIN,
})

-- ~/.config/yazi/init.lua
require("linemode-plus"):setup({
	-- Date formatting mode
	-- Available options:
	--   "default" - Yazi's native format with conditional year display:
	--               • For current year:     "MM/DD HH:mm"
	--               • For other years:      "MM/DD  YYYY"
	--
	--   "custom"  - smart user-defined format with today detection:
	--               • For today's files:     "HH:mm" (time only)
	--               • For older files:       Custom date format from 'custom' table
	--                 (configurable order, separator and year digits)
	date_mode = "custom",

	-- Custom format settings (only used when mode = "custom")
	custom = {
		-- Date components order
		-- MUST contain all three components: "year", "month", "day"
		-- Each component must appear exactly once (no duplicates)
		--
		-- All valid examples:
		--   { "year", "month", "day" }     -- year → month → day
		--   { "year", "day", "month" }     -- year → day → month
		--   { "month", "year", "day" }     -- month → year → day
		--   { "month", "day", "year" }     -- month → day → year
		--   { "day", "year", "month" }     -- day → year → month
		--   { "day", "month", "year" }     -- day → month → year
		order = { "month", "day", "year" },

		-- Separator between date components
		-- Allowed separators: "-", "/", "."  (only these characters are supported)
		--
		-- Examples:
		--   "-" -> 2026-02-20
		--   "/" -> 2026/02/20
		--   "." -> 2026.02.20
		separator = "/",

		-- Number of digits for the year:
		--   4 -> 2026 (full year)
		--   2 -> 26   (short year)
		year_digits = 4,
	},
})
