-- space bar is leader key
vim.g.mapleader = ' '

-- quicker update
vim.opt.updatetime = 50

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
    ERROR = '',
    WARN = '',
    INFO = '',
    HINT = '',
    DEBUG = '',
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
            lualine_b = {
                'branch',
                'diff',
            },
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
                ['<C-k>'] = { ':GkeepToggle<cr>', 'toggle google keep' },
                ['<C-n>'] = { ':GkeepNew<cr>', 'new google keep' },
                ['<C-r>'] = { ':GkeepRefresh<cr>', 'refresh google keep' },
                ['<C-c>'] = { ':GkeepCheck<cr>', 'toggle checkbox' },
            }, {
                prefix = '<C-c><C-k>',
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
        'rcarriga/nvim-notify',
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
                    ':cnext<CR> zz :set cursorline<CR>',
                    description = 'Goto next quick-fix list item',
                    mode = { 'n' },
                },
                {
                    '<A-k>',
                    ':cprevious<CR> zz :set cursorline<CR>',
                    description = 'Goto previous quick-fix list item',
                    mode = { 'n' },
                },
                {
                    '<C-j>',
                    ':lnext<CR> zz :set cursorline<CR>',
                    description = 'Goto next location list item',
                    mode = { 'n' },
                },
                {
                    '<C-k>',
                    ':lprevious<CR>     zz :set cursorline<CR>',
                    description = 'Goto previous location list item',
                    mode = { 'n' },
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
                ['<C-q>'] = { ':cclose<CR>', 'close quickfix if open' },
                ['<C-l>'] = { ':lclose<CR>', 'close location if open' },
                ['<C-w>'] = { ':set list!<CR>', 'Toggle whitespace' },
                ['<C-r>'] = { ':set wrap!<CR>', 'Toggle line wrapping' },
                ['<C-s>'] = { ':set spell!<CR>', 'Toggle spell check' },
                ['<C-n>'] = { ':set relativenumber!<CR>', 'Toggle relative line numbers' },
                ['<C-c>'] = { t [[:call append(line('.'), '')<CR>j]], 'Insert black line' },
                ['<C-e>'] = { t ':cd ~/.config/nvim | e init.lua <cr>', 'Edit neovim config' },
                ['<C-p>'] = {
                    function()
                        vim.notify 'Re-compiling neovim config'
                        vim.cmd [[:source ~/.config/nvim/init.lua]]
                        vim.cmd [[:PackerCompile profile=true]]
                    end,
                    'Re-compile neovim config',
                },
            }, {
                prefix = '<C-c>',
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
                ['<C-x>'] = { ':SnipRun<CR>', 'execute code' },
                ['<C-k>'] = { ':SnipReset<CR>', 'kill execution' },
                ['<C-c>'] = { ':SnipClose<CR>', 'clear all output' },
            }, {
                prefix = '<C-c><C-x>',
            })
            require('which-key').register({
                name = 'code runner',
                ['<C-x>'] = { ':SnipRun<CR>', 'execute code' },
            }, {
                prefix = '<C-c><C-x>',
                mode = 'v',
            })
        end,
    }

    -- remove
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
                ['<C-g>'] = { ':Git ', 'prompt' },
                ['<C-c>'] = { ':Git commit ', 'Commit' },
                ['<C-s>'] = { ':Git status<CR>', 'Commit' },
            }, {
                prefix = '<C-c><C-g>',
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
                ['<C-s>'] = {
                    function()
                        gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
                    end,
                    'Stage hunk',
                },
                ['<C-r>'] = {
                    function()
                        gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
                    end,
                    'Reset hunk',
                },
            }, {
                mode = 'v',
                prefix = '<C-h>',
            })
            require('legendary').setup()
            wk.register({
                mode = 'hunks',
                ['<C-s>'] = { gitsigns.stage_hunk, 'Stage hunk' },
                ['<C-u>'] = { gitsigns.undo_stage_hunk, 'Undo stage hunk' },
                ['<C-r>'] = { gitsigns.reset_hunk, 'Reset hunk' },
                ['R'] = { gitsigns.reset_buffer, 'Reset buffer' },
                ['<C-o>'] = { gitsigns.preview_hunk, 'Preview hunk' },
                ['<C-b>'] = {
                    function()
                        gitsigns.blame_line(true)
                    end,
                    'Blame line',
                },
                ['S'] = { gitsigns.stage_buffer, 'Stage buffer' },
                ['U'] = { gitsigns.reset_buffer_index, 'Reset buffer index' },
                ['<C-n>'] = { actions.next_hunk, 'Next hunk' },
                ['<C-p>'] = { actions.prev_hunk, 'Previous hunk' },
                ['<C-q>'] = { ':Gitsigns setqflist<CR>', 'Quickfix list' },
                ['<C-l>'] = { ':Gitsigns setloclist<CR>', 'Location list' },
            }, {
                prefix = '<C-h>',
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
                ['<C-f>'] = { ':NvimTreeToggle<CR>', 'Toggle file explorer' },
            }, {
                prefix = '<C-f>',
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
                ['K'] = { ':DocsViewToggle<CR>', 'Docs' },
            }, {
                prefix = '<C-l>',
            })
        end,
        config = function()
            require('docs-view').setup {
                position = 'bottom',
            }
        end,
    }

    use {
        'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
        config = function()
            require('lsp_lines').setup()
            require('legendary').setup()
            require('which-key').register({
                ['<C-d>'] = {
                    function()
                        local current = vim.diagnostic.config().virtual_lines
                        vim.diagnostic.config { virtual_lines = not current }
                    end,
                    'toggle virtual diagnostics',
                },
            }, { prefix = '<C-l>' })
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
        },

        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local lspconfig = require 'lspconfig'

            vim.diagnostic.config {
                underline = false,
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
                    ['gd'] = { vim.lsp.buf.definition, 'Go to definition' },
                }, { buffer = buffer })

                require('legendary').setup()
                require('which-key').register({
                    ['<C-s>'] = { vim.lsp.buf.signature_help, 'Signature help' },
                }, { buffer = buffer, mode = 'i' })

                require('legendary').setup()
                require('which-key').register({
                    name = 'LSP',
                    ['<C-n>'] = { vim.diagnostic.goto_next, 'Next diagnostic' },
                    ['<C-p>'] = { vim.diagnostic.goto_prev, 'Previous diagnostic' },

                    ['<C-f>'] = {
                        function()
                            vim.lsp.buf.format {
                                async = true,
                                filter = function(formatter)
                                    local disabled_formatters = { 'tsserver', 'sumneko_lua' }
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

                    ['<C-h>'] = { vim.lsp.buf.hover, 'Hover' },

                    ['<C-k>'] = { vim.lsp.buf.rename, 'Rename' },

                    ['<C-l>'] = { vim.lsp.buf.definition, 'Definitions' },
                    ['<C-t>'] = { vim.lsp.buf.type_definition, 'Type definitions' },
                    ['<C-r>'] = { vim.lsp.buf.references, 'References' },
                    ['<C-i>'] = { vim.lsp.buf.implementation, 'Implementations' },

                    ['<C-c>'] = { vim.lsp.buf.code_action, 'Code actions' },

                    ['<C-s>'] = {
                        name = 'symbols',
                        ['<C-d>'] = { vim.lsp.buf.document_symbol, 'Document' },
                        ['<C-w>'] = { vim.lsp.buf.workspace_symbol, 'Workspace' },
                    },
                }, {
                    prefix = '<C-l>',
                    buffer = buffer,
                })
            end

            for type, icon in pairs(U.SEVERITY_SIGNS) do
                local hl = 'DiagnosticSign' .. type:lower():gsub('^%l', string.upper)
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
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
                rust_analyzer = {},
                sumneko_lua = {
                    settings = { Lua = { diagnostics = { enable = false } } },
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

            require('clangd_extensions').setup {
                server = base_config,
            }

            local null_ls = require 'null-ls'
            null_ls.setup {
                on_attach = on_attach,
                sources = {
                    -- python
                    null_ls.builtins.formatting.black,

                    -- shell
                    null_ls.builtins.diagnostics.shellcheck,
                    null_ls.builtins.formatting.shfmt,

                    -- zsh
                    null_ls.builtins.diagnostics.zsh,

                    -- javascript and family
                    null_ls.builtins.formatting.prettier,
                    null_ls.builtins.diagnostics.eslint,

                    -- lua
                    null_ls.builtins.diagnostics.luacheck,
                    null_ls.builtins.formatting.stylua,

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
                name = 'LSP',
                ['<C-d>'] = {
                    name = 'diagnostics',
                    ['<C-q>'] = { diaglist.open_all_diagnostics, 'send all diagnostics to quickfix' },
                    ['<C-l>'] = { diaglist.open_buffer_diagnostics, 'send buffer diagnostics to quickfix' },
                },
            }, {
                prefix = '<C-c>',
            })
        end,
    }

    use {
        'kosayoda/nvim-lightbulb',
        config = function()
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

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',

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

            cmp.setup {
                window = {
                    completion = {
                        autocomplete = false,
                        border = 'rounded',
                        winhighlight = 'Normal:Normal,FloatBorder:Normal',
                        scrollbar = '║',
                    },
                    documentation = {
                        winhighlight = 'Normal:Normal,FloatBorder:Normal',
                        border = 'rounded',
                    },
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = {
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-c>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<TAB>'] = function(fallback)
                        if luasnip.expand_or_jumpable() then
                            vim.fn.feedkeys(
                                vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true),
                                ''
                            )
                        else
                            fallback()
                        end
                    end,
                    ['<S-TAB>'] = function(fallback)
                        if luasnip.jumpable(-1) then
                            vim.fn.feedkeys(
                                vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true),
                                ''
                            )
                        else
                            fallback()
                        end
                    end,
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
                    format = require('lspkind').cmp_format {},
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
        end,
    }

    use {
        'windwp/nvim-autopairs',
        requires = 'hrsh7th/nvim-cmp',
        config = function()
            require('nvim-autopairs').setup {}
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
                            return (buffer.is_focused or buffer.is_first) and '' or ''
                        end,
                        fg = cokeline_bg,
                        bg = function(buffer)
                            return buffer.is_first and get_hex('Normal', 'bg') or BASE16_COLORS.base01
                        end,
                    },
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
                            return (
                                buffer.diagnostics.errors ~= 0
                                and U.SEVERITY_SIGNS.ERROR .. ' ' .. buffer.diagnostics.errors
                            )
                                or (buffer.diagnostics.warnings ~= 0 and U.SEVERITY_SIGNS.WARN .. ' ' .. buffer.diagnostics.warnings)
                                or ''
                        end,
                        fg = function(buffer)
                            return (buffer.diagnostics.errors ~= 0 and get_hex('DiagnosticError', 'fg'))
                                or (buffer.diagnostics.warnings ~= 0 and get_hex('DiagnosticWarn', 'fg'))
                                or nil
                        end,
                        truncation = { priority = 1 },
                    },
                    {
                        text = function(buffer)
                            return buffer.is_modified and '  ' or '  '
                        end,
                        fg = function(buffer)
                            return buffer.is_modified and vim.g.terminal_color_2 or vim.g.terminal_color_7
                        end,
                        delete_buffer_on_left_click = true,
                        truncation = { priority = 1 },
                    },
                    {
                        text = function(buffer)
                            return (buffer.is_focused or buffer.is_last) and '' or ''
                        end,
                        fg = cokeline_bg,
                        bg = function(buffer)
                            return buffer.is_last and get_hex('Normal', 'bg') or BASE16_COLORS.base01
                        end,
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
                ['<C-b>'] = { telescope.buffers, 'Switch buffers' },
            }, {
                prefix = '<C-b>',
            })

            require('legendary').setup()
            wk.register({
                name = 'buffers',
                ['<C-d>'] = { ':Bdelete<CR>', 'Close buffer' },
                ['<C-n>'] = { '<Plug>(cokeline-focus-next)', 'Next buffer' },
                ['<C-p>'] = { '<Plug>(cokeline-focus-prev)', 'Previous buffer' },
                ['<C-l>'] = { '<Plug>(cokeline-switch-next)', 'Switch with next buffer' },
                ['<C-h>'] = { '<Plug>(cokeline-switch-prev)', 'Switch with previous buffer' },
            }, { prefix = '<C-b>' })

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
        'gelguy/wilder.nvim',
        keys = { ':', '/', '?' },
        requires = { 'romgrk/fzy-lua-native', run = 'make' },
        config = function()
            local wilder = require 'wilder'
            wilder.setup { modes = { ':', '/', '?' } }

            vim.api.nvim_set_keymap('c', '<C-j>', '<down>', { noremap = true })
            vim.api.nvim_set_keymap('c', '<C-k>', '<up>', { noremap = true })

            wilder.set_option('use_python_remote_plugin', 0)

            wilder.set_option('pipeline', {
                wilder.branch(
                    wilder.cmdline_pipeline {
                        fuzzy = 1,
                        fuzzy_filter = wilder.lua_fzy_filter(),
                    },
                    wilder.vim_search_pipeline()
                ),
            })

            local popupmenu_renderer = wilder.popupmenu_renderer(wilder.popupmenu_border_theme {
                border = 'rounded',
                highlights = {
                    default = 'Normal',
                },
                highlighter = wilder.lua_fzy_filter(),
                left = {
                    ' ',
                    wilder.popupmenu_devicons(),
                },
                right = {
                    ' ',
                    wilder.popupmenu_scrollbar(),
                },
                min_width = '100%',
                min_height = '50%',
                reverse = 0,
            })

            wilder.set_option('renderer', popupmenu_renderer)

            vim.api.nvim_set_keymap('c', '<C-n>', '<TAB>', { silent = true })
            vim.api.nvim_set_keymap('c', '<C-p>', '<S-TAB>', { silent = true })
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
            local themes = require 'telescope.themes'
            local builtin = require 'telescope.builtin'
            local actions = require 'telescope.actions'
            telescope.setup {
                defaults = themes.get_ivy {
                    prompt_prefix = '   ',
                    selection_caret = '  ',
                    entry_prefix = '  ',
                    sorting_strategy = 'ascending',
                    layout_config = {
                        bottom_pane = {
                            height = 0.50,
                        },
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
                ['<C-p>'] = { builtin.find_files, 'Find files' },
                ['<C-g>'] = { builtin.git_files, 'Git files' },
                ['<C-o>'] = { builtin.oldfiles, 'Recent files' },
                ['<C-r>'] = { builtin.resume, 'Resume previous' },
            }, {
                prefix = '<C-p>',
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
                ['<C-t>'] = { builtin.live_grep, 'Live grep' },
                ['<C-s>'] = { builtin.current_buffer_fuzzy_find, 'Buffer lines' },
            }, {
                prefix = '<C-t>',
            })
        end,
    }
end)
