local gears = require 'gears'
local wibox = require 'wibox'
local beautiful = require 'beautiful'
local json = require 'utils.json'

math.randomseed(os.time())

local quotes_dir = gears.filesystem.get_configuration_dir() .. '/assets/quotes/'

local get_quote = function()
    local quotes = io.open(quotes_dir .. '/quotes.json', 'r')
    if quotes then
        quotes = quotes:read('*all')
        quotes = json.decode(quotes)
        quotes = quotes["quotes"]
        local rand = math.random(1, #quotes)
        return quotes[rand]
    end
end

local quotes_widget = wibox.widget {
    layout = wibox.container.scroll.horizontal,
    step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
    speed = 100,
    {
        id = 'text',
        font = beautiful.font,
        widget = wibox.widget.textbox,
    },
}

local text = quotes_widget:get_children_by_id('text')[1]

local main_loop = function()
    local quote = get_quote()
    text:set_markup(quote.text .. ' — ' .. quote["author"])
end

quotes_widget:connect_signal('button::press', function(_, _, _, button)
    if button == 1 then
        main_loop()
    end
end)


gears.timer {
    timeout = 5 * 60,
    call_now = true,
    autostart = true,
    callback = main_loop,
}

return quotes_widget
