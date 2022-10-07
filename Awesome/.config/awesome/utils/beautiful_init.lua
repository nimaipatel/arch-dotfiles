require 'base16'
require 'opacity'
local gears = require 'gears'
local opacity = _G['OPACITY']
local beautiful = require 'beautiful'
local naughty = require 'naughty'
local xresources = require 'beautiful.xresources'
local dpi = xresources.apply_dpi

beautiful.init(gears.filesystem.get_themes_dir() .. 'default/theme.lua')

for key, value in pairs(_G.BASE16_COLORS) do
    beautiful[key] = value
end

local circle = function(color)
    return gears.surface.load_from_shape(20, 20, gears.shape.circle, color)
end

beautiful.notification_shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, 10)
end

local unfocused_button = circle(beautiful.base02)

local close_btn = circle(beautiful.base08)
beautiful.titlebar_close_button_normal = unfocused_button
beautiful.titlebar_close_button_focus = close_btn

local minimize_btn = circle(beautiful.base0A)
beautiful.titlebar_minimize_button_normal = unfocused_button
beautiful.titlebar_minimize_button_focus = minimize_btn

local maximized_btn = circle(beautiful.base0B)
beautiful.titlebar_maximized_button_normal_active = unfocused_button
beautiful.titlebar_maximized_button_focus_active = maximized_btn
beautiful.titlebar_maximized_button_normal_inactive = unfocused_button
beautiful.titlebar_maximized_button_focus_inactive = maximized_btn

local ontop_arrow                               = gears.filesystem.get_configuration_dir() .. 'assets/ontop-arrow.svg'
local ontop_arrow_colored                       = gears.color.recolor_image(ontop_arrow, beautiful.base0E)
local ontop_arrow_grayed                        = gears.color.recolor_image(ontop_arrow, beautiful.base02)
beautiful.titlebar_ontop_button_normal_active   = ontop_arrow_colored
beautiful.titlebar_ontop_button_normal_inactive = ontop_arrow_grayed
beautiful.titlebar_ontop_button_focus_active    = ontop_arrow_colored
beautiful.titlebar_ontop_button_focus_inactive  = ontop_arrow_grayed

local sticky_pin                                 = gears.filesystem.get_configuration_dir() .. 'assets/sticky-pin.svg'
local sticky_pin_colored                         = gears.color.recolor_image(sticky_pin, beautiful.base0D)
local sticky_pin_grayed                          = gears.color.recolor_image(sticky_pin, beautiful.base02)
beautiful.titlebar_sticky_button_normal_active   = sticky_pin_colored
beautiful.titlebar_sticky_button_normal_inactive = sticky_pin_grayed
beautiful.titlebar_sticky_button_focus_active    = sticky_pin_colored
beautiful.titlebar_sticky_button_focus_inactive  = sticky_pin_grayed

beautiful.font = 'sans-serif 14'
beautiful.hotkeys_font = beautiful.font
beautiful.hotkeys_description_font = beautiful.font
beautiful.menu_font = beautiful.font
beautiful.menu_height = 30
beautiful.menu_width = 300

local opacity_hex = string.format('%x', math.floor(opacity * 255))
beautiful.bg_normal = beautiful.base01 .. opacity_hex
beautiful.bg_focus = beautiful.base00 .. opacity_hex
beautiful.bg_urgent = beautiful.base08 .. opacity_hex
beautiful.bg_minimize = beautiful.base0A .. opacity_hex
beautiful.bg_systray = beautiful.bg_normal .. opacity_hex

beautiful.wibar_bg = beautiful.base00 .. opacity_hex

beautiful.taglist_bg_focus = beautiful.base01 .. opacity_hex

beautiful.titlebar_bg_normal = beautiful.bg_focus
beautiful.titlebar_bg_focus = beautiful.bg_focus

beautiful.tasklist_bg_normal = beautiful.base01 .. opacity
beautiful.tasklist_bg_focus = beautiful.base04
beautiful.tasklist_bg_urgent = beautiful.base08
beautiful.tasklist_bg_minimize = beautiful.base0A

beautiful.fg_normal = beautiful.base07
beautiful.fg_focus = beautiful.base07
beautiful.fg_urgent = beautiful.base00
beautiful.fg_minimize = beautiful.base00

beautiful.useless_gap = dpi(5)
beautiful.border_width = dpi(0)
beautiful.border_normal = beautiful.bg_normal
beautiful.border_focus = beautiful.bg_focus
beautiful.border_marked = beautiful.base08

beautiful.systray_icon_spacing = dpi(10)

beautiful.modalbind_font = beautiful.font
beautiful.modebox_fg = beautiful.fg_normal
beautiful.modebox_bg = beautiful.bg_normal
beautiful.modebox_border = beautiful.border_focus
beautiful.modebox_border_width = 5

beautiful.menu_border_color = beautiful.border_focus
beautiful.menu_border_width = 2

naughty.config.padding = dpi(50)
naughty.config.spacing = dpi(10)
naughty.config.defaults.margin = dpi(16)
naughty.config.defaults.position = 'bottom_right'
naughty.config.presets.low.fg = beautiful.base00
naughty.config.presets.normal.fg = beautiful.base07
naughty.config.presets.critical.fg = beautiful.base00
naughty.config.presets.low.bg = beautiful.base0B
naughty.config.presets.normal.bg = beautiful.base03
naughty.config.presets.critical.bg = beautiful.base08

local layouts = {
    'layout_fairh',
    'layout_fairv',
    'layout_floating',
    'layout_magnifier',
    'layout_max',
    'layout_fullscreen',
    'layout_tilebottom',
    'layout_tileleft',
    'layout_tile',
    'layout_tiletop',
    'layout_spiral ',
    'layout_dwindle',
    'layout_cornernw',
    'layout_cornerne',
    'layout_cornersw',
    'layout_cornerse',
}

for _, layout in ipairs(layouts) do
    beautiful[layout] = gears.color.recolor_image(beautiful[layout], beautiful.base04)
end
