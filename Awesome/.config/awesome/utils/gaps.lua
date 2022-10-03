local awful = require 'awful'
local beautiful = require 'beautiful'

local M = {}

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
