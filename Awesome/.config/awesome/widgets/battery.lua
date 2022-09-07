local wibox = require 'wibox'
local gears = require 'gears'
local awful = require 'awful'
local beautiful = require 'beautiful'

local battery_widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = 10,
    {
        layout = wibox.layout.fixed.horizontal,
        {

            {
                min_value = 0,
                max_value = 100,
                value = 0,
                margins = {
                    top = 4,
                    bottom = 4,
                    left = 0,
                    right = 0,
                },
                border_width = 4,
                border_color = beautiful.base03,
                forced_width = 75,
                color = beautiful.base0B,
                background_color = beautiful.base03,
                id = 'bar',
                widget = wibox.widget.progressbar,
            },
            {
                id = 'charge-text',
                widget = wibox.widget.textbox,
                align = 'center',
                text = ' ',
            },
            layout = wibox.layout.stack,
        },
        {
            min_value = 0,
            max_value = 100,
            value = 0,
            margins = {
                top = 8,
                bottom = 8,
                left = 0,
                right = 0,
            },
            border_width = 0,
            forced_width = 6,
            color = beautiful.base09,
            background_color = beautiful.base03,
            widget = wibox.widget.progressbar,
        },
    },
    {
        id = 'text',
        widget = wibox.widget.textbox,
    },
    set_battery = function(self, val)
        local text = self:get_children_by_id('text')[1]
        local bar = self:get_children_by_id('bar')[1]
        bar:set_value(val)
        text:set_text(val .. '%')
    end,
}

gears.timer {
    timeout = 10,
    call_now = true,
    autostart = true,
    callback = function()
        awful.spawn.easy_async('cat /sys/class/power_supply/BAT1/capacity', function(out)
            battery_widget:set_battery(tonumber(out))
        end)
    end,
}

return battery_widget
