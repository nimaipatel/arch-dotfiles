local wibox = require 'wibox'
local gears = require 'gears'
local awful = require 'awful'

local dir = gears.filesystem.get_configuration_dir() .. '/assets/'

local pulse_widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = 10,
    {
        id = 'icon',
        widget = wibox.widget.textbox,
        text = 'hello',
    },
    {
        id = 'level',
        widget = wibox.widget.textbox,
        text = 'hello',
    },
}

local level = pulse_widget:get_children_by_id('level')[1]
local icon = pulse_widget:get_children_by_id('icon')[1]

local change = function(delta)
    local cmd
    if delta > 0 then
        cmd = dir .. 'vol.py +' .. delta
    else
        cmd = dir .. 'vol.py ' .. delta
    end
    awful.spawn.easy_async(cmd, function(out)
        out = tonumber(out)
        out = out * 100
        out = math.floor(out + 0.5)
        level:set_text(out .. '%')
    end)
end

local mute = function()
    local cmd = dir .. 'vol_mute.py'
    awful.spawn.easy_async(cmd, function(out)
        if out:match"true" then
            icon:set_text("muted")
        else
            icon:set_text("unmuted")
        end
    end)
end

mute()
mute()
change(0)

return { widget = pulse_widget, change = change, mute = mute }
