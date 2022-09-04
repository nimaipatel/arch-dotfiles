local awful = require 'awful'

local nmcli_widget = awful.widget.watch(
    [[nmcli -get-values IN-USE,SSID,SIGNAL device wifi list]],
    5,
    function(widget, stdout)
        widget:set_text '睊'
        for line in stdout:gmatch '[^\r\n]+' do
            if line:match '^*:' then
                local ssid, power = line:match [[^*:(.+):(.+)]]
                widget:set_text('直 ' .. ssid .. ' ' .. power .. '%')
            end
        end
    end
)

return nmcli_widget
