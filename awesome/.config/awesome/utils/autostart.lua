local awful = require 'awful'
local spawn = awful.spawn

-- execute `cmd` only if `predicate` returns false or failure (non-zero exit)
local spawn_once = function(cmd, predicate)
    if type(predicate) == 'string' then
        awful.spawn.easy_async(predicate, function(out, err, reason, code) --luacheck: no unused args
            if code ~= 0 then
                spawn(cmd)
            end
        end)
    elseif type(predicate) == 'function' then
        if predicate() == false then
            spawn(cmd)
        end
    end
end

awesome.connect_signal('startup', function()
    spawn 'xgamma -rgamma 1.0 -ggamma 1.0 -bgamma 0.8'
    spawn_once('unclutter', 'pidof unclutter')
    spawn_once('clight --no-auto-recalib', 'pidof clight')
    spawn_once('picom', 'pidof picom')
    spawn_once('flameshot', 'pidof flameshot')
    spawn_once('buckle', 'pidof buckle')
end)
