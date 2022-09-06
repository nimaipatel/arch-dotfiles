local wibox = require 'wibox'
local gears = require 'gears'
local naughty = require 'naughty'
local floor = math.floor
local beautiful = require 'beautiful'

local memory_widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = 3,
    {
        widget = wibox.widget.textbox,
        text = 'MEM',
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
    {
        id = 'text',
        widget = wibox.widget.textbox,
    },
}

local main_loop = function()
    local mem = {}
    for line in io.lines '/proc/meminfo' do
        for k, v in string.gmatch(line, '([%a]+):[%s]+([%d]+).+') do
            if k == 'MemTotal' then
                mem.total = floor(v / 1024 + 0.5)
            elseif k == 'MemFree' then
                mem.free = floor(v / 1024 + 0.5)
            elseif k == 'Buffers' then
                mem.buf = floor(v / 1024 + 0.5)
            elseif k == 'Cached' then
                mem.cache = floor(v / 1024 + 0.5)
            elseif k == 'SwapTotal' then
                mem.swap = floor(v / 1024 + 0.5)
            elseif k == 'SwapFree' then
                mem.swapf = floor(v / 1024 + 0.5)
            elseif k == 'SReclaimable' then
                mem.srec = floor(v / 1024 + 0.5)
            end
        end
    end
    mem.used = mem.total - mem.free - mem.buf - mem.cache - mem.srec
    mem.swapused = mem.swap - mem.swapf
    mem.perc = math.floor(mem.used / mem.total * 100)

    local arc = memory_widget:get_children_by_id('arc')[1]
    local text = memory_widget:get_children_by_id('text')[1]

    arc:set_values { mem.perc, 100 - mem.perc }
    if mem.perc > 75 then
        arc:set_colors { beautiful.base08, beautiful.base02 }
    elseif mem.perc > 50 then
        arc:set_colors { beautiful.base09, beautiful.base02 }
    elseif mem.perc > 25 then
        arc:set_colors { beautiful.base0A, beautiful.base02 }
    else
        arc:set_colors { beautiful.base0B, beautiful.base02 }
    end

    text:set_text(mem.perc .. '%')
end

gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = main_loop,
}

return memory_widget
