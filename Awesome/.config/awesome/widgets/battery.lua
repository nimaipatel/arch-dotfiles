local wibox = require 'wibox'
local gears = require 'gears'
local beautiful = require 'beautiful'
local naughty = require 'naughty'

local the_battery = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
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
        border_width = 3,
        forced_width = 75,
        color = beautiful.base0B,
        background_color = beautiful.base01,
        id = 'bar',
        widget = wibox.widget.progressbar,
    },
    {
        id = 'nipple',
        margins = {
            top = 8,
            bottom = 8,
            left = 0,
            right = 0,
        },
        border_width = 0,
        forced_width = 6,
        widget = wibox.widget.progressbar,
    },
}

local battery_widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = 10,
    the_battery,
    {
        id = 'text',
        widget = wibox.widget.textbox,
    },
}

gears.timer {
    timeout = 60,
    call_now = true,
    autostart = true,
    callback = function()
        local f1 = io.open('/sys/class/power_supply/BAT1/capacity', 'r')
        local f2 = io.open('/sys/class/power_supply/BAT1/status', 'r')
        local cap = tonumber(f1:read '*all')
        local stat = f2:read '*all'
        f1:close()
        f2:close()

        if cap < 20 and stat:match 'Discharging' then
            naughty.notify {
                preset = naughty.config.presets.critical,
                title = 'Battery at ' .. cap .. '%',
                text = 'Please connect your charger or shutdown is imminent.',
            }
        end
    end,
}

gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = function()
        local f1 = io.open('/sys/class/power_supply/BAT1/capacity', 'r')
        local f2 = io.open('/sys/class/power_supply/BAT1/status', 'r')
        local cap = tonumber(f1:read '*all')
        local stat = f2:read '*all'
        f1:close()
        f2:close()

        local text = battery_widget:get_children_by_id('text')[1]
        local bar = the_battery:get_children_by_id('bar')[1]
        local nipple = the_battery:get_children_by_id('nipple')[1]
        bar:set_value(cap)
        text:set_text(cap .. '%')
        if stat:match 'Charging' then
            bar:set_border_color(beautiful.base09)
            nipple:set_background_color(beautiful.base09)
        elseif stat:match 'Full' then
            bar:set_border_color(beautiful.base0B)
            nipple:set_background_color(beautiful.base0B)
        else
            bar:set_border_color(beautiful.base03)
            nipple:set_background_color(beautiful.base03)
        end
    end,
}

return battery_widget
