-- check if we are in GNU/Linux
local is_gnu_linux = (not not vim.fn.system('uname'):match 'Linux')

-- space bar is leader key
vim.g.mapleader = ' '

-- quicker update
vim.opt.updatetime = 50

-- whoaaa
vim.opt.cmdheight = 0

-- fix space for signs
vim.opt.signcolumn = 'yes'

vim.opt.termguicolors = true

-- recurse into directories to search for files with :find
vim.opt.path:append '**'

-- don't wrap lines
vim.opt.wrap = false

-- search options
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true

-- netrw default style
vim.g.netrw_liststyle = 3

-- copy and paste with OS clipboard
vim.opt.clipboard = 'unnamed,unnamedplus'

-- whitespace characters
vim.opt.listchars = 'tab:→ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»'

-- completion style
vim.opt.completeopt = 'menuone,noselect'

-- expand environment variables even if they are in braces
vim.opt.isfname:append '{,}'

-- cringe
vim.opt.mouse = 'a'

vim.cmd [[xnoremap <EXPR> v (mode() ==# 'v' ? "\<C-V>" : mode() ==# 'V' ? 'v' : 'V')]]

vim.cmd [[inoremap , ,<C-g>u]]
vim.cmd [[inoremap . .<C-g>u]]
vim.cmd [[inoremap ! !<C-g>u]]
vim.cmd [[inoremap ? ?<C-g>u]]

vim.cmd [[nnoremap <EXPR> k (v:count > 5 ? "m'" . v:count : "") . 'k']]
vim.cmd [[nnoremap <EXPR> j (v:count > 5 ? "m'" . v:count : "") . 'j']]

local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd 'packadd packer.nvim'
end

-- U for utils?
U = {}

U.SEVERITY_SIGNS = {
    ERROR = '',
    WARN = '',
    INFO = '',
    HINT = '',
    DEBUG = '',
    TRACE = '✎',
}

U.source_colors = function()
    vim.cmd [[ source ~/.config/nvim/base16.lua ]]
end

U.base16_config = function()
    require('base16-colorscheme').setup(BASE16_COLORS)
    vim.api.nvim_set_hl(0, 'TabLineFill', { link = 'Normal' })

    vim.api.nvim_set_hl(0, 'TelescopeSelection', { link = 'Visual' })
    vim.api.nvim_set_hl(0, 'TelescopeNormal', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'TelescopePromptNormal', { link = 'TelescopeNormal' })
    vim.api.nvim_set_hl(0, 'TelescopeBorder', { link = 'TelescopeNormal' })
    vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { link = 'TelescopeBorder' })
    vim.api.nvim_set_hl(0, 'TelescopeTitle', { link = 'TelescopeBorder' })
    vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { link = 'TelescopeTitle' })
    vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { link = 'TelescopeTitle' })
    vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { link = 'TelescopeTitle' })
    vim.api.nvim_set_hl(0, 'TelescopePromptPrefix', { link = 'Identifier' })

    vim.api.nvim_set_hl(0, 'LspReferenceText', { link = 'CursorLine' })
    vim.api.nvim_set_hl(0, 'LspReferenceWrite', { link = 'CursorLine' })
    vim.api.nvim_set_hl(0, 'LspReferenceRead', { link = 'CursorLine' })

    vim.api.nvim_set_hl(0, 'DiagnosticError', { fg = BASE16_COLORS.base08 })
    vim.api.nvim_set_hl(0, 'DiagnosticWarn', { fg = BASE16_COLORS.base0A })
    vim.api.nvim_set_hl(0, 'DiagnosticInfo', { fg = BASE16_COLORS.base06 })
    vim.api.nvim_set_hl(0, 'DiagnosticHint', { fg = BASE16_COLORS.base0C })

    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineError', { sp = BASE16_COLORS.base08, undercurl = true })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarning', { sp = BASE16_COLORS.base0A, undercurl = true })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineWarn', { sp = BASE16_COLORS.base0A, undercurl = true })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInfo', { sp = BASE16_COLORS.base06, undercurl = true })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineInformation', { sp = BASE16_COLORS.base06, undercurl = true })
    vim.api.nvim_set_hl(0, 'DiagnosticUnderlineHint', { sp = BASE16_COLORS.base0C, undercurl = true })


    vim.api.nvim_set_hl(0, 'IlluminatedWordRead', { bg = BASE16_COLORS.base01 })
    vim.api.nvim_set_hl(0, 'IlluminatedWordText', { bg = BASE16_COLORS.base01 })
    vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', { bg = BASE16_COLORS.base01 })

    vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'LineNr', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'signcolumn', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'VertSplit', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
    vim.api.nvim_set_hl(0, 'CmpItemAbbr', { bg = 'NONE' })
end

