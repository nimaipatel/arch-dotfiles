local b = require 'beautiful'
local gears = require 'gears'
local xresources = require 'beautiful.xresources'
local dpi = xresources.apply_dpi

b.init(gears.filesystem.get_themes_dir() .. 'default/theme.lua')

for key, value in pairs(_G.BASE16_COLORS) do
    b[key] = value
end

local circle = function(color)
    return gears.surface.load_from_shape(20, 20, gears.shape.circle, color)
end

local sticky_active_btn = circle(b.base07)
local sticky_inactive_btn = circle(b.base03)
b.titlebar_sticky_button_normal_inactive = sticky_inactive_btn
b.titlebar_sticky_button_focus_inactive = sticky_inactive_btn
b.titlebar_sticky_button_normal_active = sticky_active_btn
b.titlebar_sticky_button_focus_active = sticky_active_btn

local close_btn = circle(b.base08)
b.titlebar_close_button_normal = close_btn
b.titlebar_close_button_focus = close_btn

local minimize_btn = circle(b.base0A)
b.titlebar_minimize_button_normal = minimize_btn
b.titlebar_minimize_button_focus = minimize_btn

local maximized_btn = circle(b.base0B)
b.titlebar_maximized_button_normal_active = maximized_btn
b.titlebar_maximized_button_focus_active = maximized_btn
b.titlebar_maximized_button_normal_inactive = maximized_btn
b.titlebar_maximized_button_focus_inactive = maximized_btn

b.font = 'monospace 18'
b.hotkeys_font = b.font
b.hotkeys_description_font = b.font
b.menu_font = b.font
b.menu_height = 30
b.menu_width = 300
b.useless_gap = 10

b.bg_normal = b.base00
b.bg_focus = b.base01
b.bg_urgent = b.base08
b.bg_minimize = b.base0A
b.bg_systray = b.bg_normal

b.fg_normal = b.base07
b.fg_focus = b.base07
b.fg_urgent = b.base00
b.fg_minimize = b.base00

b.useless_gap = dpi(5)
b.border_width = dpi(1)
b.border_normal = b.bg_normal
b.border_focus = b.bg_focus
b.border_marked = b.base08

b.systray_icon_spacing = dpi(10)


b.modalbind_font = b.font
b.modebox_fg = b.fg_normal
b.modebox_bg = b.bg_normal
b.modebox_border = b.border_focus
b.modebox_border_width = 5

b.menu_border_color = b.border_focus
b.menu_border_width = 2
