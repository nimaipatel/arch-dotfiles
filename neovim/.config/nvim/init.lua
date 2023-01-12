vim.g.netrw_liststyle = 3
vim.g.python3_host_prog = '/usr/bin/python'
vim.g.mapleader = ' '
vim.g.loaded_matchparen = 1

vim.opt.updatetime = 50
vim.opt.cmdheight = 0
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.path:append '**'
vim.opt.wrap = false
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = 'unnamed,unnamedplus'
vim.opt.listchars = 'tab:→ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»'
vim.opt.completeopt = 'menuone,noselect'
vim.opt.isfname:append '{,}'
vim.opt.mouse = 'a'

vim.api.nvim_create_autocmd(
    { 'VimResized' },
    {
        command = 'wincmd =',
        desc = 'Resize panes when vim is resized',
    }
)

vim.api.nvim_create_autocmd(
    { 'TextYankPost' },
    {
        callback = function()
            require('vim.highlight').on_yank()
        end,
        desc = 'Highlight text on yanking',
    }
)

vim.cmd [[xnoremap <EXPR> v (mode() ==# 'v' ? "\<C-V>" : mode() ==# 'V' ? 'v' : 'V')]]

vim.cmd [[inoremap , ,<C-g>u]]
vim.cmd [[inoremap . .<C-g>u]]
vim.cmd [[inoremap ! !<C-g>u]]
vim.cmd [[inoremap ? ?<C-g>u]]

vim.cmd [[nnoremap <EXPR> k (v:count > 5 ? "m'" . v:count : "") . 'k']]
vim.cmd [[nnoremap <EXPR> j (v:count > 5 ? "m'" . v:count : "") . 'j']]

-- no op for <C-z>
vim.keymap.set('n', '<C-z>', '<nop>')

-- when jumping to bottom, center the page
vim.keymap.set('n', 'G', 'Gzz')

-- easier indentation control in visual mode
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

vim.keymap.set('n', 'n', 'nzz')
vim.keymap.set('n', 'N', 'Nzz')
vim.keymap.set('n', '*', '*zz')
vim.keymap.set('n', '#', '#zz')

-- move lines up and down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<leader>q', '<Plug>(qf_qf_toggle)', { desc = 'toggle quickfix list' })
vim.keymap.set('n', '<leader>l', '<Plug>(qf_loc_toggle)', { desc = 'toggle location list' })
vim.keymap.set('n', '<leader>m', ':make<CR>', { desc = 'make' })

vim.keymap.set('n', '<leader>tw', ':set list!<CR>', { desc = 'whitespace' })
vim.keymap.set('n', '<leader>tr', ':set wrap!<CR>', { desc = 'line wrapping' })
vim.keymap.set('n', '<leader>ts', ':set spell!<CR>', { desc = 'spell checking' })
vim.keymap.set('n', '<leader>tn', ':set relativenumber!<CR>', { desc = 'relative line numbers' })

local fn = vim.fn
local install_path = fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd 'packadd packer.nvim'
end

local packer = require 'packer'

packer.startup(function(use)
    use {
        'lewis6991/impatient.nvim',
        config = function()
            require 'impatient'
        end,
    }

    use {
        'stevearc/dressing.nvim',
        config = function()
            require('dressing').setup {
                input = { enabled = false, },
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
        'ellisonleao/gruvbox.nvim',
        config = function()
            vim.opt.background = 'dark'
            require("gruvbox").setup({
                contrast = 'hard',
                italic = false,
            })
            vim.cmd [[colorscheme gruvbox]]
        end
    }

    use 'svban/YankAssassin.vim'
    use 'wbthomason/packer.nvim'
    use 'tpope/vim-rsi'
    use 'tpope/vim-sleuth'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'
    use 'tpope/vim-eunuch'

    use {
        'tpope/vim-fugitive',
        config = function()
            vim.keymap.set('n', '<leader>gg', ':Git ', { desc = 'prompt' })
            vim.keymap.set('n', '<leader>gc', ':Git commit', { desc = 'commit' })
            vim.keymap.set('n', '<leader>gs', ':Git status<CR>', { desc = 'status' })
        end,
    }

    use {
        'Pocco81/auto-save.nvim',
        config = function()
            require('auto-save').setup({})
        end
    }

    use {
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = function()
            local gitsigns = require 'gitsigns'
            local actions = require 'gitsigns.actions'

            gitsigns.setup {}

            vim.keymap.set('v', '<leader>hs', function()
                gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
            end, { desc = 'stage hunk' })
            vim.keymap.set('v', '<leader>hr', function()
                gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
            end, { desc = 'reset hunk' })

            vim.keymap.set('n', ']h', actions.next_hunk, { desc = 'next hunk' })
            vim.keymap.set('n', '[h', actions.prev_hunk, { desc = 'previous hunk' })

            vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'stage hunk' })
            vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'stage buffer' })

            vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'reset hunk' })
            vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'reset buffer' })

            vim.keymap.set('n', '<leader>ho', gitsigns.preview_hunk, { desc = 'preview buffer' })

            vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = 'undo stage hunk' })

            vim.keymap.set('n', '<leader>hq', ':Gitsigns setqflist<CR>', { desc = 'quickfix list' })
            vim.keymap.set('n', '<leader>hl', ':Gitsigns setloclist<CR>', { desc = 'location list' })
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
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup {}
        end,
    }

    use { 'romainl/vim-qf',
        config = function()
            vim.keymap.set('n', '<A-j>', '<Plug>(qf_qf_next)',
                { desc = 'Goto next quick-fix list item' })

            vim.keymap.set('n', '<A-k>', '<Plug>(qf_qf_previous)',
                { desc = 'Goto previous quick-fix list item' })

            vim.keymap.set('n', '<C-j>', '<Plug>(qf_loc_next)',
                { desc = 'Goto next location list item' })

            vim.keymap.set('n', '<C-k>', '<Plug>(qf_loc_previous)',
                { desc = 'Goto previous location list item' })

        end }

    use {
        'https://gitlab.com/yorickpeterse/nvim-pqf',
        config = function()
            require('pqf').setup {}
        end,
    }

    use {
        'amrbashir/nvim-docs-view',
        opt = true,
        cmd = { 'DocsViewToggle' },
        setup = function()
            vim.keymap.set('n', '<leader>k', ':DocsViewToggle<CR>', { desc = 'docs' })
        end,
        config = function()
            require('docs-view').setup {
                position = 'bottom',
            }
        end,
    }

    use {
        'neovim/nvim-lspconfig',
        requires = {
            'jose-elias-alvarez/null-ls.nvim',
            'nvim-lua/plenary.nvim',
            'akinsho/flutter-tools.nvim',
            'p00f/clangd_extensions.nvim',
            'simrat39/rust-tools.nvim',
        },

        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local lspconfig = require 'lspconfig'

            vim.diagnostic.config {
                underline = true,
                virtual_text = false,
                signs = false;
            }

            local on_attach = function(_, buffer)
                vim.keymap.set('n', 'gq', function()
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
                end, { buffer = buffer, desc = 'format buffer' })

                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = buffer, desc = 'go to definition' })
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = buffer, desc = 'go to references' })
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = buffer, desc = 'go to implementation' })
                vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition,
                    { buffer = buffer, desc = 'go to type definition' })
                vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = buffer, desc = 'rename' })
                vim.keymap.set('n', '<leader>c', vim.lsp.buf.code_action, { buffer = buffer, desc = 'code actions' })

                vim.keymap.set('i', '<C-s>', vim.lsp.buf.signature_help, { buffer = buffer, desc = 'signature help' })

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
                grammarly = {}
            }

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

                    -- English
                    null_ls.builtins.hover.dictionary,
                },
            }
        end,
    }

    use {
        'onsails/diaglist.nvim',
        config = function()
            local diaglist = require 'diaglist'
            diaglist.init {}
            vim.keymap.set(
                'n',
                '<C-h>',
                function()
                    vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
                end,
                { desc = 'open cursor diagnostics in floating window' }
            )
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'next diagnostic' })
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'previous diagnostic' })
            vim.keymap.set('n', '<leader>d', diaglist.open_all_diagnostics,
                { desc = 'open all diagnostics in quickfix' })
        end,
    }

    use {
        'kosayoda/nvim-lightbulb',
        config = function()
            require('nvim-lightbulb').setup {
                sign = { enabled = true },
            }

            vim.api.nvim_create_autocmd(
                { 'CursorHold', 'CursorHoldI' },
                {
                    callback = function()
                        require('nvim-lightbulb').update_lightbulb()
                    end,
                    desc = 'Show light bulb when code action is available',
                }
            )
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

            'hrsh7th/cmp-cmdline',
            'dmitmel/cmp-cmdline-history',

            'saadparwaiz1/cmp_luasnip',
            'L3MON4D3/LuaSnip',
            'rafamadriz/friendly-snippets',

            'lukas-reineke/cmp-under-comparator',
        },
        config = function()
            local cmp = require 'cmp'
            local luasnip = require 'luasnip'
            require('luasnip.loaders.from_vscode').lazy_load()

            local has_words_before = function()
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
            }

            vim.keymap.set('i', '<C-n>', function()
                cmp.complete { config = { sources = { { name = 'buffer' } } } }
            end, { desc = 'buffer completion' })

            vim.keymap.set('i', '<C-p>', function()
                cmp.complete { config = { sources = { { name = 'buffer' } } } }
            end, { desc = 'buffer completion' })

            vim.keymap.set('i', '<C-x><C-f>', function()
                cmp.complete { config = { sources = { { name = 'path' } } } }
            end, { desc = 'path completion' })

            vim.keymap.set('i', '<C-x><C-s>', function()
                cmp.complete { config = { sources = { { name = 'luasnip' } } } }
            end, { desc = 'snippets' })

            vim.keymap.set('i', '<C-SPACE>', function()
                cmp.complete {
                    config = {
                        sources = {
                            { name = 'nvim_lua' },
                            { name = 'nvim_lsp' },
                            { name = 'calc' },
                        },
                    },
                }
            end, { desc = 'snippets' })

            vim.keymap.set('c', '<C-j>', '<down>')
            vim.keymap.set('c', '<C-k>', '<up>')

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
                map_cr = true,
                enable_check_bracket_line = false,
            }
            local cmp = require 'cmp'
            local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done { map_char = { tex = '' } })
        end,
    }

    use {
        'famiu/bufdelete.nvim',
        config = function()
            local telescope = require 'telescope.builtin'
            vim.keymap.set('n', '<leader>b', telescope.buffers, { desc = 'find buffer' })
            vim.keymap.set('n', '<C-n>', ':bnext<CR>', { desc = 'Next buffer' })
            vim.keymap.set('n', '<C-p>', ':bprevious<CR>', { desc = 'Previous buffer' })
            vim.keymap.set('n', '<leader>x', ':Bdelete<CR>', { desc = 'close buffer' })
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
            'stevearc/dressing.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
        },
        config = function()
            local telescope = require 'telescope'
            local builtin = require 'telescope.builtin'
            local actions = require 'telescope.actions'
            telescope.setup {
                defaults = {
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

            require('dressing').setup {
                input = { enabled = false }
            }

            vim.keymap.set('n', '<leader><leader>', function()
                builtin.find_files {
                    hidden = true,
                    follow = true,
                }
            end, { desc = 'find files' })

            vim.keymap.set('n', '<leader>o', builtin.oldfiles, { desc = 'recent files' })

            vim.keymap.set('n', '<leader>/', function()
                builtin.live_grep {
                    additional_args = function()
                        return { '--follow' }
                    end,
                }
            end, { desc = 'live grep' })

            vim.keymap.set('n', '<leader>?', builtin.keymaps, { desc = 'search keymaps' })

            vim.keymap.set('n', 'z=', builtin.spell_suggest, { desc = 'spelling suggestions' })
        end,
    }
end)
