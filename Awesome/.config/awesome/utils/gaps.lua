local awful = require 'awful'
local beautiful = require 'beautiful'
local gears = require 'gears'

local M = {}

local function rounded_corners(c)
    c.shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 10)
    end
end

local function squared_corners(c)
    c.shape = gears.shape.rectangle
end

for _, signal in ipairs({ "property::floating", "property::maximized", "property::fullscreen", "manage" }) do
    client.connect_signal(signal, function(c)
        local current_gaps = screen[1].tags[1].gap
        if c.floating or current_gaps > 0 then
            rounded_corners(c)
        elseif c.maximized or c.fullscreen or current_gaps == 0 then
            squared_corners(c)
        else
            rounded_corners(c)
        end
    end)
end

M.useless_gaps_set = function(gaps)
    local current = screen[1].tags[1].gap

    for scr in screen do
        for _, tag in ipairs(scr.tags) do
            tag.gap = gaps
        end
        awful.layout.arrange(scr)
    end

    if current == 0 and gaps > 0 then
        for _, c in ipairs(client.get()) do
            rounded_corners(c)
        end
    elseif current > 0 and gaps == 0 then
        for _, c in ipairs(client.get()) do
            squared_corners(c)
        end
    end
end

M.useless_gaps_resize = function(gaps_delta)
    local current = screen[1].tags[1].gap
    M.useless_gaps_set(current + gaps_delta)
end

M.useless_gaps_toggle = function()
    local current = screen[1].tags[1].gap
    local new
    if current == beautiful.useless_gap then
        new = 0
    else
        new = beautiful.useless_gap
    end
    M.useless_gaps_set(new)
end

return M
