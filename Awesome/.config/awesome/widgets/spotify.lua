local awful = require 'awful'
local gears = require 'gears'
local wibox = require 'wibox'
local beautiful = require 'beautiful'

local play_icon = '/usr/share/icons/Papirus-Light/24x24/categories/spotify.svg'
local pause_icon = '/usr/share/icons/Papirus-Dark/24x24/panel/spotify-indicator.svg'

local spotify_widget = wibox.widget {
    {
        id = 'artist',
        font = beautiful.font,
        widget = wibox.widget.textbox,
        align = 'right',
        forced_width = 300,
    },
    {
        id = 'icon',
        widget = wibox.widget.imagebox,
    },
    {
        layout = wibox.container.scroll.horizontal,
        max_size = 300,
        forced_width = 300,
        step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
        speed = 40,
        {
            id = 'title',
            font = beautiful.font,
            widget = wibox.widget.textbox,
        },
    },
    layout = wibox.layout.fixed.horizontal,
    spacing = 10,
}

spotify_widget:connect_signal('button::press', function(_, _, _, button)
    if button == 1 then
        awful.spawn('playerctl --player=spotify play-pause', false) -- left click
    elseif button == 4 then
        awful.spawn('playerctl --player=spotify next', false) -- scroll up
    elseif button == 5 then
        awful.spawn('playerctl --player=spotify previous', false) -- scroll down
    end
end)

local main_loop = function()
    awful.spawn.easy_async([[playerctl --player=spotify status]], function(out, err, reason, code) --luacheck: ignore
        if code ~= 0 then
            spotify_widget:get_children_by_id('icon')[1]:set_visible(false)
            return
        end
        spotify_widget:get_children_by_id('icon')[1]:set_visible(true)
        local line = out:match '[^\r\n]+'
        if line == 'Playing' then
            spotify_widget:get_children_by_id('icon')[1]:set_image(play_icon)
        elseif line == 'Paused' then
            spotify_widget:get_children_by_id('icon')[1]:set_image(pause_icon)
        end
    end)

    awful.spawn.easy_async([[playerctl --player=spotify metadata]], function(out, err, reason, code) --luacheck: ignore
        if code ~= 0 then
            spotify_widget:get_children_by_id('artist')[1]:set_markup ''
            spotify_widget:get_children_by_id('title')[1]:set_markup ''
            return
        end
        local artist, title
        for line in out:gmatch '[^\r\n]+' do
            local _
            if line:match 'spotify xesam:artist' then
                _, artist = line:match 'spotify xesam:artist( +)(.+)'
            end
            if line:match 'spotify xesam:title' then
                _, title = line:match 'spotify xesam:title( +)(.+)'
            end
        end
        spotify_widget:get_children_by_id('artist')[1]:set_markup(artist)
        spotify_widget:get_children_by_id('title')[1]:set_markup(title)
    end)
end

gears.timer {
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = main_loop,
}

return spotify_widget
