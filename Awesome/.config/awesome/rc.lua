pcall(require, 'luarocks.loader')

local xresources = require 'beautiful.xresources'
local dpi = xresources.apply_dpi

local lain = require 'lain'
local markup = lain.util.markup

-- Standard awesome library
local gears = require 'gears'
local awful = require 'awful'
require 'awful.autofocus'
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local naughty = require 'naughty'
local menubar = require 'menubar'
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

require 'base16'
require 'beautiful_init'

terminal = os.getenv 'TERMINAL' or 'kitty'
editor = os.getenv 'EDITOR' or 'nvim'
editor_cmd = terminal .. ' -e ' .. editor

modkey = 'Mod4'

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.floating,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
}

local myawesomemenu = {
    {
        'hotkeys',
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end,
    },
    { 'manual', terminal .. ' -e man awesome' },
    { 'edit config', editor_cmd .. ' ' .. awesome.conffile },
    { 'restart', awesome.restart },
    {
        'quit',
        function()
            awesome.quit()
        end,
    },
}

local mymainmenu = awful.menu {
    items = {
        { 'awesome', myawesomemenu, beautiful.awesome_icon },
        { 'open terminal', terminal },
        { 'open editor', editor_cmd },
        { 'open browser', os.getenv 'BROWSER' },
        {
            'office suite',
            {
                { 'open writer', 'lowriter' },
                { 'open impress', 'loimpress' },
                { 'open calc', 'localc' },
            },
        },
    },
}

local mylauncher = awful.widget.launcher { image = beautiful.awesome_icon, menu = mymainmenu }

menubar.utils.terminal = terminal -- Set the terminal for applications that require it

local mykeyboardlayout = awful.widget.keyboardlayout()

local mytextclock = wibox.widget.textclock('%A %d %B, %Y %I:%M%p ', 10)

-- Create a wibox for each screen and add it
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

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == 'function' then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

screen.connect_signal('property::geometry', set_wallpaper)

local playerctl_title_widget = wibox.widget {
    markup = 'Nothing Playing',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox,
}

local playerctl_artist_widget = wibox.widget {
    markup = 'Nothing Playing',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox,
}

local playerctl_art_widget = wibox.widget {
    image = 'default_image.png',
    resize = true,
    widget = wibox.widget.imagebox,
}

local playerctl_name_widget = wibox.widget {
    markup = 'No players',
    align = 'center',
    valign = 'center',
    widget = wibox.widget.textbox,
}

local spotify_icon = wibox.widget {
    widget = wibox.widget.imagebox,
}

local playerctl_widget = wibox.widget {
    layout = wibox.layout.align.horizontal,
    playerctl_artist_widget,
    spotify_icon,
    wibox.widget {
        layout = wibox.container.scroll.horizontal,
        max_size = 300,
        step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
        speed = 50,
        playerctl_title_widget,
    },
}

awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    awful.tag(
        { ' ૧ ', ' ૨ ', ' ૩ ', ' ૪ ', ' ૫ ', ' ૬ ', ' ૭ ', ' ૮ ', ' ૯ ' },
        s,
        awful.layout.layouts[1]
    )

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 3, function()
            awful.layout.inc(-1)
        end),
        awful.button({}, 4, function()
            awful.layout.inc(1)
        end),
        awful.button({}, 5, function()
            awful.layout.inc(-1)
        end)
    ))
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
                        margins = dpi(3),
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
    s.topwibox = awful.wibar { height = dpi(25), position = 'top', screen = s }
    s.bottomwibox = awful.wibar { height = dpi(25), position = 'bottom', screen = s }

    -- Add widgets to the wibox
    s.topwibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 10,
            mylauncher,
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
            s.mylayoutbox,
        },
    }
    s.bottomwibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            spacing = 10,
            lain.widget.cpu {
                settings = function()
                    local map = function(perc)
                        local ret
                        if perc > 80 then
                            ret = '█'
                        elseif perc > 70 then
                            ret = '█'
                        elseif perc > 60 then
                            ret = '▇'
                        elseif perc > 50 then
                            ret = '▆'
                        elseif perc > 40 then
                            ret = '▅'
                        elseif perc > 30 then
                            ret = '▄'
                        elseif perc > 20 then
                            ret = '▃'
                        elseif perc > 10 then
                            ret = '▂'
                        else
                            ret = '▁'
                        end
                        local fg = markup.fg.color
                        if perc > 70 then
                            ret = fg(BASE16_COLORS.base08, ret)
                        elseif perc > 20 then
                            ret = fg(BASE16_COLORS.base0A, ret)
                        else
                            ret = fg(BASE16_COLORS.base0B, ret)
                        end
                        return ret
                    end

                    local fmt = 'CPU '
                    fmt = fmt .. map(cpu_now[0].usage)
                    fmt = fmt .. map(cpu_now[1].usage)
                    fmt = fmt .. map(cpu_now[2].usage)
                    fmt = fmt .. map(cpu_now[3].usage)

                    widget:set_markup(fmt)
                end,
            },
            lain.widget.mem {
                settings = function()
                    widget:set_markup('MEM ' .. mem_now.perc .. '%')
                end,
            },
            lain.widget.fs {
                settings = function()
                    widget:set_markup('root: ' .. fs_now['/'].percentage .. '% used')
                end,
            },
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
        },
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            lain.widget.bat {
                timeout = 1,
                battery = 'BAT1',
                ac = 'ACAD',
                settings = function()
                    local map = function(bat)
                        local fg = markup.fg.color
                        local perc = bat.perc
                        local ret
                        if perc > 90 then
                            ret = ''
                        elseif perc > 80 then
                            ret = ''
                        elseif perc > 70 then
                            ret = ''
                        elseif perc > 60 then
                            ret = ''
                        elseif perc > 50 then
                            ret = ''
                        elseif perc > 40 then
                            ret = ''
                        elseif perc > 30 then
                            ret = ''
                        elseif perc > 20 then
                            ret = ''
                        elseif perc > 10 then
                            ret = ''
                        else
                            ret = ''
                        end

                        if perc > 70 then
                            ret = fg(BASE16_COLORS.base0B, ret)
                        elseif perc > 20 then
                            ret = fg(BASE16_COLORS.base0A, ret)
                        else
                            ret = fg(BASE16_COLORS.base08, ret)
                        end

                        if bat.status == 'Charging' then
                            ret = fg(BASE16_COLORS.base0A, ' ') .. ret
                        end

                        return ret
                    end
                    widget:set_markup(map(bat_now) .. ' ' .. bat_now.perc .. '% ')
                end,
            },
        },
    }
