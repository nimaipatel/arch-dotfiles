local awful = require "awful"
awful.spawn.easy_async_with_shell([[kitty @ --to unix:/tmp/mykitty-* ls]], function (out )
    print(out)
end)
