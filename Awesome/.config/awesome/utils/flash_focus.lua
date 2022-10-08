local gears = require("gears")

local op = 0.75
local stp = 0.01

local flashfocus = function(c)
    if c and #c.screen.clients > 1 then
        c.opacity = op
        local q = op
        local g = gears.timer({
            timeout = stp,
            call_now = false,
            autostart = true,
        })

        g:connect_signal("timeout", function()
            if not c.valid then
                return
            end
            if q >= 1 then
                c.opacity = 1
                g:stop()
            else
                c.opacity = q
                q = q + stp
            end
        end)
    end
end

local enable = function()
    client.connect_signal("focus", flashfocus)
end
local disable = function()
    client.disconnect_signal("focus", flashfocus)
end

return { enable = enable, disable = disable, flashfocus = flashfocus }
