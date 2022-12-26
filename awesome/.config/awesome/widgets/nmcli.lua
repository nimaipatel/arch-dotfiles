local awful = require 'awful'
local gears = require 'gears'
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local recolor = gears.color.recolor_image
local config_dir = gears.filesystem.get_configuration_dir()

local wifi4 = recolor(config_dir .. 'assets/wifi-4.svg', beautiful.base0B)
local wifi3 = recolor(config_dir .. 'assets/wifi-3.svg', beautiful.base0B)
local wifi2 = recolor(config_dir .. 'assets/wifi-2.svg', beautiful.base0B)
local wifi1 = recolor(config_dir .. 'assets/wifi-1.svg', beautiful.base0B)
local wifi_off = recolor(config_dir .. 'assets/wifi-off.svg', beautiful.base08)

local nm_widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = 8,
    {
        widget = wibox.container.margin,
        margins = 3,
        {
            id = 'icon',
            resize = true,
            widget = wibox.widget.imagebox,
        },
    },
    {
        id = 'text',
        widget = wibox.widget.textbox,
    },
}

local main_loop = function()
    local icon = nm_widget:get_children_by_id('icon')[1]
    local text = nm_widget:get_children_by_id('text')[1]
    awful.spawn.easy_async(
        [[nmcli -get-values IN-USE,SSID,SIGNAL device wifi list]],
        function(out, err, reason, code) --luacheck: ignore
            local img = wifi_off
            local txt = 'no wifi'
            for line in out:gmatch '[^\r\n]+' do
                if line:match '^*:' then
                    local ssid, power = line:match [[^*:(.+):(.+)]]
                    power = tonumber(power)
                    if power > 75 then
                        img = wifi4
                    elseif power > 50 then
                        img = wifi3
                    elseif power > 25 then
                        img = wifi2
                    else
                        img = wifi1
                    end
                    txt = ssid .. ' ' .. power .. '%'
                end
            end
            icon:set_image(img)
            text:set_text(txt)
        end
    )
end

gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = main_loop,
}

return nm_widget
