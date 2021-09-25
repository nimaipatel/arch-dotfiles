-- space bar is leader key
vim.g.mapleader = ' '

-- python path for python pluggins 🤮
vim.g.python_host_prog = '/usr/bin/python'

-- quicker update
vim.opt.updatetime = 50

-- new splits to the right and bottom
vim.opt.splitright = true
vim.opt.splitbelow = true

-- recure into directories to search for files with :find
vim.opt.path:append '**'

-- don't wrap lines
vim.opt.wrap = false

-- 8 character wide tab for indentation
vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.softtabstop = 8
vim.opt.autoindent = true

-- search options
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrapscan = false

-- line default relative number
vim.opt.number = true
vim.opt.relativenumber = true

-- netrw default style
vim.g.netrw_liststyle = 3

-- copy and paste with OS clipboard
vim.opt.clipboard = 'unnamedplus'

-- whitespace characters
vim.opt.listchars = 'tab:→ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»'

-- completion style
vim.opt.completeopt = 'menuone,noselect'

-- expand environment variables even if they are in braces
vim.opt.isfname:append '{,}'

local escape_cmd = function(string)
    return string:gsub("'", "\\'"):gsub('"', '\\"'):gsub('\\[', '\\['):gsub('\\]', '\\]'):gsub('<', '<lt>')
end

local bounded_funcs = 'global_bounded_funcs_namespace'
_G[bounded_funcs] = {}
for _, mode in ipairs { '', 'n', 'i', 'v', 't', 's' } do
    _G[mode .. 'noremap'] = function(input, output)
        if type(output) == 'function' then
            local func_name = mode .. '_' .. input
            local func_name_escaped = escape_cmd(func_name)
            _G[bounded_funcs][func_name] = output
            local lua_cmd = ':lua ' .. bounded_funcs .. "['" .. func_name_escaped .. "']()<cr>"
            vim.api.nvim_set_keymap(mode, input, lua_cmd, { noremap = true, silent = true })
        elseif type(output) == 'string' then
            vim.api.nvim_set_keymap(mode, input, output, { noremap = true, silent = true })
        else
            error(mode .. 'noremap' .. ' expects a string or callback', 2)
        end
    end
end

local global_listener = 'global_listener_namespace'
local autocmdhandlers = {}

_G[global_listener] = function(name)
    autocmdhandlers[name]()
end

_G['AddEventListener'] = function(name, events, cb)
    autocmdhandlers[name] = cb
    vim.cmd('augroup ' .. name)
    vim.cmd 'autocmd!'
    for _, v in ipairs(events) do
        local cmd = 'lua ' .. global_listener .. '("' .. name .. '")'
        vim.cmd('au ' .. v .. ' ' .. cmd)
    end
    vim.cmd 'augroup end'
end

_G['RemoveEventListener'] = function(name)
    vim.cmd('augroup ' .. name)
    vim.cmd 'autocmd!'
    vim.cmd 'augroup end'
    autocmdhandlers[name] = nil
end

AddEventListener('ScrolloffFraction', { 'BufEnter,WinEnter,WinNew,VimResized *,*.*' }, function()
    if vim.opt.filetype ~= 'qf' then
        local vis_lines = vim.api.nvim_win_get_height(vim.fn.win_getid())
        vim.opt.scrolloff = math.floor(vis_lines * 0.25)
    end
end)

AddEventListener('LuaHighlight', { 'TextYankPost *' }, function()
    require('vim.highlight').on_yank()
end)

AddEventListener('DisableHighLight', { 'InsertEnter,CursorMoved *' }, function()
    vim.opt.hlsearch = false
end)

-- toggle whitespace rendering
nnoremap('<leader>w', ':set list!<cr>')

-- unmap control + z for now
nnoremap('<c-z>', '')

-- toggle relative and absolute line numbering
nnoremap('<leader>n', ':set relativenumber!<cr>')

-- remove search highlighting with leader + enter
nnoremap('<leader><cr>', ':nohl<cr>')

-- when jumping to bottom, center the page
nnoremap('G', 'Gzz')

-- turn terminal to normal mode with escape
nnoremap('<esc>', '<c-\\><c-n>')

-- turn on search highlighting when jumping using n
nnoremap('*', '*:set hlsearch<cr>')