end)
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

local pulsemixer = lain.util.quake {
    app = terminal,
    extra = '-e pulsemixer',
    name = 'pulsemixer',
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
    awful.key({ modkey }, '=', function()
        lain.util.useless_gaps_resize(1)
    end, { description = 'increment useless gaps', group = 'tag' }),

    awful.key({ modkey }, '-', function()
        lain.util.useless_gaps_resize(-1)
    end, { description = 'decrement useless gaps', group = 'tag' }),

    awful.key({}, 'XF86MonBrightnessDown', function()
        awful.util.spawn 'brightnessctl set 10%-'
    end),
    awful.key({}, 'XF86MonBrightnessUp', function()
        awful.util.spawn 'brightnessctl set +10%'
    end),
    awful.key({ modkey }, 's', hotkeys_popup.show_help, { description = 'show help', group = 'awesome' }),
    awful.key({ modkey }, 'Left', awful.tag.viewprev, { description = 'view previous', group = 'tag' }),
    awful.key({ modkey }, 'Right', awful.tag.viewnext, { description = 'view next', group = 'tag' }),
    awful.key({ modkey }, 'Escape', awful.tag.history.restore, { description = 'go back', group = 'tag' }),

    awful.key({ modkey }, 'j', function()
        awful.client.focus.byidx(1)
    end, { description = 'focus next by index', group = 'client' }),
    awful.key({ modkey }, 'k', function()
        awful.client.focus.byidx(-1)
    end, { description = 'focus previous by index', group = 'client' }),
    awful.key({ modkey }, 'w', function()
        mymainmenu:show()
    end, { description = 'show main menu', group = 'awesome' }),

    -- Layout manipulation
    awful.key({ modkey, 'Shift' }, 'j', function()
        awful.client.swap.byidx(1)
    end, { description = 'swap with next client by index', group = 'client' }),
    awful.key({ modkey, 'Shift' }, 'k', function()
        awful.client.swap.byidx(-1)
    end, { description = 'swap with previous client by index', group = 'client' }),
    awful.key({ modkey, 'Control' }, 'j', function()
        awful.screen.focus_relative(1)
    end, { description = 'focus the next screen', group = 'screen' }),
    awful.key({ modkey, 'Control' }, 'k', function()
        awful.screen.focus_relative(-1)
    end, { description = 'focus the previous screen', group = 'screen' }),
    awful.key({ modkey }, 'u', awful.client.urgent.jumpto, { description = 'jump to urgent client', group = 'client' }),
    awful.key({ modkey }, 'Tab', function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end, { description = 'go back', group = 'client' }),

    -- Standard program
    awful.key({ modkey }, 'b', function(c)
        pulsemixer:toggle()
    end, { description = 'toggle pulsemixer', group = 'awesome' }),

    awful.key({ modkey }, 'g', function(c)
        gkeep:toggle()
    end, { description = 'toggle pulsemixer', group = 'awesome' }),

    awful.key({ modkey }, 'Return', function()
        awful.spawn(terminal)
    end, { description = 'open a terminal', group = 'launcher' }),
    awful.key({ modkey, 'Control' }, 'r', awesome.restart, { description = 'reload awesome', group = 'awesome' }),
    awful.key({ modkey, 'Shift' }, 'q', awesome.quit, { description = 'quit awesome', group = 'awesome' }),

    awful.key({ modkey }, 'l', function()
        awful.tag.incmwfact(0.05)
    end, { description = 'increase master width factor', group = 'layout' }),
    awful.key({ modkey }, 'h', function()
        awful.tag.incmwfact(-0.05)
    end, { description = 'decrease master width factor', group = 'layout' }),
    awful.key({ modkey, 'Shift' }, 'h', function()
        awful.tag.incnmaster(1, nil, true)
    end, { description = 'increase the number of master clients', group = 'layout' }),
    awful.key({ modkey, 'Shift' }, 'l', function()
        awful.tag.incnmaster(-1, nil, true)
    end, { description = 'decrease the number of master clients', group = 'layout' }),
    awful.key({ modkey, 'Control' }, 'h', function()
        awful.tag.incncol(1, nil, true)
    end, { description = 'increase the number of columns', group = 'layout' }),
    awful.key({ modkey, 'Control' }, 'l', function()
        awful.tag.incncol(-1, nil, true)
    end, { description = 'decrease the number of columns', group = 'layout' }),
    awful.key({ modkey }, 'space', function()
        awful.layout.inc(1)
    end, { description = 'select next', group = 'layout' }),
    awful.key({ modkey, 'Shift' }, 'space', function()
        awful.layout.inc(-1)
    end, { description = 'select previous', group = 'layout' }),

    awful.key({ modkey, 'Control' }, 'n', function()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal('request::activate', 'key.unminimize', { raise = true })
        end
    end, { description = 'restore minimized', group = 'client' }),

    -- Prompt
    awful.key({ modkey }, 'r', function()
        awful.screen.focused().mypromptbox:run()
    end, { description = 'run prompt', group = 'launcher' }),

    awful.key({ modkey }, 'x', function()
        awful.prompt.run {
            prompt = 'Run Lua code: ',
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = awful.util.eval,
            history_path = awful.util.get_cache_dir() .. '/history_eval',
        }
    end, { description = 'lua execute prompt', group = 'awesome' }),
    -- Menubar
    awful.key({ modkey }, 'p', function()
        menubar.show()
    end, { description = 'show the menubar', group = 'launcher' })
)

