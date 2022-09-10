pcall(require, 'luarocks.loader')

require 'beautiful_init'

local xresources = require 'beautiful.xresources'
local dpi = xresources.apply_dpi

local lain = require 'lain'
local nm_widget = require 'widgets.nmcli'
local brightnessctl_widget = require 'widgets.brightnessctl'
local cpu_bars_widget = require 'widgets.cpu_bars'
local memory_widget = require 'widgets.memory'
local battery_widget = require 'widgets.battery'
local pipewire_widget = require 'widgets.pipewire'
local spotify_widget = require 'widgets.spotify'
local util = require 'util'

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

local modalbind = require 'modalbind'
modalbind.init()
modalbind.hide_default_options()

local terminal = os.getenv 'TERMINAL' or 'kitty'
local editor = os.getenv 'EDITOR' or 'nvim'
local editor_cmd = terminal .. ' -e ' .. editor
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

local layoutmenu = awful.menu {
    {
        '&Tile',
        {
            {
                '&Right',
                function()
                    awful.layout.set(awful.layout.suit.tile)
                end,
            },
            {
                '&Left',
                function()
                    awful.layout.set(awful.layout.suit.tile.left)
                end,
            },
            {
                '&Bottom',
                function()
                    awful.layout.set(awful.layout.suit.tile.bottom)
                end,
            },
            {
                '&Top',
                function()
                    awful.layout.set(awful.layout.suit.tile.top)
                end,
            },
        },
    },
    {
        '&Fair',
        {
            {
                '&Vertical',
                function()
                    awful.layout.set(awful.layout.suit.fair)
                end,
            },
            {
                '&Horizontal',
                function()
                    awful.layout.set(awful.layout.suit.fair.horizontal)
                end,
            },
        },
    },
    {
        'F&loating',
        function()
            awful.layout.set(awful.layout.suit.floating)
        end,
    },
}

local sysopts = {
    { '&Restart', 'reboot' },
    { 'L&ogout', 'pkill -u -KILL ' .. os.getenv 'USER' },
    { '&Lock', 'slock' },
    { '&Power Off', 'poweroff' },
}

