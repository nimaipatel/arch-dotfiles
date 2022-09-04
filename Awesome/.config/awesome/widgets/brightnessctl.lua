local wibox = require 'wibox'
local gears = require 'gears'
local awful = require 'awful'

local brightness_widget = wibox.widget {
    {
        {
            image = gears.color.recolor_image(
                gears.filesystem.get_configuration_dir() .. 'assets/brightness.svg',
                BASE16_COLORS.base09
            ),
            resize = true,
            widget = wibox.widget.imagebox,
        },
        valign = 'center',
        layout = wibox.container.place,
    },
    colors = { BASE16_COLORS.base0A },
    max_value = 100,
    thickness = 2,
    start_angle = 4.71238898, -- 2pi*3/4
    paddings = 2,
    widget = wibox.container.arcchart,
    change_value = function(self, change)
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
                    self:set_value((curr_abs * 100) / max)
                end)
            end)
        end)
    end,
}
brightness_widget:change_value(0)

return brightness_widget