U.lualine_config = function()
    vim.opt.showmode = false

    local colors = {
        black = BASE16_COLORS.base00,
        white = BASE16_COLORS.base06,
        red = BASE16_COLORS.base08,
        green = BASE16_COLORS.base0B,
        blue = BASE16_COLORS.base0D,
        yellow = BASE16_COLORS.base0A,
        darkgray = BASE16_COLORS.base01,
        lightgray = BASE16_COLORS.base02,
        inactivegray = BASE16_COLORS.base03,
        gray = BASE16_COLORS.base04,
    }

    local base16_lualine_colors = {
        normal = {
            a = { bg = colors.gray, fg = colors.black, gui = 'bold' },
            b = { bg = colors.lightgray, fg = colors.white },
            c = { bg = colors.darkgray, fg = colors.gray },
        },
        insert = {
            a = { bg = colors.blue, fg = colors.black, gui = 'bold' },
            b = { bg = colors.lightgray, fg = colors.white },
            c = { bg = colors.lightgray, fg = colors.white },
        },
        visual = {
            a = { bg = colors.yellow, fg = colors.black, gui = 'bold' },
            b = { bg = colors.lightgray, fg = colors.white },
            c = { bg = colors.inactivegray, fg = colors.black },
        },
        replace = {
            a = { bg = colors.red, fg = colors.black, gui = 'bold' },
            b = { bg = colors.lightgray, fg = colors.white },
            c = { bg = colors.black, fg = colors.white },
        },
        command = {
            a = { bg = colors.green, fg = colors.black, gui = 'bold' },
            b = { bg = colors.lightgray, fg = colors.white },
            c = { bg = colors.inactivegray, fg = colors.black },
        },
        inactive = {
            a = { bg = colors.darkgray, fg = colors.gray, gui = 'bold' },
            b = { bg = colors.darkgray, fg = colors.gray },
            c = { bg = colors.darkgray, fg = colors.gray },
        },
    }

    require('lualine').setup {
        options = {
            section_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' },
            theme = base16_lualine_colors,
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = { 'branch', 'diff' },
            lualine_c = {
                'filename',
                function()
                    return require('nvim-lightbulb').get_status_text()
                end,
            },
            lualine_x = { 'encoding', 'fileformat', 'filetype' },
            lualine_y = { 'progress' },
            lualine_z = { 'location' },
        },
    }

    vim.opt.laststatus = 3
end

U.refresh_base_16 = function()
    U.source_colors()
    U.base16_config()
    U.lualine_config()
    require('cmp.core').new()
end

local packer = require 'packer'

U.source_colors()

