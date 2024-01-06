{ config, pkgs, ... }:

{
  programs.wezterm = {
		enable = true;
		# local wezterm = require 'wezterm' is included by default int extra config
		extraConfig = "
				-- This table will hold the configuration.
				local config = {}

				-- In newer versions of wezterm, use the config_builder which will
				-- help provide clearer error messages
				if wezterm.config_builder then
					config = wezterm.config_builder()
				end

				-- config.default_cursor_style = 'SteadyBar' -- Set default cursor to not be a block

				--config.default_gui_startup_args = {}

				-- config.ssh_domains = {
				--   {
				--     -- This name identifies the domain
				--     name = 'my.server',
				--     -- The hostname or address to connect to. Will be used to match settings
				--     -- from your ssh config file
				--     remote_address = '192.168.1.1',
				-- 		multiplexing = 'None',
				--     -- The username to use on the remote host
				--     username = 'mason',
				--   },
				-- }
				--
				-- config.default_domain = 'my.server'

				-- This is where you actually apply your config choices

				-- For example, changing the color scheme:
				config.color_scheme = 'tokyonight'
				config.default_cursor_style = 'BlinkingBar'
				-- Window transparency // opacity
				-- config.window_background_opacity = 0.92

				config.hide_tab_bar_if_only_one_tab = true

				-- Don't prompt on close
				config.window_close_confirmation = 'NeverPrompt'

				-- Removing the weird window padding from terminal
				config.window_padding = {
					left = 0,
					right = 0,
					top = 0,
					bottom = 0,
				}
				config.animation_fps = 32
				config.font = wezterm.font 'Hack Nerd Font' -- Nerd font, glyps can be found on website

				-- Config for the window frame
				config.window_frame = {
					-- font = wezterm.font { family = 'Roboto', weight = 'Bold' },

					-- The size of the font in the tab bar.
					-- Default to 10. on Windows but 12.0 on other systems
					font_size = 12.0,

					-- The overall background color of the tab bar when
					-- the window is focused
					active_titlebar_bg = '#333333',

					-- The overall background color of the tab bar when
					-- the window is not focused
					inactive_titlebar_bg = '#333333',
				}

				config.colors = {
					tab_bar = {
						-- The active tab is the one that has focus in the window
						active_tab = {
							-- The color of the background area for the tab
							bg_color = '#1A1B26',
							-- The color of the text for the tab
							fg_color = '#c0c0c0',

							intensity = 'Normal',

							underline = 'None',

							-- Specify whether you want the text to be italic (true) or not (false)
							-- for this tab.  The default is false.
							italic = false,

							-- Specify whether you want the text to be rendered with strikethrough (true)
							-- or not for this tab.  The default is false.
							strikethrough = false,
						},

					-- The divider between tabs
					inactive_tab_edge = '#333333',

						-- Inactive tabs are the tabs that do not have focus
						inactive_tab = {
							bg_color = '#333333',
							fg_color = '#808080',

							-- The same options that were listed under the `active_tab` section above
							-- can also be used for `inactive_tab`.
						},

						-- You can configure some alternate styling when the mouse pointer
						-- moves over inactive tabs
						inactive_tab_hover = {
							bg_color = '#3b3052',
							fg_color = '#909090',
							italic = true,

							-- The same options that were listed under the `active_tab` section above
							-- can also be used for `inactive_tab_hover`.
						},

						-- The new tab button that let you create new tabs
						new_tab = {
							bg_color = '#333333',
							fg_color = '#808080',

							-- The same options that were listed under the `active_tab` section above
							-- can also be used for `new_tab`.
						},

						-- You can configure some alternate styling when the mouse pointer
						-- moves over the new tab button
						new_tab_hover = {
							bg_color = '#3b3052',
							fg_color = '#909090',
							italic = true,

							-- The same options that were listed under the `active_tab` section above
							-- can also be used for `new_tab_hover`.
						},
					},
				}

				-- and finally, return the configuration to wezterm
				return config
		";
	};
}
