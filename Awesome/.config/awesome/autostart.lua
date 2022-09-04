local awful = require 'awful'

local spawn_whatsapp = function()
    local is_whatsapp_active = false
    for _, c in ipairs(client.get()) do
        if c.instance:match '^whatsapp%-nativefier' then
            is_whatsapp_active = true
            break
        end
    end
    if not is_whatsapp_active then
        awful.util.spawn 'whatsapp-nativefier'
    end
end

local spawn_spotify = function()
    awful.spawn.easy_async('pidof spotify', function(out, err, reason, code) --luacheck: no unused args
        if code ~= 0 then
            awful.util.spawn 'spotify-launcher'
        end
    end)
end

awesome.connect_signal('startup', function()
    spawn_spotify()
    spawn_whatsapp()
end)