packer.startup(function(use)
    use {
        'lewis6991/impatient.nvim',
        config = function()
            require 'impatient'
        end,
    }

    use {
        'stevearc/gkeep.nvim',
        run = ':UpdateRemotePlugins',
        config = function()
            require('legendary').setup()
            require('which-key').register({
                name = 'google keep',
                k = { ':GkeepToggle<cr>', 'toggle google keep' },
                n = { ':GkeepNew<cr>', 'new google keep' },
                r = { ':GkeepRefresh<cr>', 'refresh google keep' },
                c = { ':GkeepCheck<cr>', 'toggle checkbox' },
            }, {
                prefix = '<leader>k',
            })
        end,
    }

    use {
        'stevearc/dressing.nvim',
        config = function()
            require('dressing').setup {
                input = {
                    winblend = 0,
                },
                select = {
                    telescope = {
                        layout_config = {
                            bottom_pane = {
                                height = 0.50,
                            },
                        },
                    },
                },
            }
        end,
    }

    use {
        'simrat39/desktop-notify.nvim',
        config = function()
            require('desktop-notify').override_vim_notify()
        end,
    }

    use {
        'rcarriga/nvim-notify',
        disable = is_gnu_linux,
        config = function()
            local notify = require 'notify'
            vim.notify = notify
            notify.setup {
                background_colour = 'Normal',
                icons = {
                    DEBUG = U.SEVERITY_SIGNS.DEBUG,
                    ERROR = U.SEVERITY_SIGNS.ERROR,
                    INFO = U.SEVERITY_SIGNS.INFO,
                    TRACE = U.SEVERITY_SIGNS.TRACE,
                    WARN = U.SEVERITY_SIGNS.WARN,
                },
                render = 'default',
                stages = 'slide',
                timeout = 5000,
            }
        end,
    }

    use {
        'monaqa/dial.nvim',
        config = function()
            local augend = require 'dial.augend'
            require('dial.config').augends:register_group {
                default = {
                    augend.integer.alias.decimal,
                    augend.integer.alias.hex,
                    augend.constant.new { elements = { 'true', 'false' } },
                    augend.constant.new { elements = { 'True', 'False' } },
                    augend.constant.new {
                        elements = {
                            'Sunday',
                            'Monday',
                            'Tuesday',
                            'Wednesday',
                            'Thursday',
                            'Friday',
                            'Saturday',
                        },
                    },
                    augend.constant.new {
                        elements = {
                            'sunday',
                            'monday',
                            'tuesday',
                            'wednesday',
                            'thursday',
                            'friday',
                            'saturday',
                        },
                    },
                    augend.constant.new {
                        elements = {
                            'January',
                            'February',
                            'March',
                            'April',
                            'May',
                            'June',
                            'July',
                            'August',
                            'September',
                            'October',
                            'November',
                            'December',
                        },
                    },
                    augend.constant.new {
                        elements = {
                            'january',
                            'february',
                            'march',
                            'april',
                            'may',
                            'june',
                            'july',
                            'august',
                            'september',
                            'october',
                            'november',
                            'december',
                        },
                    },

                    augend.date.alias['%d/%m/%Y'],
                },
            }
            vim.api.nvim_set_keymap('n', '<C-a>', require('dial.map').inc_normal(), { noremap = true })
            vim.api.nvim_set_keymap('n', '<C-x>', require('dial.map').dec_normal(), { noremap = true })
            vim.api.nvim_set_keymap('v', '<C-a>', require('dial.map').inc_visual(), { noremap = true })
            vim.api.nvim_set_keymap('v', '<C-x>', require('dial.map').dec_visual(), { noremap = true })
            vim.api.nvim_set_keymap('v', 'g<C-a>', require('dial.map').inc_gvisual(), { noremap = true })
            vim.api.nvim_set_keymap('v', 'g<C-x>', require('dial.map').dec_gvisual(), { noremap = true })
        end,
    }

    -- remove
    use {
        'mrjones2014/legendary.nvim',
        config = function()
            require('legendary').setup()

            require('legendary').bind_command {
                'RefreshColors',
                U.refresh_base_16,
                description = 'refresh generated base 16 colors',
            }

            require('legendary').bind_keymaps {
                {
                    'c*',
                    [[/\<<C-r>=expand('<cword>')<CR>\>\c<CR>``cgn]],
                    description = 'change word under cursor',
                    mode = { 'n' },
                },
                {
                    'c#',
                    [[?\<<C-r>=expand('<cword>')<CR>\>\c<CR>``cgN]],
                    description = 'change word under cursor',
                    mode = { 'n' },
                },
                {
                    'd*',
                    [[/\<<C-r>=expand('<cword>')<CR>\>\c<CR>``dgn]],
                    description = 'delete word under cursor',
                    mode = { 'n' },
                },
                {
                    'd#',
                    [[?\<<C-r>=expand('<cword>')<CR>\>\c<CR>``dgN]],
                    description = 'change word under cursor',
                    mode = { 'n' },
                },
            }

            require('legendary').bind_keymaps {
                {
                    '<C-k>',
                    '<UP>',
                    description = 'move up one line',
                    mode = { 'i' },
                },
                {
                    '<C-j>',
                    '<down>',
                    description = 'move down one line',
                    mode = { 'i' },
                },
            }

            require('legendary').bind_keymaps {
                {
                    '<A-j>',
                    '<Plug>(qf_qf_next)',
                    description = 'Goto next quick-fix list item',
                    mode = { 'n' },
                },
                {
                    '<A-k>',
                    '<Plug>(qf_qf_previous)',
                    description = 'Goto previous quick-fix list item',
                    mode = { 'n' },
                },
                {
                    '<C-j>',
                    '<Plug>(qf_loc_next)',
                    description = 'Goto next location list item',
                    mode = { 'n' },
                },
                {
                    '<C-k>',
                    '<Plug>(qf_loc_previous)',
                    description = 'Goto previous location list item',
                    mode = { 'n' },
                },
            }

            require('legendary').bind_autocmds {
                name = 'DiagFloats',
                clear = true,
                {
                    { 'CursorHold', 'CursorHoldI' },
                    function()
                        vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
                    end,
                    description = 'diagnostics hover window on cursor hold',
                },
            }

            require('legendary').bind_autocmds {
                name = 'AntiFloatingWindows',
                clear = true,
                {
                    'FileType',
                    'wincmd J',
                    opts = {
                        pattern = { 'null-ls-info', 'lspinfo' },
                    },
                    description = 'turn floating windows into regular splits',
                },
            }

            require('legendary').bind_autocmds {
                name = 'ReloadNvimOnSig',
                clear = true,
                {
                    'Signal',
                    opts = {
                        pattern = 'SIGUSR1',
                    },
                    'RefreshColors',
                    description = 'refresh neovim colors when USR1 signal intercepted',
                },
            }

            require('legendary').bind_autocmds {
                name = 'WindowSizeEqual',
                clear = true,
                {
                    'VimResized',
                    'wincmd =',
                    description = 'Resize panes when vim is resized',
                },
            }

            require('legendary').bind_autocmds {
                name = 'HighLightOnYank',
                clear = true,
                {
                    'TextYankPost',
                    function()
                        require('vim.highlight').on_yank()
                    end,
                    description = 'Highlight text on yanking',
                },
            }

            require('legendary').bind_autocmds {
                name = 'DisableHighLightOnMove',
                clear = true,
                {
                    { 'InsertEnter', 'CursorMoved' },
                    function()
                        vim.opt.hlsearch = false
                        vim.opt.cursorline = false
                    end,
                    description = 'Disable search highlighting and cursorline',
                },
            }

            for _, key in ipairs { '*', '#', 'n', 'N' } do
                require('legendary').bind_keymaps {
                    {
                        key,
                        key .. 'zz' .. ':set hlsearch cursorline<CR>',
                        mode = { 'n' },
                    },
                }
            end

            for _, key in ipairs { '<C-i>', '<C-o>', '<C-^>' } do
                require('legendary').bind_keymaps {
                    {
                        key,
                        key .. 'zz' .. ':set cursorline<CR>',
                        mode = { 'n' },
                    },
                }
            end

            require('legendary').bind_autocmds {
                name = 'TermSettings',
                clear = true,
                {
                    { 'TermOpen', 'BufEnter', 'BufWinEnter', 'WinEnter' },
                    'startinsert',
                    opts = { pattern = { 'term://*' } },
                    description = 'Start terminal mode in insert mode',
                },
                {
                    { 'BufLeave' },
                    'stopinsert',
                    opts = { pattern = { 'term://*' } },
                    description = 'leave terminal mode immediately when shell exits',
                },
                {
                    { 'TermClose' },
                    ':call nvim_input("<CR>")',
                    opts = { pattern = { 'term://*' } },
                    description = 'leave terminal mode immediately when shell exits',
                },
            }
        end,
    }

    use {
        'folke/which-key.nvim',
        config = function()
            -- no op for <C-z>
            vim.api.nvim_set_keymap('n', '<C-z>', '<nop>', { noremap = true, silent = true })

            -- when jumping to bottom, center the page
            vim.api.nvim_set_keymap('n', 'G', 'Gzz', { noremap = true, silent = true })

            -- easier indentation control in visual mode
            vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })
            vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })

            -- move lines up and down in visual mode
            vim.api.nvim_set_keymap('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
            vim.api.nvim_set_keymap('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

            vim.api.nvim_set_keymap('n', '<C-s>', ':wa<cr>', { noremap = true, silent = true })

            vim.opt.timeoutlen = 300
            local wk = require 'which-key'
            wk.setup {
                ignore_missing = true,
                popup_mappings = {
                    scroll_down = 'n',
                    scroll_up = 'p',
                },
                window = { border = 'rounded' },

                plugins = {
                    presets = {
                        operators = false,
                        motions = false,
                        text_objects = false,
                    },
                },
            }

            local t = function(s)
                return vim.api.nvim_replace_termcodes(s, true, true, true)
            end

            require('legendary').setup()
            wk.register({
                name = 'misc',
                q = { '<Plug>(qf_qf_toggle)', 'toggle quickfix' },
                l = { '<Plug>(qf_loc_toggle)', 'toggle location' },
                w = { ':set list!<CR>', 'Toggle whitespace' },
                r = { ':set wrap!<CR>', 'Toggle line wrapping' },
                s = { ':set spell!<CR>', 'Toggle spell check' },
                n = { ':set relativenumber!<CR>', 'Toggle relative line numbers' },
                e = { t ':cd ~/.config/nvim | e init.lua <cr>', 'Edit neovim config' },
                c = {
                    function()
                        vim.notify 'Re-compiling neovim config'
                        vim.cmd [[:source ~/.config/nvim/init.lua]]
                        vim.cmd [[:PackerCompile profile=true]]
                    end,
                    'Re-compile neovim config',
                },
            }, {
                prefix = '<leader>c',
            })

            require('legendary').setup()
            wk.register({
                ['H'] = { t [[<C-\><C-n><C-w>Ha]], 'Move window to left' },
                ['J'] = { t [[<C-\><C-n><C-w>Ja]], 'Move window down' },
                ['K'] = { t [[<C-\><C-n><C-w>Ha]], 'Move move window up' },
                ['L'] = { t [[<C-\><C-n><C-w>Ja]], 'Move window to right' },

                ['<C-h>'] = { t [[<C-\><C-n><C-w>h]], 'Go to the left window' },
                ['<C-j>'] = { t [[<C-\><C-n><C-w>j]], 'Go to the down window' },
                ['<C-k>'] = { t [[<C-\><C-n><C-w>k]], 'Go to the up window' },
                ['<C-l>'] = { t [[<C-\><C-n><C-w>l]], 'Go to the right window' },

                ['<C-w>'] = { t [[<C-\><C-n><C-w><C-w>]], 'Go to the last window' },

                ['<C-s>'] = { t [[<C-\><C-n><C-w>s]], 'Split window' },
                ['<C-v>'] = { t [[<C-\><C-n><C-w>v]], 'Split window vertically' },
            }, {
                mode = 't',
                prefix = '<C-w>',
            })
        end,
    }

    use {
        'michaelb/sniprun',
        run = 'bash ./install.sh',
        config = function()
            require('sniprun').setup {
                display = { 'NvimNotify' },
                display_options = {
                    notification_timeout = 5,
                },
            }
            require('legendary').setup()
            require('which-key').register({
                name = 'code runner',
                x = { ':SnipRun<CR>', 'execute code' },
                k = { ':SnipReset<CR>', 'kill execution' },
                c = { ':SnipClose<CR>', 'clear all output' },
            }, {
                prefix = '<leader>x',
            })
            require('which-key').register({
                name = 'code runner',
                x = { ':SnipRun<CR>', 'execute code' },
            }, {
                prefix = '<leader>x',
                mode = 'v',
            })
        end,
    }

    use {
        'glacambre/firenvim',
        run = function()
            vim.fn['firenvim#install'](1)
        end,
    }

    use 'baskerville/vim-sxhkdrc'
    use 'fladson/vim-kitty'

    use 'svban/YankAssassin.vim'

    use 'wbthomason/packer.nvim'

    use 'tpope/vim-rsi'

    use 'tpope/vim-sleuth'

    use 'tpope/vim-commentary'

    use 'tpope/vim-surround'

    use 'tpope/vim-repeat'

    -- remove
    use 'tpope/vim-eunuch'

    use {
        'tpope/vim-fugitive',
        config = function()
            require('legendary').setup()
            require('which-key').register({
                name = 'git',
                g = { ':Git ', 'prompt' },
                c = { ':Git commit ', 'Commit' },
                s = { ':Git status<CR>', 'Commit' },
            }, {
                prefix = '<leader>g',
                silent = false,
            })
        end,
    }

    use {
        'sindrets/diffview.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            vim.opt.fillchars:append 'diff:╱'

            require('legendary').bind_command {
                'DiffviewToggle',
                function()
                    local view = require('diffview.lib').get_current_view()

                    if view then
                        vim.cmd 'DiffviewClose'
                    else
                        vim.cmd 'DiffviewOpen'
                    end
                end,
                description = 'Toggle diff view',
            }

            require('legendary').setup()
            require('which-key').register({
                d = { ':DiffviewToggle<CR>', 'toggle diff view' },
            }, {
                prefix = '<leader>g',
                silent = false,
            })
        end,
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            local gitsigns = require 'gitsigns'
            local actions = require 'gitsigns.actions'
            local wk = require 'which-key'
            gitsigns.setup {
                signs = {
                    change = { text = '│' },
                    delete = { text = '│' },
                    topdelete = { text = '│' },
                    changedelete = { text = '│' },
                },
            }
            require('legendary').setup()
            wk.register({
                name = 'hunks',
                s = {
                    function()
                        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
                    end,
                    'Stage hunk',
                },
                r = {
                    function()
                        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
                    end,
                    'Reset hunk',
                },
            }, {
                mode = 'v',
                prefix = '<leader>h',
            })
            require('legendary').setup()
            wk.register({
                h = { actions.prev_hunk, 'Previous hunk' },
            }, {
                prefix = '[',
            })
            wk.register({
                h = { actions.next_hunk, 'Previous hunk' },
            }, {
                prefix = ']',
            })
            wk.register({
                name = 'hunks',
                s = { gitsigns.stage_hunk, 'Stage hunk' },
                u = { gitsigns.undo_stage_hunk, 'Undo stage hunk' },
                r = { gitsigns.reset_hunk, 'Reset hunk' },
                R = { gitsigns.reset_buffer, 'Reset buffer' },
                o = { gitsigns.preview_hunk, 'Preview hunk' },
                b = {
                    function()
                        gitsigns.blame_line(true)
                    end,
                    'Blame line',
                },
                S = { gitsigns.stage_buffer, 'Stage buffer' },
                U = { gitsigns.reset_buffer_index, 'Reset buffer index' },
                q = { ':Gitsigns setqflist<CR>', 'Quickfix list' },
                l = { ':Gitsigns setloclist<CR>', 'Location list' },
            }, {
                prefix = '<leader>h',
            })
        end,
    }

    use {
        'brenoprata10/nvim-highlight-colors',
        config = function()
            require('nvim-highlight-colors').setup {
                render = 'background',
                enable_tailwind = true,
            }
        end,
    }

    use {
        'ararslan/license-to-vim',
        config = function()
            vim.g.license_author = 'Patel, Nimai'
            vim.g.license_email = 'nimai.m.patel@gmail.com'
        end,
    }

    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
        config = function()
            require('nvim-tree').setup {}
            require('legendary').setup()
            require('which-key').register({
                e = { ':NvimTreeToggle<CR>', 'Toggle file explorer' },
            }, {
                prefix = '<leader>e',
            })
        end,
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'p00f/nvim-ts-rainbow',
        },
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {
                    'c',
                    'lua',
                    'haskell',
                    'bash',
                    'cmake',
                    'cpp',
                    'css',
                    'dart',
                    'fish',
                    'go',
                    'html',
                    'java',
                    'javascript',
                    'json',
                    'json5',
                    'lua',
                    'llvm',
                    'make',
                    'php',
                    'r',
                    'solidity',
                    'typescript',
                    'yaml',
                    'vim',
                },
                highlight = { enable = true },
                indent = { enable = true },
                rainbow = {
                    enable = true,
                    extended_mode = true,
                    max_file_lines = nil,
                },
            }
        end,
    }

    use {
        'm-demare/hlargs.nvim',
        requires = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('hlargs').setup()
        end,
    }

    use {
        'https://gitlab.com/yorickpeterse/nvim-dd',
        config = function()
            require('dd').setup {
                timeout = 1000,
            }
        end,
    }

    use {
        'https://github.com/williamboman/mason.nvim',
        config = function()
            require('mason').setup {
                ui = { border = 'rounded' },
            }
        end,
    }

    use { 'romainl/vim-qf' }

    use {
        'https://gitlab.com/yorickpeterse/nvim-pqf',
        config = function()
            require('pqf').setup {
                signs = {
                    error = U.SEVERITY_SIGNS.ERROR,
                    warning = U.SEVERITY_SIGNS.WARN,
                    info = U.SEVERITY_SIGNS.INFO,
                    hint = U.SEVERITY_SIGNS.HINT,
                },
            }
        end,
    }

    use {
        'amrbashir/nvim-docs-view',
        opt = true,
        cmd = { 'DocsViewToggle' },
        setup = function()
            require('legendary').setup()
            require('which-key').register({
                K = { ':DocsViewToggle<CR>', 'Docs' },
            }, {
                prefix = '<leader>l',
            })
        end,
        config = function()
            require('docs-view').setup {
                position = 'bottom',
            }
        end,
    }

    use {
        'RRethy/vim-illuminate',
        config = function()
            require('illuminate').configure {
                delay = 1500,
            }
        end,
    }

    use {
        'neovim/nvim-lspconfig',
        requires = {
            {
                'jose-elias-alvarez/null-ls.nvim',
                requires = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
            },
            { 'akinsho/flutter-tools.nvim' },
            { 'p00f/clangd_extensions.nvim' },
            { 'simrat39/rust-tools.nvim' },
        },

        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local lspconfig = require 'lspconfig'

            vim.diagnostic.config {
                underline = true,
                virtual_text = false,
                float = {
                    show_header = false,
                    border = 'rounded',
                    format = function(diagnostic)
                        for _, name in ipairs(vim.diagnostic.severity) do
                            if diagnostic.severity == vim.diagnostic.severity[name] then
                                return ('%s  %s (%s)'):format(
                                    U.SEVERITY_SIGNS[name],
                                    diagnostic.message,
                                    diagnostic.source
                                )
                            end
                        end
                    end,
                },
            }

            local on_attach = function(_, buffer)
                require('legendary').setup()
                require('which-key').register({
                    gd = { vim.lsp.buf.definition, 'Go to definition' },
                }, { buffer = buffer })

                require('legendary').setup()
                require('which-key').register({
                    ['<C-s>'] = { vim.lsp.buf.signature_help, 'Signature help' },
                }, { buffer = buffer, mode = 'i' })

                require('legendary').setup()
                require('which-key').register({
                    name = 'LSP',
                    f = {
                        function()
                            vim.lsp.buf.format {
                                async = true,
                                filter = function(formatter)
                                    local disabled_formatters = { 'tsserver', 'html', 'cssls' }
                                    for _, disabled in ipairs(disabled_formatters) do
                                        if formatter.name == disabled then
                                            return false
                                        end
                                    end
                                    return true
                                end,
                            }
                        end,
                        'Format',
                    },

                    h = { vim.lsp.buf.hover, 'Hover' },
                    k = { vim.lsp.buf.rename, 'Rename' },
                    l = { vim.lsp.buf.definition, 'Definitions' },
                    t = { vim.lsp.buf.type_definition, 'Type definitions' },
                    r = { vim.lsp.buf.references, 'References' },
                    i = { vim.lsp.buf.implementation, 'Implementations' },
                    c = { vim.lsp.buf.code_action, 'Code actions' },
                    s = {
                        name = 'symbols',
                        d = { vim.lsp.buf.document_symbol, 'Document' },
                        w = { vim.lsp.buf.workspace_symbol, 'Workspace' },
                    },
                }, {
                    prefix = '<leader>l',
                    buffer = buffer,
                })
            end

            for type, _ in pairs(U.SEVERITY_SIGNS) do
                local hl = 'DiagnosticSign' .. type:lower():gsub('^%l', string.upper)
                vim.fn.sign_define(hl, { text = '', texthl = hl, numhl = hl })
            end

            local function table_merge(t1, t2)
                for k, v in pairs(t2) do
                    if type(v) == 'table' then
                        if type(t1[k] or false) == 'table' then
                            table_merge(t1[k] or {}, t2[k] or {})
                        else
                            t1[k] = v
                        end
                    else
                        t1[k] = v
                    end
                end
                return t1
            end

            local more_cap = {
                offsetEncoding = { 'utf-16' },
                textDocument = {
                    completion = {
                        completionItem = {
                            snippetSupport = true,
                            preselectSupport = true,
                            insertReplaceSupport = true,
                            labelDetailsSupport = true,
                            deprecatedSupport = true,
                            commitCharactersSupport = true,
                            tagSupport = { valueSet = { 1 } },
                            resolveSupport = { properties = { 'documentation', 'detail', 'additionalTextEdits' } },
                        },
                    },
                },
            }

            table_merge(capabilities, more_cap)

            local servers = {
                phpactor = {},
                texlab = {},
                bashls = { filetypes = { 'sh', 'zsh', 'bash' } },
                jdtls = {},
                pylsp = {},
                sumneko_lua = {
                    cmd = { 'lua-language-server' },
                },
                tsserver = {},
                html = { filetypes = { 'html', 'htmldjango' } },
                cssls = {},
                hls = {},
            }

            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or 'rounded'
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end

            local base_config = {
                root_dir = vim.loop.cwd,
                capabilities = capabilities,
                on_attach = on_attach,
            }

            for server, config in pairs(servers) do
                table_merge(config, base_config)
                lspconfig[server].setup(config)
            end

            require('flutter-tools').setup {
                widget_guides = {
                    enabled = true,
                },
                lsp = base_config,
            }

            -- for IDF use with this .clangd file in project root:
            --[[
                CompileFlags:
                  Add: [-mlong-calls, -isysroot=/home/nimai/.espressif/tools/xtensa-esp32-elf/esp-2021r2-patch3-8.4.0/xtensa-esp32-elf/bin/xtensa-esp32-elf-gcc]
                  Remove: [-fno-tree-switch-conversion, -mtext-section-literals, -mlongcalls, -fstrict-volatile-bitfields]
            ]]
            --
            local clangd_config = {
                cmd = {
                    'clangd',
                    '--background-index',
                    '--suggest-missing-includes',
                    '--clang-tidy',
                    '--header-insertion=iwyu',
                },
            }
            table_merge(clangd_config, base_config)
            require('clangd_extensions').setup {
                server = clangd_config,
                extensions = {
                    inlay_hints = {
                        parameter_hints_prefix = '  ',
                        other_hints_prefix = '  ',
                    },
                    memory_usage = {
                        border = 'rounded',
                    },
                    symbol_info = {
                        border = 'rounded',
                    },
                },
            }

            require('rust-tools').setup({
                server = base_config,
                tools = {
                    inlay_hints = {
                        parameter_hints_prefix = '  ',
                        other_hints_prefix = '  ',
                    },
                },
            })

            local null_ls = require 'null-ls'
            null_ls.setup {
                on_attach = on_attach,
                sources = {
                    -- python
                    null_ls.builtins.formatting.black,

                    -- shell
                    null_ls.builtins.formatting.shfmt,

                    -- zsh
                    null_ls.builtins.diagnostics.zsh,

                    -- javascript and family
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.diagnostics.eslint,

                    -- Makefiles
                    null_ls.builtins.diagnostics.checkmake,

                    -- C and C++
                    null_ls.builtins.diagnostics.cppcheck,

                    -- English
                    null_ls.builtins.hover.dictionary,
                },
            }
        end,
    }

    -- remove
    use {
        'onsails/diaglist.nvim',
        config = function()
            local diaglist = require 'diaglist'
            diaglist.init {}
            require('legendary').setup()
            require('which-key').register({
                d = { vim.diagnostic.goto_prev, 'Previous diagnostic' },
            }, {
                prefix = '[',
            })
            require('which-key').register({
                d = { vim.diagnostic.goto_next, 'Next diagnostic' },
            }, {
                prefix = ']',
            })
            require('which-key').register({
                name = 'diagnostics',
                q = { diaglist.open_all_diagnostics, 'send all diagnostics to quickfix' },
                l = { diaglist.open_buffer_diagnostics, 'send buffer diagnostics to quickfix' },
            }, {
                prefix = '<leader>d',
            })
        end,
    }

    use {
        'kosayoda/nvim-lightbulb',
        config = function()
            require('nvim-lightbulb').setup {
                sign = { enabled = false },
                status_text = {
                    text = U.SEVERITY_SIGNS.HINT .. '  [Code Action]',
                    enabled = true,
                },
            }
            vim.fn.sign_define('LightBulbSign', { text = U.SEVERITY_SIGNS.HINT, texthl = 'LspDiagnosticsDefaultHint' })
            require('legendary').bind_autocmds {
                name = 'LightBulb',
                clear = true,
                {
                    { 'CursorHold', 'CursorHoldI' },
                    function()
                        require('nvim-lightbulb').update_lightbulb()
                    end,
                    description = 'Show light bulb when code action is available',
                },
            }
        end,
    }

    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'tzachar/fuzzy.nvim' }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',

            'https://github.com/hrsh7th/cmp-cmdline',
            'dmitmel/cmp-cmdline-history',

            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',

            'onsails/lspkind-nvim',
            'lukas-reineke/cmp-under-comparator',
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            require('luasnip.loaders.from_vscode').lazy_load()

            local has_words_before = function()
                ---@diagnostic disable-next-line: deprecated
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0 and
                    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            cmp.setup {
                sources = {
                    { name = 'nvim_lua' },
                    { name = 'nvim_lsp' },
                    { name = 'calc' },
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-c>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                },

                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        require('cmp-under-comparator').under,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },

                formatting = {
                    fields = { 'kind', 'abbr' },
                    format = function(_, vim_item)
                        local cmp_kinds = {
                            Text = '  ',
                            Method = '  ',
                            Function = '  ',
                            Constructor = '  ',
                            Field = '  ',
                            Variable = '  ',
                            Class = '  ',
                            Interface = '  ',
                            Module = '  ',
                            Property = '  ',
                            Unit = '  ',
                            Value = '  ',
                            Enum = '  ',
                            Keyword = '  ',
                            Snippet = '  ',
                            Color = '  ',
                            File = '  ',
                            Reference = '  ',
                            Folder = '  ',
                            EnumMember = '  ',
                            Constant = '  ',
                            Struct = '  ',
                            Event = '  ',
                            Operator = '  ',
                            TypeParameter = '  ',
                        }
                        vim_item.kind = cmp_kinds[vim_item.kind] or ''
                        return vim_item
                    end,
                },
            }

            local wk = require 'which-key'

            require('legendary').setup()
            wk.register({
                ['<C-n>'] = {
                    function()
                        cmp.complete { config = { sources = { { name = 'buffer' } } } }
                    end,
                    'Buffer completion',
                },
                ['<C-p>'] = {
                    function()
                        cmp.complete { config = { sources = { { name = 'buffer' } } } }
                    end,
                    'Buffer completion',
                },
                ['<C-x><C-f>'] = {
                    function()
                        cmp.complete { config = { sources = { { name = 'path' } } } }
                    end,
                    'Path completion',
                },
                ['<C-x><C-s>'] = {
                    function()
                        cmp.complete { config = { sources = { { name = 'luasnip' } } } }
                    end,
                    'Snippets',
                },

                ['<C-SPACE>'] = {
                    function()
                        cmp.complete {
                            config = {
                                sources = {
                                    { name = 'nvim_lua' },
                                    { name = 'nvim_lsp' },
                                    { name = 'calc' },
                                },
                            },
                        }
                    end,
                    'Symbol completion',
                },
            }, {
                prefix = '',
                mode = 'i',
            })

            vim.api.nvim_set_keymap('c', '<C-j>', '<down>', { noremap = true })
            vim.api.nvim_set_keymap('c', '<C-k>', '<up>', { noremap = true })

            for _, cmd_type in ipairs { ':', '/', '?', '@' } do
                cmp.setup.cmdline(cmd_type, {
                    sources = {
                        { name = 'cmdline_history' },
                    },
                })
            end

            require('cmp').setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                },
            })
            require('cmp').setup.cmdline('?', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                },
            })
            require('cmp').setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'cmdline' },
                },
            })
        end,
    }

    use {
        'windwp/nvim-autopairs',
        requires = 'hrsh7th/nvim-cmp',
        config = function()
            require('nvim-autopairs').setup {
                enable_check_bracket_line = false,
            }
            local cmp = require 'cmp'
            local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done { map_char = { tex = '' } })
        end,
    }

    use {
        'RRethy/nvim-base16',
        config = U.base16_config,
    }

    use {
        'nvim-lualine/lualine.nvim',
        config = U.lualine_config,
    }

    use {
        'https://github.com/noib3/nvim-cokeline',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            local get_hex = require('cokeline/utils').get_hex
            local cokeline_fg = function(buffer)
                if buffer.is_focused then
                    return BASE16_COLORS.base06
                else
                    return BASE16_COLORS.base04
                end
            end
            local cokeline_bg = function(buffer)
                if buffer.is_focused then
                    return BASE16_COLORS.base02
                else
                    return BASE16_COLORS.base01
                end
            end

            require('cokeline').setup {
                buffers = {
                    filter_valid = function(buffer)
                        return buffer.type ~= 'quickfix'
                    end,
                },
                default_hl = {
                    fg = cokeline_fg,
                    bg = cokeline_bg,
                },
                sidebar = {
                    filetype = 'NvimTree',
                    components = {
                        {
                            text = '  NvimTree',
                            fg = vim.g.terminal_color_3,
                            bg = get_hex('NvimTreeNormal', 'bg'),
                            style = 'bold',
                        },
                    },
                },

                components = {
                    {
                        text = function(buffer)
                            return ' ' .. buffer.devicon.icon .. ' '
                        end,
                        fg = function(buffer)
                            return buffer.devicon.color
                        end,
                    },
                    {
                        text = function(buffer)
                            return buffer.unique_prefix .. buffer.filename .. ' '
                        end,
                        style = function(buffer)
                            return buffer.is_focused and 'bold' or nil
                        end,
                    },

                    {
                        text = function(buffer)
                            local d = buffer.diagnostics
                            return (d.errors ~= 0 and U.SEVERITY_SIGNS.ERROR .. '  ' .. d.errors)
                                or (d.warnings ~= 0 and U.SEVERITY_SIGNS.WARN .. '  ' .. d.warnings)
                                or ''
                        end,
                        fg = function(buffer)
                            local d = buffer.diagnostics
                            return (d.errors ~= 0 and get_hex('DiagnosticError', 'fg'))
                                or (d.warnings ~= 0 and get_hex('DiagnosticWarn', 'fg'))
                                or nil
                        end,
                        truncation = { priority = 1 },
                    },
                    {
                        text = function(buffer)
                            return buffer.is_modified and '  ' or '  '
                        end,
                        fg = function(buffer)
                            return buffer.is_modified and vim.g.terminal_color_2 or vim.g.terminal_color_7
                        end,
                        delete_buffer_on_left_click = true,
                        truncation = { priority = 1 },
                    },
                },
            }
        end,
    }

    use {
        'famiu/bufdelete.nvim',
        config = function()
            local t = function(s)
                return vim.api.nvim_replace_termcodes(s, true, true, true)
            end

            local telescope = require 'telescope.builtin'
            local wk = require 'which-key'
            require('legendary').setup()
            wk.register({
                b = { telescope.buffers, 'Switch buffers' },
            }, {
                prefix = '<leader>b',
            })

            require('legendary').setup()
            wk.register({
                b = { '<Plug>(cokeline-focus-prev)', 'Previous buffer' },
            }, {
                prefix = '[',
            })
            wk.register({
                b = { '<Plug>(cokeline-focus-next)', 'Next buffer' },
            }, {
                prefix = ']',
            })

            require('legendary').bind_keymaps {
                {
                    '<C-n>',
                    '<Plug>(cokeline-focus-next)',
                    description = 'Next buffer',
                },
                {
                    '<C-p>',
                    '<Plug>(cokeline-focus-prev)',
                    description = 'Previous buffer',
                },
            }

            require('legendary').setup()
            wk.register({
                q = { ':Bdelete<CR>', 'Close buffer' },
            }, { prefix = '<leader>' })

            wk.register({
                name = 'buffers',
                d = { ':Bdelete<CR>', 'Close buffer' },
                l = { '<Plug>(cokeline-switch-next)', 'Switch with next buffer' },
                h = { '<Plug>(cokeline-switch-prev)', 'Switch with previous buffer' },
            }, { prefix = '<leader>b' })

            require('legendary').setup()
            wk.register({
                name = 'buffers',
                ['<C-n>'] = { t [[<C-\><C-n>:bnext<CR>]], 'Next buffer' },
                ['<C-p>'] = { t [[<C-\><C-n>:bprevious<CR>]], 'Previous buffer' },
            }, { mode = 't', prefix = '<C-b>' })
        end,
    }

    use {
        'windwp/nvim-ts-autotag',
        ft = {
            'html',
            'xml',
            'htmldjango',
            'javascript',
            'typescript',
            'javascriptreact',
            'typescriptreact',
            'svelte',
            'vue',
        },
        config = function()
            require('nvim-ts-autotag').setup()
        end,
    }

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = {
            'kyazdani42/nvim-web-devicons',
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        },
        config = function()
            local telescope = require 'telescope'
            local builtin = require 'telescope.builtin'
            local actions = require 'telescope.actions'
            telescope.setup {
                defaults = {
                    prompt_prefix = '  ',
                    selection_caret = '  ',
                    entry_prefix = '  ',
                    sorting_strategy = 'ascending',
                    layout_config = {
                        prompt_position = 'top',
                    },
                    mappings = {
                        i = {
                            ['<C-q>'] = actions.smart_send_to_qflist,
                            ['<C-l>'] = actions.smart_send_to_loclist,
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-k>'] = actions.move_selection_previous,
                        },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = 'smart_case',
                    },
                },
            }
            telescope.load_extension 'fzf'
            require('legendary').setup()
            require('which-key').register({
                name = 'find files',
                f = {
                    function()
                        builtin.find_files {
                            hidden = true,
                            follow = true,
                        }
                    end,
                    'Find files',
                },
                g = { builtin.git_files, 'Git files' },
                o = { builtin.oldfiles, 'Recent files' },
                r = { builtin.resume, 'Resume previous' },
            }, {
                prefix = '<leader>f',
            })
            require('which-key').register({
                ['<leader>'] = {
                    function()
                        builtin.find_files {
                            hidden = true,
                            follow = true,
                        }
                    end,
                    'Find files',
                },
                ['/'] = {
                    function()
                        builtin.live_grep {
                            additional_args = function()
                                return { '--follow' }
                            end,
                        }
                    end,
                    'Live grep',
                },
            }, {
                prefix = '<leader>',
            })

            require('legendary').setup()
            require('which-key').register({
                ['='] = { builtin.spell_suggest, 'Spelling suggestions' },
            }, {
                prefix = 'z',
            })

            require('legendary').setup()
            require('which-key').register({
                name = 'string match',
                t = {
                    function()
                        builtin.live_grep {
                            additional_args = function()
                                return { '--follow' }
                            end,
                        }
                    end,
                    'Live grep',
                },
                c = { builtin.grep_string, 'Grep for string under cursor' },
                s = { builtin.current_buffer_fuzzy_find, 'Buffer lines' },
            }, {
                prefix = '<leader>t',
            })
        end,
    }
end)
