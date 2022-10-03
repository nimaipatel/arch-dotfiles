local awful = require "awful"
local spawn = awful.spawn.easy_async_with_shell
local json = require "utils.json"

local fn = function(predicate, fallback)
    spawn([[ls /tmp/mykitty-*]], function(socket_file, _, _, code)
        if code ~= 0 then
            fallback()
            return
        end
        socket_file = socket_file:match("[^\n]*")
        spawn([[kitty @ --to unix:/]] .. socket_file .. [[ ls]], function(encoded, _, _, code)
            if code ~= 0 then
                fallback()
                return
            end
            local decoded = json.decode(encoded)
            for _, os_window in pairs(decoded) do
                local cmd = os_window.tabs[1].windows[1].foreground_processes[1].cmdline
                if predicate(cmd) then
                    local window = os_window.platform_window_id
                    for _, c in ipairs(client.get()) do
                        if c.window == window then
                            c:jump_to()
                            return
                        end
                    end
                end
            end
            fallback()
        end)
    end)
end

return fn
