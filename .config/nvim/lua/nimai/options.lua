-- space bar is leader key
vim.g.mapleader=" "

-- python path for python pluggins 🤮
vim.g.python_host_prog='/usr/bin/python'

-- quicker update
vim.o.updatetime = 50
vim.w.updatetime = 50

-- new splits to the right and bottom
vim.o.splitright=true
vim.o.splitbelow=true

-- don't wrap lines
vim.wo.wrap=false

-- 8 character wide tab for indentation
vim.o.tabstop = 8 vim.bo.tabstop = 8
vim.o.shiftwidth = 8 vim.bo.shiftwidth = 8
vim.o.softtabstop = 8 vim.bo.softtabstop = 8
vim.o.autoindent = true vim.bo.autoindent = true

-- search options
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- line default relative number
vim.wo.number=true
vim.wo.relativenumber=true

-- show cursorline
vim.wo.cursorline = true

-- netrw default style
vim.g.netrw_liststyle = 3

-- copy and paste with OS clipboard
vim.o.clipboard = 'unnamedplus'

-- always show tabline
vim.o.showtabline=2

-- whitespace characters
vim.o.listchars = 'tab:→ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»'

-- completion style
vim.o.completeopt = 'menuone,noinsert,noselect'

-- color highlights for cringe style sheets
vim.o.termguicolors = true
require('colorizer').setup()

-- cute signs next to changes in files managed by git
require('gitsigns').setup()

require('nvim-treesitter.configs').setup {
	ensure_installed = "maintained",
	highlight = { enable = true },
}
