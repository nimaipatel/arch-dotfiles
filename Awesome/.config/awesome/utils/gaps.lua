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

for _, signal in ipairs({ "property::maximized", "property::fullscreen", "manage" }) do
    client.connect_signal(signal, function(c)
        if c.maximized or c.fullscreen then
            squared_corners(c)
        else
            rounded_corners(c)
        end
    end)
end


M.useless_gaps_resize = function(thatmuch)
    for scr in screen do
        for _, tag in ipairs(scr.tags) do
            if thatmuch == nil then
                tag.gap = beautiful.useless_gap
            else
                tag.gap = tag.gap + tonumber(thatmuch)
            end
        end
        awful.layout.arrange(scr)
    end
end

return M
