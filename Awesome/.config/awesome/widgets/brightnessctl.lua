local wibox = require 'wibox'
local gears = require 'gears'
local awful = require 'awful'
local beautiful = require 'beautiful'

local brightness_widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    {
        {

            widget = wibox.container.place,
            valign = 'center',
            halign = 'center',
            {
                widget = wibox.container.margin,
                margins = 5,
                {
                    id = 'arc',
                    colors = { beautiful.base0A },
                    forced_height = 18,
                    forced_width = 18,
                    max_value = 100,
                    thickness = 100,
                    start_angle = 4.71238898, -- 2pi*3/4
                    paddings = 2,
                    widget = wibox.container.arcchart,
                },
            },
        },
        {
            image = gears.color.recolor_image(
                gears.filesystem.get_configuration_dir() .. 'assets/brightness.svg',
                beautiful.base09
            ),
            resize = true,
            widget = wibox.widget.imagebox,
        },
        layout = wibox.layout.stack,
    },
    {
        id = 'text',
        widget = wibox.widget.textbox,
    },
    spacing = 8,
    change_value = function(self, change)
        local arc = self:get_children_by_id('arc')[1]
        local textbox = self:get_children_by_id('text')[1]
        local change_cmd
        if change < 0 then
            change_cmd = 'brightnessctl set ' .. -change .. '-%'
        else
            change_cmd = 'brightnessctl set +' .. change .. '%'
        end
        awful.spawn.easy_async(change_cmd, function()
            awful.spawn.easy_async('brightnessctl get', function(curr_abs)
                curr_abs = curr_abs:match '%d+'
                awful.spawn.easy_async('brightnessctl max', function(max)
                    max = max:match '%d+'
                    local perc = math.floor(curr_abs * 100 / max)
                    arc:set_value(perc)
                    textbox:set_markup(perc .. '%')
                end)
            end)
        end)
    end,
}

brightness_widget:change_value(0)

return brightness_widget
