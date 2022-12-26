local wibox = require 'wibox'
local gears = require 'gears'
local beautiful = require 'beautiful'

local cores = {}

local cpu_bars_widget = nil

local function lines_match(regexp, path)
    local lines = {}
    for line in io.lines(path) do
        if line:match(regexp) then
            lines[#lines + 1] = line
        end
    end
    return lines
end

local function update()
    for index, time in pairs(lines_match('cpu', '/proc/stat')) do
        local coreid = index - 1
        local core = cores[coreid] or { last_active = 0, last_total = 0, useage = 0 }
        local at = 1
        local idle = 0
        local total = 0

        for field in time:gmatch '[%s]+([^%s]+)' do
            -- 4 = idle, 5 = ioWait. Essentially, the CPUs have done
            -- nothing during these times.
            if at == 4 or at == 5 then
                idle = idle + field
            end
            total = total + field
            at = at + 1
        end

        local active = total - idle

        if core.last_active ~= active or core.last_total ~= total then
            -- Read current data and calculate relative values.
            local dactive = active - core.last_active
            local dtotal = total - core.last_total
            local usage = math.ceil(math.abs((dactive / dtotal) * 100))

            core.last_active = active
            core.last_total = total
            core.usage = usage

            -- Save current data for the next run.
            cores[coreid] = core

            if cpu_bars_widget ~= nil then
                for i = 1, #cores do
                    local bar = cpu_bars_widget:get_children_by_id(i)[1]
                    local value = cores[i].usage
                    if value > 75 then
                        bar:set_color(beautiful.base08)
                    elseif value > 50 then
                        bar:set_color(beautiful.base09)
                    elseif value > 25 then
                        bar:set_color(beautiful.base0A)
                    else
                        bar:set_color(beautiful.base0B)
                    end
                    bar:set_value(value)
                end
            end
        end
    end
end

local function bar_factory(id)
    return {
        {
            id = id,
            background_color = beautiful.base01,
            color = beautiful.base07,
            max_value = 100,
            widget = wibox.widget.progressbar,
        },
        forced_width = 15,
        direction = 'east',
        layout = wibox.container.rotate,
    }
end

gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = update,
}

while next(cores) == nil do
end

local bars = {}
for i = 1, #cores do
    table.insert(bars, bar_factory(i))
end

cpu_bars_widget = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    spacing = 8,
    {
        widget = wibox.widget.textbox,
        text = 'CPU',
    },
    {
        spacing = 1,
        layout = wibox.layout.fixed.horizontal,
        table.unpack(bars),
    },
}

return cpu_bars_widget
