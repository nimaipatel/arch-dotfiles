vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()
    use {'wbthomason/packer.nvim', opt = true}
    -- theme and looks
    use {'norcalli/nvim-colorizer.lua',config  = function () require('colorizer').setup() end}
    use {"npxbr/gruvbox.nvim", requires = {"tjdevries/colorbuddy.vim"}}
    -- visual debugger
    use {'puremourning/vimspector'}
    -- fuzzy finder
    use {'nvim-telescope/telescope.nvim',requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}}
    -- git
    use {'lewis6991/gitsigns.nvim',requires = {'nvim-lua/plenary.nvim'},config = function() require('gitsigns').setup() end}
    -- key maps
    use {'tpope/vim-surround'}
    use {'tpope/vim-commentary'}
    use {'tpope/vim-repeat'}
    use {'jiangmiao/auto-pairs'}
    use {'alvan/vim-closetag'}
    use {'christoomey/vim-tmux-navigator'}
    -- treesitter
    use {'nvim-treesitter/nvim-treesitter'}
    use {'nvim-treesitter/nvim-treesitter-textobjects'}
    -- lsp, autocomplete, snippets
    use {'neovim/nvim-lspconfig'}
    use {'nvim-lua/completion-nvim'}
    use {'hrsh7th/vim-vsnip'}
    use {'hrsh7th/vim-vsnip-integ'}
end)
