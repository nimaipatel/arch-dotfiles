local gears = require 'gears'

local M = {}

local list_reverse = function(list)
    local reverse = {}
    for i = #list, 1, -1 do
        reverse[#reverse + 1] = list[i]
    end
    return reverse

end

local GT = 1
local LT = -1
local EQ = 0
local compare_dates = function(first, second)
    local h1, m1, s1 = string.match(first, '(.+):(.+):(.+)')
    local h2, m2, s2 = string.match(second, '(.+):(.+):(.+)')

    if h1 > h2 then
        return GT
    elseif h1 < h2 then
        return LT
    end

    -- hour is same --

    if m1 > m2 then
        return GT
    elseif m1 < m2 then
        return LT
    end

    -- minute is same --

    if s1 > s2 then
        return GT
    elseif s1 < s2 then
        return LT
    end

    -- second is also same i.e. both are equal --

    return EQ
end

M.dynamic = function(wallpapers_list, cb, pollrate)
    pollrate = pollrate or (10 * 60)
    cb = cb or gears.wallpaper.maximized
    if not wallpapers_list then
        error('wallpapers not provided')
        return
    else
        wallpapers_list = list_reverse(wallpapers_list)
    end

    gears.timer {
        timeout = pollrate,
        call_now = true,
        autostart = true,
        callback = function()
            local current_time = tostring(os.date('%X'))
            for _, iter in ipairs(wallpapers_list) do
                local time = iter.time
                local wallpaper = iter.wallpaper
                if compare_dates(current_time, time) == GT then
                    cb(wallpaper)
                    return
                end
            end
            gears.wallpaper.maximized(wallpapers_list[#wallpapers_list].wallpaper)
        end,
    }
end


return M