-- turn on search highlighting when jumping using n
nnoremap('n', 'n:set hlsearch<cr>')

-- turn on search highlighting when jumping using N
nnoremap('N', 'N:set hlsearch<cr>')

local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd 'packadd packer.nvim'
end

local packer = require 'packer'

packer.startup(function(use)
    use 'wbthomason/packer.nvim'

    use 'Darazaki/indent-o-matic'

    use 'tpope/vim-commentary'

    use 'tpope/vim-surround'

    use 'tpope/vim-repeat'

    use {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('gitsigns').setup()
        end,
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = 'maintained',
                highlight = { enable = true },
            }
        end,
    }

    use {
        'neovim/nvim-lspconfig',
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local lspconfig = require 'lspconfig'
            local builtins = require 'telescope.builtin'

            nnoremap(']d', vim.lsp.diagnostic.goto_next)
            nnoremap('[d', vim.lsp.diagnostic.goto_prev)
            nnoremap('gD', vim.lsp.buf.declaration)
            nnoremap('gs', vim.lsp.buf.signature_help)
            nnoremap('<leader>rn', vim.lsp.buf.rename)
            nnoremap('<leader>f', vim.lsp.buf.formatting)
            nnoremap('H', vim.lsp.diagnostic.show_line_diagnostics)
            nnoremap('L', vim.lsp.buf.hover)

            nnoremap('gd', builtins.lsp_definitions)
            nnoremap('gr', builtins.lsp_references)
            nnoremap('<leader>af', builtins.lsp_code_actions)
            nnoremap('gi', builtins.lsp_implementations)
            nnoremap('gt', builtins.lsp_type_definitions)

            capabilities.textDocument.completion.completionItem.snippetSupport = true
            capabilities.textDocument.completion.completionItem.preselectSupport = true
            capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
            capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
            capabilities.textDocument.completion.completionItem.deprecatedSupport = true
            capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
            capabilities.textDocument.completion.completionItem.tagSupport = {
                valueSet = { 1 },
            }
            capabilities.textDocument.completion.completionItem.resolveSupport = {
                properties = { 'documentation', 'detail', 'additionalTextEdits' },
            }
            lspconfig.phpactor.setup { root_dir = vim.loop.cwd }

            lspconfig.texlab.setup { root_dir = vim.loop.cwd }

            lspconfig.bashls.setup {
                root_dir = vim.loop.cwd,
                filetypes = { 'sh', 'zsh', 'bash' },
            }

            lspconfig.jdtls.setup { root_dir = vim.loop.cwd }

            lspconfig.pylsp.setup { root_dir = vim.loop.cwd }

            lspconfig.rust_analyzer.setup { root_dir = vim.loop.cwd }

            lspconfig.clangd.setup { root_dir = vim.loop.cwd }

            lspconfig.sumneko_lua.setup {
                settings = { Lua = { diagnostics = { enable = false } } },
                cmd = { 'lua-language-server' },
                root_dir = vim.loop.cwd,
                capabilities = capabilities,
            }

            lspconfig.tsserver.setup { root_dir = vim.loop.cwd, capabilities = capabilities }

            lspconfig.html.setup {
                root_dir = vim.loop.cwd,
                capabilities = capabilities,
                filetypes = { 'html', 'htmldjango' },
            }

            lspconfig.cssls.setup { root_dir = vim.loop.cwd, capabilities = capabilities }

            lspconfig.hls.setup { root_dir = vim.loop.cwd, capabilities = capabilities }

            local shellcheck = {
                lintCommand = 'shellcheck -f gcc -x -',
                lintStdin = true,
                lintFormats = {
                    '%f:%l:%c: %trror: %m',
                    '%f:%l:%c: %tarning: %m',
                    '%f:%l:%c: %tote: %m',
                },
            }

            local black = { formatCommand = 'black -', formatStdin = true }

            local isort = {
                formatCommand = 'isort --stdout --profile black -',
                formatStdin = true,
            }

            local flake8 = {
                lintCommand = 'flake8 --max-line-length 160 --stdin-display-name ${INPUT} -',
                lintStdin = true,
                lintIgnoreExitCode = true,
                lintFormats = { '%f=%l:%c: %m' },
            }

            local mypy = {
                lintCommand = 'mypy --show-column-numbers --ignore-missing-imports',
                lintFormats = {
                    '%f=%l:%c: %trror: %m',
                    '%f=%l:%c: %tarning: %m',
                    '%f=%l:%c: %tote: %m',
                },
            }

            local prettier = { formatCommand = './node_modules/.bin/prettier' }

            local eslint = {
                lintCommand = './node_modules/.bin/eslint -f unix --stdin',
                lintIgnoreExitCode = true,
                lintStdin = true,
            }

            local luaformat = { formatCommand = 'stylua -', formatStdin = true }

            local luacheck = { lintCommand = 'luacheck - --formatter plain', lintStdin = true}

            lspconfig.efm.setup {
                init_options = { documentFormatting = true },
                settings = {
                    rootMarkers = { vim.loop.cwd() },
                    languages = {
                        lua = { luaformat, luacheck },
                        python = { flake8, black, isort, mypy },
                        typescript = { prettier, eslint },
                        javascript = { prettier, eslint },
                        typescriptreact = { prettier, eslint },
                        javascriptreact = { prettier, eslint },
                        yaml = { prettier },
                        json = { prettier },
                        html = { prettier },
                        scss = { prettier },
                        css = { prettier },
                        markdown = { prettier },
                        sh = { shellcheck },
                    },
                },
            }
        end,
    }

    use {
        'akinsho/flutter-tools.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            require('flutter-tools').setup()
        end,
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',

            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',

            'onsails/lspkind-nvim',
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            cmp.setup {
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
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.close(),
                    ['<CR>'] = cmp.mapping.confirm {
                        behavior = cmp.ConfirmBehavior.Replace,
                        select = true,
                    },
                    ['<Tab>'] = function(fallback)
                        if luasnip.expand_or_jumpable() then
                            vim.fn.feedkeys(
                                vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true),
                                ''
                            )
                        else
                            fallback()
                        end
                    end,
                    ['<S-Tab>'] = function(fallback)
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

                sources = {
                    { name = 'nvim_lua' },
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'calc' },
                },

                formatting = {
                    format = function(entry, vim_item)
                        -- fancy icons and a name of kind
                        vim_item.kind = require('lspkind').presets.default[vim_item.kind] .. ' ' .. vim_item.kind

                        -- set a name for each source
                        vim_item.menu = ({
                            buffer = '[Buffer]',
                            nvim_lsp = '[LSP]',
                            luasnip = '[LuaSnip]',
                            nvim_lua = '[Lua]',
                            latex_symbols = '[Latex]',
                        })[entry.source.name]
                        return vim_item
                    end,
                },
            }
        end,
    }

    use {
        'RRethy/nvim-base16',
        requires = 'shadmansaleh/lualine.nvim',
        config = function()
            _G['RefreshColors'] = function()
                vim.cmd 'source ~/.config/nvim/base16.lua'
                require('base16-colorscheme').setup(base16_theme_colors)
                require('lualine').setup { options = { theme = base16_lualine_colors } }
                vim.api.nvim_exec(
                    [[
		            hi GitSignsAdd guifg=green
		            hi GitSignsDelete guifg=red
		            hi GitSignsChange guifg=yellow
	            ]],
                    true
                )
            end
            RefreshColors()
        end,
    }

    use {
        'windwp/nvim-autopairs',
        requires = 'hrsh7th/nvim-cmp',
        config = function()
            require('nvim-autopairs').setup {}
            require('nvim-autopairs.completion.cmp').setup {
                map_cr = true,
                map_complete = true,
                auto_select = true,
                insert = false,
                map_char = {
                    all = '(',
                    tex = '{',
                },
            }
        end,
    }

    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    use {
        'nvim-telescope/telescope.nvim',
        requires = 'kyazdani42/nvim-web-devicons',
        config = function()
            require('telescope').setup {
                defaults = require('telescope.themes').get_ivy(),
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = 'smart_case',
                    },
                },
            }
            require('telescope').load_extension 'fzf'
            local builtin = require 'telescope.builtin'
            nnoremap('<c-p>', builtin.find_files)
            nnoremap('<c-t>', builtin.live_grep)
        end,
    }
end)
