local awful = require 'awful'
local wibox = require 'wibox'
local beautiful = require 'beautiful'

local green = beautiful.base0B
local cyan = beautiful.base0C
local blue = beautiful.base0D

local pipewire_widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = 5,
    {
        text = 'VOL',
        widget = wibox.widget.textbox,
    },
    {
        widget = wibox.container.margin,
        margins = 5,
        {
            id = 'arc',
            max_value = 100,
            thickness = 100,
            start_angle = 4.71238898, -- 2pi*3/4
            paddings = 2,
            widget = wibox.container.arcchart,
        },
    },
    change = function(self, delta)
        awful.spawn.easy_async(
            os.getenv 'HOME' .. '/.config/wireplumber/scripts/custom_mixer.lua delta=' .. delta,
            function(out)
                local arc = self:get_children_by_id('arc')[1]
                out = tonumber(out)
                arc:set_value(out)
                if out > 66 then
                    arc:set_colors { blue }
                elseif out > 33 then
                    arc:set_colors { cyan }
                else
                    arc:set_colors { green }
                end
            end
        )
    end,
    mute = function()
        awful.spawn 'wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'
    end,
}

pipewire_widget:change(0)
return pipewire_widget