local clientkeys = gears.table.join(
    awful.key({ modkey }, 'f', function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, { description = 'toggle fullscreen', group = 'client' }),
    awful.key({ modkey, 'Shift' }, 'c', function(c)
        c:kill()
    end, { description = 'close', group = 'client' }),
    awful.key(
        { modkey, 'Control' },
        'space',
        awful.client.floating.toggle,
        { description = 'toggle floating', group = 'client' }
    ),
    awful.key({ modkey, 'Control' }, 'Return', function(c)
        c:swap(awful.client.getmaster())
    end, { description = 'move to master', group = 'client' }),
    awful.key({ modkey }, 'o', function(c)
        c:move_to_screen()
    end, { description = 'move to screen', group = 'client' }),
    awful.key({ modkey }, 't', function(c)
        c.ontop = not c.ontop
    end, { description = 'toggle keep on top', group = 'client' }),
    awful.key({ modkey }, 'n', function(c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
    end, { description = 'minimize', group = 'client' }),
    awful.key({ modkey }, 'm', function(c)
        c.maximized = not c.maximized
        c:raise()
    end, { description = '(un)maximize', group = 'client' }),
    awful.key({ modkey, 'Control' }, 'm', function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
    end, { description = '(un)maximize vertically', group = 'client' }),
    awful.key({ modkey, 'Shift' }, 'm', function(c)
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
        awful.key({ modkey }, '#' .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                tag:view_only()
            end
        end, { description = 'view tag #' .. i, group = 'tag' }),
        -- Toggle tag display.
        awful.key({ modkey, 'Control' }, '#' .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end, { description = 'toggle tag #' .. i, group = 'tag' }),
        -- Move client to tag.
        awful.key({ modkey, 'Shift' }, '#' .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:move_to_tag(tag)
                    tag:view_only()
                end
            end
        end, { description = 'move focused client to tag #' .. i, group = 'tag' }),
        -- Toggle tag on focused client.
        awful.key({ modkey, 'Control', 'Shift' }, '#' .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end, { description = 'toggle focused client on tag #' .. i, group = 'tag' })
    )
end

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
local function double_click_event_handler(double_click_event)
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
    { rule = { instance = 'scrcpy' }, properties = { tag = ' ૯ ' } },

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
-- }}}
