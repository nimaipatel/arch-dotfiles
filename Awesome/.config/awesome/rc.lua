pcall(require, 'luarocks.loader')

require 'utils.beautiful_init'

local xresources = require 'beautiful.xresources'
local dpi = xresources.apply_dpi
local lof_kitty = require 'utils.lof_kitty'

local nm_widget = require 'widgets.nmcli'
local bluetooth_widget = require('widgets.bluetooth')
local brightnessctl_widget = require 'widgets.brightnessctl'
local cpu_bars_widget = require 'widgets.cpu_bars'
local memory_widget = require 'widgets.memory'
local battery_widget = require 'widgets.battery'
local pipewire_widget = require 'widgets.pipewire'
local spotify_widget = require 'widgets.spotify'
local gaps = require 'utils.gaps'

-- Standard awesome library
local gears = require 'gears'
local awful = require 'awful'
local key = awful.key
require 'awful.autofocus'
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local naughty = require 'naughty'
local hotkeys_popup = require 'awful.hotkeys_popup'
require 'awful.hotkeys_popup.keys'

local TAGS = { ' ૧ ', ' ૨ ', ' ૩ ', ' ૪ ', ' ૫ ', ' ૬ ', ' ૭ ', ' ૮ ', ' ૯ ' }
if awesome.startup_errors then
    naughty.notify {
        preset = naughty.config.presets.critical,
        title = 'Oops, there were errors during startup!',
        text = awesome.startup_errors,
    }
end

do
    local in_error = false
    awesome.connect_signal('debug::error', function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then
            return
        end
        in_error = true

        naughty.notify {
            preset = naughty.config.presets.critical,
            title = 'Oops, an error happened!',
            text = tostring(err),
        }
        in_error = false
    end)
end

local modkey = 'Mod4'

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.floating,
}

local abbreviation = function(str)
    local template = [[sh -c 'sleep 0.2 ; xdotool type --clearmodifiers "%s" ; xdotool keyup super']]
    return function()
        awful.util.spawn(string.format(template, str))
    end
end

local abb_menu = awful.menu {
    { '&name', abbreviation 'Nimai Patel' },
    { '&email', abbreviation 'nimai.m.patel@gmail.com' },
    { '&github', abbreviation 'https://www.github.com/nimaipatel' },
    { '&date in dd/mm/yyyy', abbreviation '$(date +%d/%m/%Y)' },
    { '&time in h:m:[AM/PM]', abbreviation '$(date +%I:%M%p)' },
    { 'day of the &week', abbreviation '$(date +%A)' },
    { '&unix date', abbreviation '$(date)' },
}

local layoutmenu = {
    {
        '&Tile',
        {
            {
                '&Right',
                function()
                    awful.layout.set(awful.layout.suit.tile)
                end,
                beautiful.layout_tile,
            },
            {
                '&Left',
                function()
                    awful.layout.set(awful.layout.suit.tile.left)
                end,
                beautiful.layout_tileleft,
            },
            {
                '&Bottom',
                function()
                    awful.layout.set(awful.layout.suit.tile.bottom)
                end,
                beautiful.layout_tilebottom,
            },
            {
                '&Top',
                function()
                    awful.layout.set(awful.layout.suit.tile.top)
                end,
                beautiful.layout_tiletop,
            },
        },
        beautiful.layout_tile,
    },
    {
        '&Fair',
        {
            {
                '&Vertical',
                function()
                    awful.layout.set(awful.layout.suit.fair)
                end,
                beautiful.layout_fairv,
            },
            {
                '&Horizontal',
                function()
                    awful.layout.set(awful.layout.suit.fair.horizontal)
                end,
                beautiful.layout_fairh,
            },
        },
        beautiful.layout_fairv,
    },
    {
        'F&loating',
        function()
            awful.layout.set(awful.layout.suit.floating)
        end,
        beautiful.layout_floating,
    },
}

local sysopts = {
    { ' &Restart', 'reboot' },
    { ' &Lock', 'dm-tool lock' },
    { ' &Power Off', 'poweroff' },
}

