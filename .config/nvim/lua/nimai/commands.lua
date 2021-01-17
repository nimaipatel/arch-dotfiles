vim.api.nvim_exec([[
    command! -nargs=0 Gst :!git status
    command! -nargs=0 Gd :!git diff
    command! -nargs=0 Gb :!git branch --show-current
    command! -nargs=0 Conf :cd $XDG_CONFIG_HOME/nvim | e $XDG_CONFIG_HOME/nvim/init.lua
    command! -nargs=0 CD :cd %:h | cd `git rev-parse --show-toplevel`
]], true)
