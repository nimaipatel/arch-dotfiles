local awful = require 'awful'
local gears = require 'gears'
local wibox = require 'wibox'

local config_dir = gears.filesystem.get_configuration_dir()
local bluetooth_svg = config_dir .. 'assets/bluetooth.svg'

local bluetooth_widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = 8,
    {
        widget = wibox.container.margin,
        margins = 3,
        {
            resize = true,
            image = bluetooth_svg,
            widget = wibox.widget.imagebox,
        },
    },
    {
        id = 'text',
        widget = wibox.widget.textbox,
    },
}

local main_loop = function()
    local text = bluetooth_widget:get_children_by_id('text')[1]
    awful.spawn.easy_async(
        [[bluetoothctl devices Connected]],
        function(out, err, reason, code)
            local device_name
            for line in out:gmatch '[^\r\n]+' do
                device_name = string.match(line, [[.+%s..:..:..:..:..:..%s(.+)]])
            end
            if device_name then
                bluetooth_widget:set_visible(true)
                text:set_text(device_name)
            else
                bluetooth_widget:set_visible(false)
            end
        end
    )
end

gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = main_loop,
}

return bluetooth_widget