local mymainmenu = awful.menu {
    items = {
        { ' &System', sysopts },
        { ' &Terminal', 'kitty --single-instance' },
        {
            ' &Customize',
            {
                { ' &Color Scheme', 'change-mode-dmenu' },
                {
                    ' &Opacity',
                    function()
                        awful.prompt.run {
                            prompt = 'Set opacity (current value is ' .. (OPACITY * 100) .. '%' .. '): ',
                            textbox = awful.screen.focused().mypromptbox.widget,
                            exe_callback = function(input)
                                input = tonumber(input)
                                if not input then
                                    return
                                end
                                if input < 0 or input > 100 then
                                    return
                                end
                                if input > 1 then
                                    input = input / 100
                                end
                                awful.spawn('change-opacity ' .. input)
                            end,
                        }
                    end,
                },
                { ' &Wallpaper', 'set-wallpaper' },
            },
        },
        { ' &Editor', 'kitty --single-instance -e nvim' },
        { ' &Browser', os.getenv 'BROWSER' },
        {
            ' &Utilities',
            {
                {
                    ' Calculato&r',
                    function()
                        awful.spawn.with_shell 'sleep 0.1 ; rofi -show calc'
                    end,
                },
                { ' &Color Picker', 'colorpicker' },
                {
                    ' &Passwords',
                    function()
                        awful.spawn.with_shell 'sleep 0.1 ; passmenu -i -p  '
                    end,
                },
                {
                    ' &Emoji Selector',
                    function()
                        awful.spawn.with_shell 'sleep 0.1 ; rofi -show emoji'
                    end,
                },
            },
        },
        {
            ' &Office Suite',
            {
                { ' &Writer', 'libreoffice --writer' },
                { ' &Impress', 'libreoffice --impress' },
                { ' &Calc', 'libreoffice --calc' },
            },
        },
        {
            ' &Layouts',
            layoutmenu,
        },
    },
}

local mytextclock = wibox.widget.textclock('%A %d %B, %Y %I:%M%p ', 10)

local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t)
        t:view_only()
    end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({}, 4, function(t)
        awful.tag.viewnext(t.screen)
    end),
    awful.button({}, 5, function(t)
        awful.tag.viewprev(t.screen)
    end)
)

local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal('request::activate', 'tasklist', { raise = true })
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list { theme = { width = 250 } }
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)
)

for s in screen do
    -- Each screen has its own tag table.
    awful.tag(TAGS, s, awful.layout.layouts[1])

    s.mypromptbox = awful.widget.prompt()
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(awful.button({}, 1, function()
        mymainmenu:toggle { coords = { x = 0, y = 0 } }
    end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        layout = {
            layout = wibox.layout.fixed.horizontal,
        },
        widget_template = {
            {
                wibox.widget.base.make_widget(),
                id = 'background_role',
                widget = wibox.container.background,
            },
            {
                {
                    id = 'clienticon',
                    widget = awful.widget.clienticon,
                },
                margins = 5,
                widget = wibox.container.margin,
            },
            nil,
            create_callback = function(self, c, index, objects) --luacheck: no unused args
                self:get_children_by_id('clienticon')[1].client = c
            end,
            forced_width = 30,
            layout = wibox.layout.stack,
        },
    }

    -- Create the wibox
    s.topwibox = awful.wibar { height = dpi(30), position = 'top', screen = s }
    s.bottomwibox = awful.wibar { height = dpi(30), position = 'bottom', screen = s }

    -- Add widgets to the wibox
    s.topwibox:setup {
        layout = wibox.layout.align.horizontal,
        spacing = dpi(30),
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(30),
            s.mylayoutbox,
            s.mytaglist,
            s.mypromptbox,
        },
        { -- Center widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(30),
            s.mytasklist,
            require('widgets.quotes')
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(30),
            {
                widget = wibox.container.margin,
                margins = dpi(3),
                wibox.widget.systray(),
            },
            mytextclock,
        },
    }
    s.bottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        spacing = dpi(30),
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(30),
            cpu_bars_widget,
            memory_widget,
            battery_widget,
        },
        { -- Center widgets
            valign = 'center',
            halign = 'center',
            layout = wibox.container.place,
            spotify_widget,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(30),
            bluetooth_widget,
            nm_widget,
            pipewire_widget,
            brightnessctl_widget
        },
    }