local mymainmenu = awful.menu {
    items = {
        { '&System', sysopts },
        { '&Terminal', terminal },
        { '&Editor', editor_cmd },
        { '&Browser', os.getenv 'BROWSER' },
        {
            '&Office Suite',
            {
                { '&Writer', 'libreoffice --writer' },
                { '&Impress', 'libreoffice --impress' },
                { '&Calc', 'libreoffice --calc' },
            },
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
    awful.tag(
        { ' ૧ ', ' ૨ ', ' ૩ ', ' ૪ ', ' ૫ ', ' ૬ ', ' ૭ ', ' ૮ ', ' ૯ ' },
        s,
        awful.layout.layouts[1]
    )

    s.mypromptbox = awful.widget.prompt()
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(awful.button({}, 1, function()
        layoutmenu:toggle { coords = { x = 0, y = 0 } }
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
        widget_template = {
            {
                nil,
                {
                    {
                        widget = wibox.container.margin,
                        margins = dpi(2),
                        {
                            { widget = wibox.widget.imagebox, id = 'icon_role' },
                            id = 'icon_margin_role',
                            left = 4,
                            widget = wibox.container.margin,
                        },
                    },

                    layout = wibox.layout.fixed.horizontal,
                },
                expand = 'outside',
                layout = wibox.layout.align.horizontal,
            },
            id = 'background_role',
            widget = wibox.container.background,
        },
    }

    -- Create the wibox
    s.topwibox = awful.wibar { height = dpi(30), position = 'top', screen = s }
    s.bottomwibox = awful.wibar { height = dpi(30), position = 'bottom', screen = s }

    -- Add widgets to the wibox
    s.topwibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 10,
            s.mylayoutbox,
            s.mytaglist,
            s.mypromptbox,
        },
        { -- Right widgets
            layout = wibox.layout.flex.horizontal,
            spacing = 10,
            s.mytasklist,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 10,
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
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(30),
            cpu_bars_widget,
            memory_widget,
        },
        { -- Right widgets
            valign = 'center',
            halign = 'center',
            layout = wibox.container.place,
            spotify_widget,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(30),
            pipewire_widget,
            brightnessctl_widget,
            nm_widget,
            battery_widget,
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

local spotify = lain.util.quake {
    app = terminal,
    extra = '-e spt',
    name = 'spt',
    argname = '--class %s',
    width = 0.5,
    height = 0.75,
    horiz = 'center',
    vert = 'center',
}

local gkeep = lain.util.quake {
    app = terminal,
    extra = '-e nvim -c GkeepOpen',
    name = 'gkeep',
    argname = '--class %s',
    width = 0.5,
    height = 0.75,
    horiz = 'center',
    vert = 'center',
}

-- {{{ Key bindings
local globalkeys = gears.table.join(
    key({ modkey }, 'b', function()
        for _, c in ipairs(client.get()) do
            if c.class:match '^Brave%-browser' then
                c:jump_to()
                return
            end
        end
        -- urgent tags are automatically focused in this config
        awful.util.spawn 'brave'
    end),

    key({ modkey }, '=', function()
        util.useless_gaps_resize(1)
    end, { description = 'increment useless gaps', group = 'gaps' }),

    key({ modkey }, '-', function()
        util.useless_gaps_resize(-1)
    end, { description = 'decrement useless gaps', group = 'gaps' }),

    key({ modkey }, '0', function()
        util.useless_gaps_resize()
    end, { description = 'reset gaps', group = 'gaps' }),

    key({ modkey }, 'c', function()
        awful.util.spawn 'rofi -show calc'
    end, { description = 'calculator', group = 'launcher' }),

    key({ modkey }, 'p', function()
        awful.util.spawn 'passmenu -i -p '
    end, { description = 'select password', group = 'menus' }),

    key({ modkey }, 'e', function()
        awful.util.spawn 'rofi -show emoji'
    end, { description = 'select emojis', group = 'menus' }),

    key({ modkey }, 'u', awful.client.urgent.jumpto, { description = 'jump to urgent client', group = 'client' }),

    key({ modkey }, 'd', function()
        awful.util.spawn 'rofi -show drun -show-icons -display-drun ::'
    end, { description = 'run desktop apps', group = 'menus' }),

    key({ modkey }, 'w', function()
        awful.util.spawn [[wifimenu]]
    end, { description = 'configure wifi network', group = 'menus' }),

    key({ modkey }, 'r', function()
        awful.util.spawn 'rofi -show run -display-run ::'
    end, { description = 'run command', group = 'menus' }),

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

    key({ modkey }, 'z', function()
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
        gkeep:toggle()
    end, { description = 'toggle google keep window', group = 'launcher' }),

    key({ modkey }, 's', function()
        spotify:toggle()
    end, { description = 'toggle spotify', group = 'launcher' }),

    awful.key({ modkey }, 'F1', hotkeys_popup.show_help, { description = 'show help', group = 'awesome' }),

    key({ modkey }, 'Return', function()
        awful.spawn(terminal)
    end, { description = 'open a terminal', group = 'launcher' }),

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

    key({ modkey, 'Shift' }, 'Return', function(c)
        c:swap(awful.client.getmaster())
    end, { description = 'move to master', group = 'client' }),

    key({ modkey }, 'o', function(c)
        c:move_to_screen()
    end, { description = 'move to screen', group = 'client' }),

    key({ modkey }, 't', function(c)
        c.ontop = not c.ontop
    end, { description = 'toggle keep on top', group = 'client' }),

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

local abbreviation = function(str)
    local template = [[sh -c 'sleep 0.2 ; xdotool type --clearmodifiers "%s" ; xdotool keyup super']]
    return function()
        awful.util.spawn(string.format(template, str))
    end
end

-- abbreviations
globalkeys = gears.table.join(
    globalkeys,
    -- Move client to tag.
    key({ modkey }, 'a', function()
        modalbind.grab {
            keymap = {
                { 'separator', 'Details' },
                { 'n', abbreviation 'Nimai Patel', 'name' },
                { 'e', abbreviation 'nimai.m.patel@gmail.com', 'email' },
                { 'g', abbreviation 'https://www.github.com/nimaipatel', 'github' },
                { 'separator', 'Dates' },
                { 'd', abbreviation '$(date +%d/%m/%Y)', 'date in dd/mm/yyyy format' },
                { 't', abbreviation '$(date +%I:%M%p)', 'time in h:m:[AM/PM] format' },
                { 'w', abbreviation '$(date +%A)', 'day of the week' },
                { 's', abbreviation '$(date)', 'output of unix date command' },
            },
            name = 'abbreviations',
            stay_in_mode = false,
        }
    end)
)

globalkeys = gears.table.join(
    globalkeys,
    -- Move client to tag.
    key({ modkey }, 'space', function()
        layoutmenu:toggle { coords = { x = 0, y = 0 } }
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

    { rule = { instance = 'brave-browser' }, properties = { tag = ' ૨ ' } },
    { rule = { instance = 'libreoffice' }, properties = { tag = ' ૩ ' } },
    { rule = { instance = 'soffice' }, properties = { tag = ' ૩ ' } },
    { rule = { class = 'Spotify' }, properties = { tag = ' ૪ ' } },
    { rule = { instance = 'whatsapp-nativefier-d40211' }, properties = { tag = ' ૫ ' } },
    { rule = { instance = 'scrcpy' }, properties = { floating = true, tag = ' ૯ ' } },

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
                c.floating = not c.floating
                c:raise()
            else
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
                awful.titlebar.widget.stickybutton(c),
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
            margins = dpi(2),

            { -- Left
                awful.titlebar.widget.iconwidget(c),
                buttons = buttons,
                layout = wibox.layout.fixed.horizontal,
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

    local file = io.open('/tmp/awesomewm-last-selected-tags', 'w+')

    for s in screen do
        file:write(s.selected_tag.index, '\n')
    end

    file:close()
end)

awesome.connect_signal('startup', function()
    local file = io.open('/tmp/awesomewm-last-selected-tags', 'r')
    if not file then
        return
    end

    local selected_tags = {}

    for line in file:lines() do
        table.insert(selected_tags, tonumber(line))
    end

    for s in screen do
        local i = selected_tags[s.index]
        local t = s.tags[i]
        t:view_only()
    end

    file:close()
end)

require 'autostart'

client.connect_signal('manage', function(c)
    if c.class == nil then
        c.minimized = true
        c:connect_signal('property::class', function()
            awful.rules.apply(c)
        end)
    end
end)

client.connect_signal('property::urgent', function(c)
    c.minimized = false
    c:jump_to()
end)
-- }}}
