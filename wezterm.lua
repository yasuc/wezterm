local wezterm = require("wezterm")
local mux = wezterm.mux
local act = wezterm.action
local wsl_domains = wezterm.default_wsl_domains()

for idx, dom in ipairs(wsl_domains) do
	dom.default_cwd = "~"
end

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#5c6d74"
	local foreground = "#FFFFFF"
	local edge_background = "none"
	if tab.is_active then
		background = "#ae8b2d"
		foreground = "#FFFFFF"
	end
	local edge_foreground = background
	local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

wezterm.on("trigger-nvim-with-scrollback", function(window, pane)
	local scrollback = pane:get_lines_as_text()
	local name = os.tmpname()
	local f = io.open(name, "w+")
	f:write(scrollback)
	f:flush()
	f:close()
	window:perform_action(
		wezterm.action({ SpawnCommandInNewTab = {
			args = { "/opt/homebrew/bin/nvim", name },
		} }),
		pane
	)
	wezterm.sleep_ms(1000)
	os.remove(name)
end)

return {
	wsl_domains = wsl_domains,
	font = wezterm.font("Moralerspace Neon HWNF"),
	use_ime = true,
	font_size = 15.0,
	line_height = 1.1,
	color_scheme = "Tokyo Night",
	adjust_window_size_when_changing_font_size = false,
	window_close_confirmation = "NeverPrompt",
	window_background_opacity = 0.8,
	macos_window_background_blur = 20,
	window_decorations = "RESIZE",
	use_cap_height_to_scale_fallback_fonts = true,
	show_tabs_in_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	window_frame = {
		inactive_titlebar_bg = "none",
		active_titlebar_bg = "none",
	},
	window_background_gradient = {
		colors = { "#000000" },
	},
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	-- show_close_tab_button_in_tabs = false,

	colors = {
		cursor_bg = "#c6c8d1",
		tab_bar = {
			inactive_tab_edge = "none",
		},
	},
	max_fps = 120,
	prefer_egl = true,
	leader = { key = "q", mods = "CTRL", timeout_milliseconds = 2000 },
	keys = {
		{ key = "E", mods = "ALT", action = wezterm.action({ EmitEvent = "trigger-nvim-with-scrollback" }) },
		{ key = "l", mods = "SHIFT|CTRL", action = "ShowDebugOverlay" },
		{ key = ";", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Next") },
		{ key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
		{
			-- workspaceの切り替え
			key = "w",
			mods = "LEADER",
			action = act.ShowLauncherArgs({ flags = "WORKSPACES", title = "Select workspace" }),
		},
		{
			--workspaceの名前変更
			key = "$",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = "(wezterm) Set workspace title:",
				action = wezterm.action_callback(function(win, pane, line)
					if line then
						wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line)
					end
				end),
			}),
		},
		{
			key = "W",
			mods = "LEADER|SHIFT",
			action = act.PromptInputLine({
				description = "(wezterm) Create new workspace:",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:perform_aciton(
							act.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},
	},
}