end
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({}, 3, function()
        mymainmenu:toggle()
    end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
local globalkeys = gears.table.join(
    key({ modkey }, 't', function()
        local predicate = function(cmd)
            return cmd[1] == "fish"
        end
        local fallback = function()
            awful.spawn('kitty --single-instance', {
                tag = TAGS[1],
            })
        end
        lof_kitty(predicate, fallback)
    end),

    -- this one's for messaging applications. C stands for "chat"?
    key({ modkey }, 'c', function()
        local screen = awful.screen.focused()
        local tag = screen.tags[5]
        if tag then
            tag:view_only()
        end
    end),

    key({ modkey }, 'e', function()
        local predicate = function(cmd)
            return cmd[1] == "nvim"
        end
        local fallback = function()
            awful.spawn('kitty --single-instance -e nvim', {
                tag = TAGS[1],
            })
        end
        lof_kitty(predicate, fallback)
    end),

    key({ modkey }, 'v', function()
        for _, c in ipairs(client.get()) do
            if c.class and c.class:match 'Pulsemixer' then
                c:jump_to()
                return
            end
        end
        awful.spawn([[kitty --single-instance --class 'Pulsemixer' -e pulsemixer]], {
            tag = TAGS[4],
        })
    end, { description = 'toggle pulsemixer window', group = 'launcher' }),


    key({ modkey }, 'b', function()
        for _, c in ipairs(client.get()) do
            if c.class and c.class:match '^Brave%-browser' then
                c:jump_to()
                return
            end
        end
        -- urgent tags are automatically focused in this config
        awful.spawn('brave', {
            tag = TAGS[2],
        })
    end),

    awful.key({ modkey }, 'Delete', function()
        naughty.destroy_all_notifications()
    end),

    key({ modkey }, '=', function()
        gaps.useless_gaps_resize(1)
    end, { description = 'increment useless gaps', group = 'gaps' }),

    key({ modkey }, '-', function()
        gaps.useless_gaps_resize(-1)
    end, { description = 'decrement useless gaps', group = 'gaps' }),

    key({ modkey }, '0', function()
        gaps.useless_gaps_toggle()
    end, { description = 'reset gaps', group = 'gaps' }),

    -- Mod4 + Control + Escape is actually mapped to to just Mod4 using xcape
    -- see autostart.lua
    key({ modkey, 'Control' }, 'Escape', function()
        awful.util.spawn 'rofi -show run -display-run '
    end, { description = 'run desktop apps', group = 'menus' }),

    key({}, 'XF86MonBrightnessDown', function()
        brightnessctl_widget:change_value(-5)
    end),

    key({}, 'XF86MonBrightnessUp', function()
        brightnessctl_widget:change_value(5)
    end),

    key({}, 'XF86AudioNext', function()
        awful.util.spawn 'playerctl next'
    end),

    key({}, 'XF86AudioPrev', function()
        awful.util.spawn 'playerctl previous'
    end),

    key({}, 'XF86AudioPlay', function()
        awful.util.spawn 'playerctl play-pause'
    end),

    key({}, 'XF86AudioMute', function()
        pipewire_widget:mute()
    end),

    key({}, 'XF86AudioRaiseVolume', function()
        pipewire_widget:change(5)
    end),

    key({}, 'XF86AudioLowerVolume', function()
        pipewire_widget:change(-5)
    end),

    key({ modkey }, 'Left', awful.tag.viewprev, { description = 'view previous', group = 'tag' }),

    key({ modkey }, 'Right', awful.tag.viewnext, { description = 'view next', group = 'tag' }),

    key({ modkey }, 'Escape', awful.tag.history.restore, { description = 'go back', group = 'tag' }),

    key({ modkey }, 'j', function()
        awful.client.focus.byidx(1)
    end, { description = 'focus next by index', group = 'client' }),

    key({ modkey }, 'k', function()
        awful.client.focus.byidx(-1)
    end, { description = 'focus previous by index', group = 'client' }),

    key({ modkey }, 'space', function()
        mymainmenu:toggle { coords = { x = 0, y = 0 } }
    end, { description = 'show main menu', group = 'awesome' }),

    -- Layout manipulation
    key({ modkey, 'Shift' }, 'j', function()
        awful.client.swap.byidx(1)
    end, { description = 'swap with next client by index', group = 'client' }),

    key({ modkey, 'Shift' }, 'k', function()
        awful.client.swap.byidx(-1)
    end, { description = 'swap with previous client by index', group = 'client' }),

    key({ modkey, 'Control' }, 'j', function()
        awful.screen.focus_relative(1)
    end, { description = 'focus the next screen', group = 'screen' }),

    key({ modkey, 'Control' }, 'k', function()
        awful.screen.focus_relative(-1)
    end, { description = 'focus the previous screen', group = 'screen' }),

    key({ modkey }, 'Tab', function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end, { description = 'go back', group = 'client' }),

    key({ modkey }, 'g', function()
        for _, c in ipairs(client.get()) do
            if c.class and c.class:match 'Google Keep' then
                c:jump_to()
                return
            end
        end
        awful.spawn([[kitty --single-instance --class 'Google Keep' -e nvim -c GkeepOpen]], {
            tag = TAGS[6],
        })
    end, { description = 'toggle google keep window', group = 'launcher' }),

    key({ modkey, 'Shift' }, 's', function()
        awful.util.spawn('flameshot gui')
    end),

    key({ modkey }, 's', function()
        for _, c in ipairs(client.get()) do
            if c.class and c.class:match 'Spotify' then
                c:jump_to()
                return
            end
        end
        awful.spawn('spotify-launcher', {
            tag = TAGS[4],
        })
    end, { description = 'toggle spotify', group = 'launcher' }),

    awful.key({ modkey }, 'F1', hotkeys_popup.show_help, { description = 'show help', group = 'awesome' }),

    key({ modkey, 'Control' }, 'r', awesome.restart, { description = 'reload awesome', group = 'awesome' }),

    key({ modkey }, 'l', function()
        awful.tag.incmwfact(0.05)
    end, { description = 'increase master width factor', group = 'layout' }),

    key({ modkey }, 'h', function()
        awful.tag.incmwfact(-0.05)
    end, { description = 'decrease master width factor', group = 'layout' }),

    key({ modkey, 'Shift' }, 'h', function()
        awful.tag.incnmaster(1, nil, true)
    end, { description = 'increase the number of master clients', group = 'layout' }),

    key({ modkey, 'Shift' }, 'l', function()
        awful.tag.incnmaster(-1, nil, true)
    end, { description = 'decrease the number of master clients', group = 'layout' }),

    key({ modkey, 'Control' }, 'h', function()
        awful.tag.incncol(1, nil, true)
    end, { description = 'increase the number of columns', group = 'layout' }),

    key({ modkey, 'Control' }, 'l', function()
        awful.tag.incncol(-1, nil, true)
    end, { description = 'decrease the number of columns', group = 'layout' }),

    key({ modkey, 'Control' }, 'n', function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal('request::activate', 'key.unminimize', { raise = true })
        end
    end, { description = 'restore minimized', group = 'client' }),

    key({ modkey }, 'x', function()
        awful.prompt.run {
            prompt = 'Run Lua code: ',
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. '/history_eval',
        }
    end, { description = 'lua execute prompt', group = 'awesome' })
)

local clientkeys = gears.table.join(
    key({ modkey }, 'f', function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, { description = 'toggle fullscreen', group = 'client' }),

    key({ modkey, 'Shift' }, 'c', function(c)
        c:kill()
    end, { description = 'close', group = 'client' }),

    key(
        { modkey, 'Control' },
        'space',
        awful.client.floating.toggle,
        { description = 'toggle floating', group = 'client' }
    ),

    key({ modkey }, 'Return', function(c)
        c:swap(awful.client.getmaster())
    end, { description = 'move to master', group = 'client' }),

    key({ modkey }, 'o', function(c)
        c:move_to_screen()
    end, { description = 'move to screen', group = 'client' }),

    key({ modkey }, 'n', function(c)
        c.minimized = true
    end, { description = 'minimize', group = 'client' }),

    key({ modkey }, 'm', function(c)
        c.maximized = not c.maximized
        c:raise()
    end, { description = '(un)maximize', group = 'client' }),

    key({ modkey, 'Control' }, 'm', function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end, { description = '(un)maximize vertically', group = 'client' }),

    key({ modkey, 'Shift' }, 'm', function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
    end, { description = '(un)maximize horizontally', group = 'client' })
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(
        globalkeys,
        -- View tag only.
        key({ modkey }, '#' .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
        end, { description = 'view tag #' .. i, group = 'tag' }),

        -- Toggle tag display.
        key({ modkey, 'Control' }, '#' .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end, { description = 'toggle tag #' .. i, group = 'tag' }),

        -- Move client to tag.
        key({ modkey, 'Shift' }, '#' .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                    tag:view_only()
                end
            end
        end, { description = 'move focused client to tag #' .. i, group = 'tag' }),

        -- Toggle tag on focused client.
        key({ modkey, 'Control', 'Shift' }, '#' .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end, { description = 'toggle focused client on tag #' .. i, group = 'tag' })
    )
end

-- abbreviations
globalkeys = gears.table.join(
    globalkeys,
    -- Move client to tag.
    key({ modkey }, 'a', function()
        abb_menu:toggle { coords = { x = 0, y = 0 } }
    end)
)

local clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal('request::activate', 'mouse_click', { raise = true })
        awful.mouse.client.resize(c)
    end)
)

local double_click_timer = nil
local function double_click_event_handler(double_click_event) --luacheck: ignore
    if double_click_timer then
        double_click_timer:stop()
        double_click_timer = nil
        return true
    end

    double_click_timer = gears.timer.start_new(0.20, function()
        double_click_timer = nil
        return false
    end)
end

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            size_hints_honor = false,
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.centered + awful.placement.no_offscreen,
        },
    },

    -- Floating clients.
    {
        rule_any = {
            instance = {
                'DTA', -- Firefox addon DownThemAll.
                'copyq', -- Includes session name in class.
                'pinentry',
            },
            class = {
                'Arandr',
                'Blueman-manager',
                'Gpick',
                'Kruler',
                'MessageWin', -- kalarm.
                'Sxiv',
                'Tor Browser', -- Needs a fixed window size to avoid fingerprinting by screen size.
                'Wpa_gui',
                'veromix',
                'xtightvncviewer',
            },

            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {
                'Event Tester', -- xev.
            },
            role = {
                'AlarmWindow', -- Thunderbird's calendar.
                'ConfigManager', -- Thunderbird's about:config.
                'pop-up', -- e.g. Google Chrome's (detached) Developer Tools.
            },
        },
        properties = { floating = true },
    },

    { rule = { instance = 'brave-browser' }, properties = { tag = TAGS[2] } },
    { rule = { instance = 'libreoffice' }, properties = { tag = TAGS[3] } },
    { rule = { instance = 'soffice' }, properties = { tag = TAGS[3] } },
    { rule = { class = 'Spotify' }, properties = { tag = TAGS[4] } },
    { rule = { class = 'Pavucontrol' }, properties = { tag = TAGS[4] } },
    { rule = { instance = 'whatsapp-nativefier-d40211' }, properties = { tag = TAGS[5] } },
    { rule = { instance = 'scrcpy' }, properties = { floating = true, tag = TAGS[9] } },

    -- Add titlebars to normal clients and dialogs
    { rule_any = { type = { 'normal', 'dialog' } }, properties = { titlebars_enabled = true } },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal('manage', function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal('request::titlebars', function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal('request::activate', 'titlebar', { raise = true })
            -- WILL EXECUTE THIS ON DOUBLE CLICK
            if double_click_event_handler() then
                c.floating = false
                c:raise()
            else
                local old = c:geometry()
                c.floating = true
                local new = c:geometry()
                new.x = old.x
                new.y = old.y
                c:geometry(new)
                awful.mouse.client.move(c)
            end
        end),
        awful.button({}, 3, function()
            c:emit_signal('request::activate', 'titlebar', { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    local top_titlebar = awful.titlebar(c, {
        size = dpi(25),
    })

    top_titlebar:setup {
        {
            widget = wibox.container.margin,
            margins = dpi(5),
            {
                spacing = dpi(10),
                awful.titlebar.widget.closebutton(c),
                awful.titlebar.widget.minimizebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                layout = wibox.layout.fixed.horizontal(),
            },
        },
        { -- Middle
            { -- Title
                align = 'center',
                widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal,
        },
        {
            widget = wibox.container.margin,
            margins = dpi(5),
            {
                spacing = dpi(10),
                awful.titlebar.widget.stickybutton(c),
                awful.titlebar.widget.ontopbutton(c),
                layout = wibox.layout.fixed.horizontal(),
            },
        },

        layout = wibox.layout.align.horizontal,
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
wibox.widget {
    layout = wibox.container.scroll.horizontal,
    max_size = 100,
    step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
    speed = 100,
    {
        widget = wibox.widget.textbox,
        text = 'This is a ' .. string.rep('very, ', 10) .. ' very long text',
    },
}
client.connect_signal('mouse::enter', function(c)
    c:emit_signal('request::activate', 'mouse_enter', { raise = false })
end)

client.connect_signal('focus', function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal('unfocus', function(c)
    c.border_color = beautiful.border_normal
end)

awesome.connect_signal('exit', function(reason_restart)
    if not reason_restart then
        return
    end

    local sel_tag_file = io.open('/tmp/awesomewm-last-selected-tags', 'w+')
    for s in screen do
        if sel_tag_file then
            sel_tag_file:write(s.selected_tag.index, '\n')
        end
    end
    if sel_tag_file then
        sel_tag_file:close()
    end

    local gaps_file = io.open('/tmp/awesomewm-gaps', 'w+')
    if gaps_file then
        gaps_file:write(screen[1].tags[1].gap, '\n')
        gaps_file:close()
    end
end)

awesome.connect_signal('startup', function()
    local sel_tags_file = io.open('/tmp/awesomewm-last-selected-tags', 'r')
    if not sel_tags_file then
        return
    end

    local selected_tags = {}

    for line in sel_tags_file:lines() do
        table.insert(selected_tags, tonumber(line))
    end

    for s in screen do
        local i = selected_tags[s.index]
        local t = s.tags[i]
        t:view_only()
    end

    local gaps_file = io.open('/tmp/awesomewm-gaps', 'r')
    if gaps_file then
        local old_gaps = tonumber(gaps_file:read("*all"))
        if old_gaps then
            gaps.useless_gaps_set(old_gaps)
        end
    end
end)

require 'utils.autostart'

client.connect_signal('manage', function(c)
    if c.class == nil then
        c.minimized = true
        c:connect_signal('property::class', function()
            awful.rules.apply(c)
            if c.class == 'Spotify' then
                awful.spawn 'xseticon -name Spotify /usr/share/icons/hicolor/32x32/apps/spotify-launcher.png'
            end
        end)
    end
end)

client.connect_signal('property::urgent', function(c)
    c.minimized = false
    c:jump_to()
end)

local mojave_dir = gears.filesystem.get_configuration_dir() .. '/wallpapers/mojave/'
local wallpaper = require 'utils.wallpaper'
wallpaper.dynamic({
    { time = "00:00:00", wallpaper = mojave_dir .. "mojave_dynamic_15.jpeg" },
    { time = "03:00:00", wallpaper = mojave_dir .. "mojave_dynamic_16.jpeg" },
    { time = "05:00:00", wallpaper = mojave_dir .. "mojave_dynamic_1.jpeg" },
    { time = "06:00:00", wallpaper = mojave_dir .. "mojave_dynamic_2.jpeg" },
    { time = "07:00:00", wallpaper = mojave_dir .. "mojave_dynamic_3.jpeg" },
    { time = "08:00:00", wallpaper = mojave_dir .. "mojave_dynamic_4.jpeg" },
    { time = "09:00:00", wallpaper = mojave_dir .. "mojave_dynamic_5.jpeg" },
    { time = "10:00:00", wallpaper = mojave_dir .. "mojave_dynamic_6.jpeg" },
    { time = "11:00:00", wallpaper = mojave_dir .. "mojave_dynamic_7.jpeg" },
    { time = "13:00:00", wallpaper = mojave_dir .. "mojave_dynamic_8.jpeg" },
    { time = "14:00:00", wallpaper = mojave_dir .. "mojave_dynamic_9.jpeg" },
    { time = "15:00:00", wallpaper = mojave_dir .. "mojave_dynamic_10.jpeg" },
    { time = "16:00:00", wallpaper = mojave_dir .. "mojave_dynamic_11.jpeg" },
    { time = "17:00:00", wallpaper = mojave_dir .. "mojave_dynamic_12.jpeg" },
    { time = "18:00:00", wallpaper = mojave_dir .. "mojave_dynamic_13.jpeg" },
    { time = "20:00:00", wallpaper = mojave_dir .. "mojave_dynamic_14.jpeg" },
}, function(file)
    gears.wallpaper.maximized(file)
    local wallpaper_file = os.getenv 'HOME' .. '/.config/wallpaper'
    awful.util.spawn('cp ' .. file .. ' ' .. wallpaper_file)
end)

require 'utils.flash_focus'.enable()

-- }}}
--
