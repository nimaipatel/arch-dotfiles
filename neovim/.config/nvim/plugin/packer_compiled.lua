-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/nimai/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/nimai/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/nimai/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/nimai/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/nimai/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["YankAssassin.vim"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/YankAssassin.vim",
    url = "https://github.com/svban/YankAssassin.vim"
  },
  ["auto-save.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14auto-save\frequire\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/auto-save.nvim",
    url = "https://github.com/Pocco81/auto-save.nvim"
  },
  ["bufdelete.nvim"] = {
    config = { "\27LJ\2\næ\2\0\0\a\0\18\0$6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1'\3\5\0'\4\6\0009\5\a\0005\6\b\0B\1\5\0016\1\2\0009\1\3\0019\1\4\1'\3\5\0'\4\t\0'\5\n\0005\6\v\0B\1\5\0016\1\2\0009\1\3\0019\1\4\1'\3\5\0'\4\f\0'\5\r\0005\6\14\0B\1\5\0016\1\2\0009\1\3\0019\1\4\1'\3\5\0'\4\15\0'\5\16\0005\6\17\0B\1\5\1K\0\1\0\1\0\1\tdesc\17close buffer\17:Bdelete<CR>\14<leader>x\1\0\1\tdesc\20Previous buffer\19:bprevious<CR>\n<C-p>\1\0\1\tdesc\16Next buffer\15:bnext<CR>\n<C-n>\1\0\1\tdesc\16find buffer\fbuffers\14<leader>b\6n\bset\vkeymap\bvim\22telescope.builtin\frequire\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/bufdelete.nvim",
    url = "https://github.com/famiu/bufdelete.nvim"
  },
  ["clangd_extensions.nvim"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/clangd_extensions.nvim",
    url = "https://github.com/p00f/clangd_extensions.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-cmdline-history"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/cmp-cmdline-history",
    url = "https://github.com/dmitmel/cmp-cmdline-history"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-under-comparator"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/cmp-under-comparator",
    url = "https://github.com/lukas-reineke/cmp-under-comparator"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["diaglist.nvim"] = {
    config = { "\27LJ\2\nT\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0+\2\0\0005\3\3\0B\0\3\1K\0\1\0\1\0\2\nscope\vcursor\nfocus\1\15open_float\15diagnostic\bvimµ\3\1\0\a\0\20\0+6\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\a\0003\5\b\0005\6\t\0B\1\5\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\n\0006\5\3\0009\5\v\0059\5\f\0055\6\r\0B\1\5\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\14\0006\5\3\0009\5\v\0059\5\15\0055\6\16\0B\1\5\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\17\0009\5\18\0005\6\19\0B\1\5\1K\0\1\0\1\0\1\tdesc%open all diagnostics in quickfix\25open_all_diagnostics\14<leader>d\1\0\1\tdesc\24previous diagnostic\14goto_prev\a[d\1\0\1\tdesc\20next diagnostic\14goto_next\15diagnostic\a]d\1\0\1\tdesc/open cursor diagnostics in floating window\0\n<C-h>\6n\bset\vkeymap\bvim\tinit\rdiaglist\frequire\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/diaglist.nvim",
    url = "https://github.com/onsails/diaglist.nvim"
  },
  ["dressing.nvim"] = {
    config = { "\27LJ\2\n¼\1\0\0\a\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\v\0005\4\t\0005\5\a\0005\6\6\0=\6\b\5=\5\n\4=\4\f\3=\3\r\2B\0\2\1K\0\1\0\vselect\14telescope\1\0\0\18layout_config\1\0\0\16bottom_pane\1\0\0\1\0\1\vheight\4\0€€€ÿ\3\ninput\1\0\0\1\0\1\fenabled\1\nsetup\rdressing\frequire\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["flutter-tools.nvim"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/flutter-tools.nvim",
    url = "https://github.com/akinsho/flutter-tools.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["fuzzy.nvim"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/fuzzy.nvim",
    url = "https://github.com/tzachar/fuzzy.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\nn\0\0\6\1\6\1\17-\0\0\0009\0\0\0004\2\3\0006\3\1\0009\3\2\0039\3\3\3'\5\4\0B\3\2\2>\3\1\0026\3\1\0009\3\2\0039\3\3\3'\5\5\0B\3\2\0?\3\0\0B\0\2\1K\0\1\0\0À\6v\6.\tline\afn\bvim\15stage_hunk\5€€À™\4n\0\0\6\1\6\1\17-\0\0\0009\0\0\0004\2\3\0006\3\1\0009\3\2\0039\3\3\3'\5\4\0B\3\2\2>\3\1\0026\3\1\0009\3\2\0039\3\3\3'\5\5\0B\3\2\0?\3\0\0B\0\2\1K\0\1\0\0À\6v\6.\tline\afn\bvim\15reset_hunk\5€€À™\4ÿ\b\1\0\t\0007\0~6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\3\4\0004\5\0\0B\3\2\0019\3\5\0025\5\t\0005\6\a\0005\a\6\0=\a\b\6=\6\n\0055\6\v\0B\3\3\0019\3\5\0025\5\14\0005\6\r\0005\a\f\0=\a\b\6=\6\n\0055\6\15\0B\3\3\0016\3\16\0009\3\17\0039\3\18\3'\5\19\0'\6\20\0003\a\21\0005\b\22\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\19\0'\6\23\0003\a\24\0005\b\25\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\6\27\0009\a\28\0015\b\29\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\6\30\0009\a\31\0015\b \0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\6\20\0009\a!\0005\b\"\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\6#\0009\a$\0005\b%\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\6\23\0009\a&\0005\b'\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\6(\0009\a)\0005\b*\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\6+\0009\a,\0005\b-\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\6.\0009\a/\0005\b0\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\0061\0'\a2\0005\b3\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\0064\0'\a5\0005\b6\0B\3\5\0012\0\0€K\0\1\0\1\0\1\tdesc\18location list\29:Gitsigns setloclist<CR>\15<leader>hl\1\0\1\tdesc\18quickfix list\28:Gitsigns setqflist<CR>\15<leader>hq\1\0\1\tdesc\20undo stage hunk\20undo_stage_hunk\15<leader>hu\1\0\1\tdesc\19preview buffer\17preview_hunk\15<leader>ho\1\0\1\tdesc\17reset buffer\17reset_buffer\15<leader>hR\1\0\1\tdesc\15reset hunk\15reset_hunk\1\0\1\tdesc\17stage buffer\17stage_buffer\15<leader>hS\1\0\1\tdesc\15stage hunk\15stage_hunk\1\0\1\tdesc\18previous hunk\14prev_hunk\a[h\1\0\1\tdesc\14next hunk\14next_hunk\a]h\6n\1\0\1\tdesc\15reset hunk\0\15<leader>hr\1\0\1\tdesc\15stage hunk\0\15<leader>hs\6v\bset\vkeymap\bvim\1\0\1\tmode\6n\1\0\0\1\0\0\1\0\1\tname\nhunks\1\0\1\tmode\6v\r<leader>\1\0\0\6h\1\0\0\1\0\1\tname\nhunks\rregister\nsetup\14which-key\21gitsigns.actions\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["impatient.nvim"] = {
    config = { "\27LJ\2\n)\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\14impatient\frequire\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["kmonad-vim"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/kmonad-vim",
    url = "https://github.com/kmonad/kmonad-vim"
  },
  ["license-to-vim"] = {
    config = { "\27LJ\2\ns\0\0\2\0\6\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0K\0\1\0\28nimai.m.patel@gmail.com\18license_email\17Patel, Nimai\19license_author\6g\bvim\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/license-to-vim",
    url = "https://github.com/ararslan/license-to-vim"
  },
  ["mason.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\nmason\frequire\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n‚\2\0\0\n\0\r\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0026\1\0\0'\3\5\0B\1\2\0029\2\6\0\18\4\2\0009\2\a\2'\5\b\0009\6\t\0015\b\v\0005\t\n\0=\t\f\bB\6\2\0A\2\2\1K\0\1\0\rmap_char\1\0\0\1\0\1\btex\5\20on_confirm_done\17confirm_done\aon\nevent\"nvim-autopairs.completion.cmp\bcmp\1\0\2\vmap_cr\2\30enable_check_bracket_line\1\nsetup\19nvim-autopairs\frequire\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nÐ\1\0\0\b\0\b\2!6\0\0\0006\2\1\0009\2\2\0029\2\3\2)\4\0\0B\2\2\0A\0\0\3\b\1\0\0X\2\20€6\2\1\0009\2\2\0029\2\4\2)\4\0\0\23\5\1\0\18\6\0\0+\a\2\0B\2\5\2:\2\1\2\18\4\2\0009\2\5\2\18\5\1\0\18\6\1\0B\2\4\2\18\4\2\0009\2\6\2'\5\a\0B\2\3\2\n\2\0\0X\2\2€+\2\1\0X\3\1€+\2\2\0L\2\2\0\a%s\nmatch\bsub\23nvim_buf_get_lines\24nvim_win_get_cursor\bapi\bvim\vunpack\0\2-\0\1\4\1\2\0\5-\1\0\0009\1\0\0019\3\1\0B\1\2\1K\0\1\0\1À\tbody\15lsp_expandÅ\1\0\1\3\3\5\0\29-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4€-\1\0\0009\1\1\1B\1\1\1X\1\19€-\1\1\0009\1\2\1B\1\1\2\15\0\1\0X\2\4€-\1\1\0009\1\3\1B\1\1\1X\1\n€-\1\2\0B\1\1\2\15\0\1\0X\2\4€-\1\0\0009\1\4\1B\1\1\1X\1\2€\18\1\0\0B\1\1\1K\0\1\0\0À\1À\2À\rcomplete\19expand_or_jump\23expand_or_jumpable\21select_next_item\fvisibleŽ\1\0\1\4\2\4\0\23-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4€-\1\0\0009\1\1\1B\1\1\1X\1\r€-\1\1\0009\1\2\1)\3ÿÿB\1\2\2\15\0\1\0X\2\5€-\1\1\0009\1\3\1)\3ÿÿB\1\2\1X\1\2€\18\1\0\0B\1\1\1K\0\1\0\0À\1À\tjump\rjumpable\21select_prev_item\fvisibleb\0\0\6\1\6\0\v-\0\0\0009\0\0\0005\2\4\0005\3\2\0004\4\3\0005\5\1\0>\5\1\4=\4\3\3=\3\5\2B\0\2\1K\0\1\0\0À\vconfig\1\0\0\fsources\1\0\0\1\0\1\tname\vbuffer\rcompleteb\0\0\6\1\6\0\v-\0\0\0009\0\0\0005\2\4\0005\3\2\0004\4\3\0005\5\1\0>\5\1\4=\4\3\3=\3\5\2B\0\2\1K\0\1\0\0À\vconfig\1\0\0\fsources\1\0\0\1\0\1\tname\vbuffer\rcomplete`\0\0\6\1\6\0\v-\0\0\0009\0\0\0005\2\4\0005\3\2\0004\4\3\0005\5\1\0>\5\1\4=\4\3\3=\3\5\2B\0\2\1K\0\1\0\0À\vconfig\1\0\0\fsources\1\0\0\1\0\1\tname\tpath\rcompletec\0\0\6\1\6\0\v-\0\0\0009\0\0\0005\2\4\0005\3\2\0004\4\3\0005\5\1\0>\5\1\4=\4\3\3=\3\5\2B\0\2\1K\0\1\0\0À\vconfig\1\0\0\fsources\1\0\0\1\0\1\tname\fluasnip\rcomplete’\1\0\0\6\1\b\0\15-\0\0\0009\0\0\0005\2\6\0005\3\4\0004\4\4\0005\5\1\0>\5\1\0045\5\2\0>\5\2\0045\5\3\0>\5\3\4=\4\5\3=\3\a\2B\0\2\1K\0\1\0\0À\vconfig\1\0\0\fsources\1\0\0\1\0\1\tname\tcalc\1\0\1\tname\rnvim_lsp\1\0\1\tname\rnvim_lua\rcomplete„\r\1\0\14\0Z\0ä\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\2\4\2B\2\1\0013\2\5\0009\3\6\0005\5\n\0004\6\4\0005\a\a\0>\a\1\0065\a\b\0>\a\2\0065\a\t\0>\a\3\6=\6\v\0055\6\r\0003\a\f\0=\a\14\6=\6\15\0055\6\18\0009\a\16\0009\a\17\aB\a\1\2=\a\19\0069\a\16\0009\a\20\aB\a\1\2=\a\21\0069\a\16\0009\a\22\a)\tüÿB\a\2\2=\a\23\0069\a\16\0009\a\22\a)\t\4\0B\a\2\2=\a\24\0069\a\16\0009\a\25\aB\a\1\2=\a\26\0069\a\16\0009\a\27\a5\t\30\0009\n\28\0009\n\29\n=\n\31\tB\a\2\2=\a \0069\a\16\0003\t!\0005\n\"\0B\a\3\2=\a#\0069\a\16\0003\t$\0005\n%\0B\a\3\2=\a&\6=\6\16\0055\0062\0004\a\t\0009\b'\0009\b(\b9\b)\b>\b\1\a9\b'\0009\b(\b9\b*\b>\b\2\a9\b'\0009\b(\b9\b+\b>\b\3\a6\b\0\0'\n,\0B\b\2\0029\b-\b>\b\4\a9\b'\0009\b(\b9\b.\b>\b\5\a9\b'\0009\b(\b9\b/\b>\b\6\a9\b'\0009\b(\b9\b0\b>\b\a\a9\b'\0009\b(\b9\b1\b>\b\b\a=\a3\6=\0064\5B\3\2\0016\0035\0009\0036\0039\0037\3'\0058\0'\6\21\0003\a9\0005\b:\0B\3\5\0016\0035\0009\0036\0039\0037\3'\0058\0'\6\19\0003\a;\0005\b<\0B\3\5\0016\0035\0009\0036\0039\0037\3'\0058\0'\6=\0003\a>\0005\b?\0B\3\5\0016\0035\0009\0036\0039\0037\3'\0058\0'\6@\0003\aA\0005\bB\0B\3\5\0016\0035\0009\0036\0039\0037\3'\0058\0'\6C\0003\aD\0005\bE\0B\3\5\0016\0035\0009\0036\0039\0037\3'\5F\0'\6G\0'\aH\0B\3\4\0016\0035\0009\0036\0039\0037\3'\5F\0'\6I\0'\aJ\0B\3\4\0016\3K\0005\5L\0B\3\2\4X\6\t€9\b\6\0009\bM\b\18\n\a\0005\vO\0004\f\3\0005\rN\0>\r\1\f=\f\v\vB\b\3\1E\6\3\3R\6õ\1276\3\0\0'\5\1\0B\3\2\0029\3\6\0039\3M\3'\5P\0005\6R\0009\a\16\0009\aQ\a9\aM\aB\a\1\2=\a\16\0064\a\3\0005\bS\0>\b\1\a=\a\v\6B\3\3\0016\3\0\0'\5\1\0B\3\2\0029\3\6\0039\3M\3'\5T\0005\6U\0009\a\16\0009\aQ\a9\aM\aB\a\1\2=\a\16\0064\a\3\0005\bV\0>\b\1\a=\a\v\6B\3\3\0016\3\0\0'\5\1\0B\3\2\0029\3\6\0039\3M\3'\5W\0005\6X\0009\a\16\0009\aQ\a9\aM\aB\a\1\2=\a\16\0064\a\3\0005\bY\0>\b\1\a=\a\v\6B\3\3\0012\0\0€K\0\1\0\1\0\1\tname\fcmdline\1\0\0\6:\1\0\1\tname\vbuffer\1\0\0\6?\1\0\1\tname\vbuffer\1\0\0\vpreset\6/\1\0\0\1\0\1\tname\20cmdline_history\fcmdline\1\5\0\0\6:\6/\6?\6@\vipairs\t<up>\n<C-k>\v<down>\n<C-j>\6c\1\0\1\tdesc\rsnippets\0\14<C-SPACE>\1\0\1\tdesc\rsnippets\0\15<C-x><C-s>\1\0\1\tdesc\20path completion\0\15<C-x><C-f>\1\0\1\tdesc\22buffer completion\0\1\0\1\tdesc\22buffer completion\0\6i\bset\vkeymap\bvim\fsorting\16comparators\1\0\0\norder\vlength\14sort_text\tkind\nunder\25cmp-under-comparator\nscore\nexact\voffset\fcompare\vconfig\f<S-Tab>\1\3\0\0\6i\6s\0\n<Tab>\1\3\0\0\6i\6s\0\t<CR>\rbehavior\1\0\1\vselect\2\fReplace\20ConfirmBehavior\fconfirm\n<C-c>\nclose\n<C-f>\n<C-b>\16scroll_docs\n<C-n>\21select_next_item\n<C-p>\1\0\0\21select_prev_item\fmapping\fsnippet\vexpand\1\0\0\0\fsources\1\0\0\1\0\1\tname\tcalc\1\0\1\tname\rnvim_lsp\1\0\1\tname\rnvim_lua\nsetup\0\14lazy_load luasnip.loaders.from_vscode\fluasnip\bcmp\frequire\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-docs-view"] = {
    commands = { "DocsViewToggle" },
    config = { "\27LJ\2\nN\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\rposition\vbottom\nsetup\14docs-view\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/opt/nvim-docs-view",
    url = "https://github.com/amrbashir/nvim-docs-view"
  },
  ["nvim-highlight-colors"] = {
    config = { "\27LJ\2\nm\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\vrender\15background\20enable_tailwind\2\nsetup\26nvim-highlight-colors\frequire\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/nvim-highlight-colors",
    url = "https://github.com/brenoprata10/nvim-highlight-colors"
  },
  ["nvim-lightbulb"] = {
    config = { "\27LJ\2\nG\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\21update_lightbulb\19nvim-lightbulb\frequireó\1\1\0\5\0\r\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0009\0\b\0005\2\t\0005\3\v\0003\4\n\0=\4\f\3B\0\3\1K\0\1\0\rcallback\1\0\1\tdesc2Show light bulb when code action is available\0\1\3\0\0\15CursorHold\16CursorHoldI\24nvim_create_autocmd\bapi\bvim\tsign\1\0\0\1\0\1\fenabled\2\nsetup\19nvim-lightbulb\frequire\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/nvim-lightbulb",
    url = "https://github.com/kosayoda/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\nc\0\1\t\0\3\0\0145\1\0\0006\2\1\0\18\4\1\0B\2\2\4X\5\5€9\a\2\0\5\a\6\0X\a\2€+\a\1\0L\a\2\0E\5\3\3R\5ù\127+\2\2\0L\2\2\0\tname\vipairs\1\4\0\0\rtsserver\thtml\ncsslsP\1\0\4\0\a\0\t6\0\0\0009\0\1\0009\0\2\0009\0\3\0005\2\4\0003\3\5\0=\3\6\2B\0\2\1K\0\1\0\vfilter\0\1\0\1\nasync\2\vformat\bbuf\blsp\bvimà\5\1\2\b\0 \0^6\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\4\0003\6\5\0005\a\6\0=\1\a\aB\2\5\0016\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\b\0006\6\0\0009\6\t\0069\6\n\0069\6\v\0065\a\f\0=\1\a\aB\2\5\0016\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\r\0006\6\0\0009\6\t\0069\6\n\0069\6\14\0065\a\15\0=\1\a\aB\2\5\0016\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\16\0006\6\0\0009\6\t\0069\6\n\0069\6\17\0065\a\18\0=\1\a\aB\2\5\0016\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\19\0006\6\0\0009\6\t\0069\6\n\0069\6\20\0065\a\21\0=\1\a\aB\2\5\0016\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\22\0006\6\0\0009\6\t\0069\6\n\0069\6\23\0065\a\24\0=\1\a\aB\2\5\0016\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\25\0006\6\0\0009\6\t\0069\6\n\0069\6\26\0065\a\27\0=\1\a\aB\2\5\0016\2\0\0009\2\1\0029\2\2\2'\4\28\0'\5\29\0006\6\0\0009\6\t\0069\6\n\0069\6\30\0065\a\31\0=\1\a\aB\2\5\1K\0\1\0\1\0\1\tdesc\19signature help\19signature_help\n<C-s>\6i\1\0\1\tdesc\17code actions\16code_action\14<leader>c\1\0\1\tdesc\vrename\vrename\14<leader>r\1\0\1\tdesc\26go to type definition\20type_definition\agy\1\0\1\tdesc\25go to implementation\19implementation\agi\1\0\1\tdesc\21go to references\15references\agr\1\0\1\tdesc\21go to definition\15definition\bbuf\blsp\agd\vbuffer\1\0\1\tdesc\18format buffer\0\agq\6n\bset\vkeymap\bvim¢\1\0\2\v\1\3\0\"6\2\0\0\18\4\1\0B\2\2\4H\5\27€6\a\1\0\18\t\6\0B\a\2\2\a\a\2\0X\a\21€6\a\1\0008\t\5\0\14\0\t\0X\n\1€+\t\1\0B\a\2\2\a\a\2\0X\a\v€-\a\0\0008\t\5\0\14\0\t\0X\n\1€4\t\0\0008\n\5\1\14\0\n\0X\v\1€4\n\0\0B\a\3\1X\a\3€<\6\5\0X\a\1€<\6\5\0F\5\3\3R\5ã\127L\0\2\0\3À\ntable\ttype\npairsÌ\r\1\0\16\0X\0£\0016\0\0\0009\0\1\0009\0\2\0009\0\3\0B\0\1\0026\1\4\0'\3\5\0B\1\2\0026\2\0\0009\2\6\0029\2\a\0025\4\b\0B\2\2\0013\2\t\0003\3\n\0005\4\f\0005\5\v\0=\5\r\0045\5\25\0005\6\23\0005\a\14\0005\b\16\0005\t\15\0=\t\17\b=\b\18\a5\b\20\0005\t\19\0=\t\21\b=\b\22\a=\a\24\6=\6\26\5=\5\27\4\18\5\3\0\18\a\0\0\18\b\4\0B\5\3\0015\5\28\0004\6\0\0=\6\29\0054\6\0\0=\6\30\0055\6 \0005\a\31\0=\a!\6=\6\"\0054\6\0\0=\6#\0054\6\0\0=\6$\0055\6&\0005\a%\0=\a'\6=\6(\0054\6\0\0=\6)\0055\6+\0005\a*\0=\a!\6=\6,\0054\6\0\0=\6-\0054\6\0\0=\6.\0054\6\0\0=\6/\0055\0062\0006\a\0\0009\a0\a9\a1\a=\a3\6=\0004\6=\0025\0066\a6\0\18\t\5\0B\a\2\4H\n\b€\18\f\3\0\18\14\v\0\18\15\6\0B\f\3\0018\f\n\0019\f7\f\18\14\v\0B\f\2\1F\n\3\3R\nö\1276\a\4\0'\t8\0B\a\2\0029\a7\a5\t:\0005\n9\0=\n;\t=\6\1\tB\a\2\0015\a=\0005\b<\0=\b'\a\18\b\3\0\18\n\a\0\18\v\6\0B\b\3\0016\b\4\0'\n>\0B\b\2\0029\b7\b5\n?\0=\a@\n5\vB\0005\fA\0=\fC\v=\vD\nB\b\2\0016\b\4\0'\nE\0B\b\2\0029\b7\b5\nF\0=\6@\n5\vH\0005\fG\0=\fC\v=\vI\nB\b\2\0016\b\4\0'\nJ\0B\b\2\0029\t7\b5\vK\0=\0025\v4\f\b\0009\rL\b9\rM\r9\rN\r>\r\1\f9\rL\b9\rM\r9\rO\r>\r\2\f9\rL\b9\rP\r9\rQ\r>\r\3\f9\rL\b9\rM\r9\rR\r>\r\4\f9\rL\b9\rP\r9\rS\r>\r\5\f9\rL\b9\rP\r9\rT\r>\r\6\f9\rL\b9\rU\r9\rV\r>\r\a\f=\fW\vB\t\2\0012\0\0€K\0\1\0\fsources\15dictionary\nhover\14checkmake\veslint\rprettier\bzsh\16diagnostics\nshfmt\nblack\15formatting\rbuiltins\1\0\0\fnull-ls\ntools\1\0\0\1\0\2\27parameter_hints_prefix\n ï˜¼ \23other_hints_prefix\nï˜½  \1\0\0\15rust-tools\15extensions\16inlay_hints\1\0\0\1\0\2\27parameter_hints_prefix\n ï˜¼ \23other_hints_prefix\nï˜½  \vserver\1\0\0\22clangd_extensions\1\0\0\1\6\0\0\vclangd\23--background-index\31--suggest-missing-includes\17--clang-tidy\28--header-insertion=iwyu\18widget_guides\1\0\0\1\0\1\fenabled\2\18flutter-tools\nsetup\npairs\14on_attach\17capabilities\rroot_dir\1\0\0\bcwd\tloop\14grammarly\bhls\ncssls\thtml\1\0\0\1\3\0\0\thtml\15htmldjango\rtsserver\16sumneko_lua\bcmd\1\0\0\1\2\0\0\24lua-language-server\npylsp\njdtls\vbashls\14filetypes\1\0\0\1\4\0\0\ash\bzsh\tbash\vtexlab\rphpactor\1\0\0\17textDocument\15completion\1\0\0\19completionItem\1\0\0\19resolveSupport\15properties\1\0\0\1\4\0\0\18documentation\vdetail\24additionalTextEdits\15tagSupport\rvalueSet\1\0\0\1\2\0\0\3\1\1\0\6\21preselectSupport\2\19snippetSupport\2\28commitCharactersSupport\2\22deprecatedSupport\2\24labelDetailsSupport\2\25insertReplaceSupport\2\19offsetEncoding\1\0\0\1\2\0\0\vutf-16\0\0\1\0\3\nsigns\1\17virtual_text\1\14underline\2\vconfig\15diagnostic\14lspconfig\frequire\29make_client_capabilities\rprotocol\blsp\bvim\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-pqf"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\bpqf\frequire\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/nvim-pqf",
    url = "https://gitlab.com/yorickpeterse/nvim-pqf"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\nÉ\2\0\0\4\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\frainbow\1\0\2\venable\2\18extended_mode\2\vindent\1\0\1\venable\2\14highlight\1\0\1\venable\2\21ensure_installed\1\0\0\1\25\0\0\6c\blua\fhaskell\tbash\ncmake\bcpp\bcss\tdart\tfish\ago\thtml\tjava\15javascript\tjson\njson5\blua\tllvm\tmake\bphp\6r\rsolidity\15typescript\tyaml\bvim\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-ts-autotag"] = {
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20nvim-ts-autotag\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/opt/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-rainbow"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/nvim-ts-rainbow",
    url = "https://github.com/p00f/nvim-ts-rainbow"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["rust-tools.nvim"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/rust-tools.nvim",
    url = "https://github.com/simrat39/rust-tools.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n;\0\0\3\1\2\0\5-\0\0\0009\0\0\0005\2\1\0B\0\2\1K\0\1\0\1À\1\0\2\vfollow\2\vhidden\2\15find_files\28\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\2\0\0\r--followC\1\0\4\1\4\0\a-\0\0\0009\0\0\0005\2\2\0003\3\1\0=\3\3\2B\0\2\1K\0\1\0\1À\20additional_args\1\0\0\0\14live_grepü\a\1\0\n\0002\0U6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\3\4\0005\5\20\0005\6\5\0005\a\6\0=\a\a\0065\a\17\0005\b\t\0009\t\b\2=\t\n\b9\t\v\2=\t\f\b9\t\r\2=\t\14\b9\t\15\2=\t\16\b=\b\18\a=\a\19\6=\6\21\0055\6\23\0005\a\22\0=\a\24\6=\6\25\5B\3\2\0019\3\26\0'\5\24\0B\3\2\0016\3\0\0'\5\27\0B\3\2\0029\3\4\0035\5\29\0005\6\28\0=\6\30\5B\3\2\0016\3\31\0009\3 \0039\3!\3'\5\"\0'\6#\0003\a$\0005\b%\0B\3\5\0016\3\31\0009\3 \0039\3!\3'\5\"\0'\6&\0009\a'\0015\b(\0B\3\5\0016\3\31\0009\3 \0039\3!\3'\5\"\0'\6)\0003\a*\0005\b+\0B\3\5\0016\3\31\0009\3 \0039\3!\3'\5\"\0'\6,\0009\a-\0015\b.\0B\3\5\0016\3\31\0009\3 \0039\3!\3'\5\"\0'\6/\0009\a0\0015\b1\0B\3\5\0012\0\0€K\0\1\0\1\0\1\tdesc\25spelling suggestions\18spell_suggest\az=\1\0\1\tdesc\19search keymaps\fkeymaps\14<leader>?\1\0\1\tdesc\14live grep\0\14<leader>/\1\0\1\tdesc\17recent files\roldfiles\14<leader>o\1\0\1\tdesc\15find files\0\21<leader><leader>\6n\bset\vkeymap\bvim\ninput\1\0\0\1\0\1\fenabled\1\rdressing\19load_extension\15extensions\bfzf\1\0\0\1\0\4\28override_generic_sorter\2\nfuzzy\2\14case_mode\15smart_case\25override_file_sorter\2\rdefaults\1\0\0\rmappings\6i\1\0\0\n<C-k>\28move_selection_previous\n<C-j>\24move_selection_next\n<C-l>\26smart_send_to_loclist\n<C-q>\1\0\0\25smart_send_to_qflist\18layout_config\1\0\1\20prompt_position\btop\1\0\4\21sorting_strategy\14ascending\17entry_prefix\a  \20selection_caret\a  \18prompt_prefix\nî­¨  \nsetup\22telescope.actions\22telescope.builtin\14telescope\frequire\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/vim-eunuch",
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-fugitive"] = {
    config = { "\27LJ\2\nÌ\2\0\0\a\0\21\0#6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\4\0005\5\3\0=\5\5\4=\4\a\3B\1\2\0016\1\b\0009\1\t\0019\1\n\1'\3\v\0'\4\f\0'\5\r\0005\6\14\0B\1\5\0016\1\b\0009\1\t\0019\1\n\1'\3\v\0'\4\15\0'\5\16\0005\6\17\0B\1\5\0016\1\b\0009\1\t\0019\1\n\1'\3\v\0'\4\18\0'\5\19\0005\6\20\0B\1\5\1K\0\1\0\1\0\1\tdesc\vstatus\20:Git status<CR>\15<leader>gs\1\0\1\tdesc\vcommit\16:Git commit\15<leader>gc\1\0\1\tdesc\vprompt\n:Git \15<leader>gg\6n\bset\vkeymap\bvim\r<leader>\1\0\0\6g\1\0\0\1\0\1\tname\bgit\rregister\14which-key\frequire\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-kitty"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/vim-kitty",
    url = "https://github.com/fladson/vim-kitty"
  },
  ["vim-qf"] = {
    config = { "\27LJ\2\n¨\3\0\0\6\0\16\0!6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\a\0'\4\b\0005\5\t\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\n\0'\4\v\0005\5\f\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\r\0'\4\14\0005\5\15\0B\0\5\1K\0\1\0\1\0\1\tdesc%Goto previous location list item\28<Plug>(qf_loc_previous)\n<C-k>\1\0\1\tdesc!Goto next location list item\24<Plug>(qf_loc_next)\n<C-j>\1\0\1\tdesc&Goto previous quick-fix list item\27<Plug>(qf_qf_previous)\n<A-k>\1\0\1\tdesc\"Goto next quick-fix list item\23<Plug>(qf_qf_next)\n<A-j>\6n\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/vim-qf",
    url = "https://github.com/romainl/vim-qf"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-rsi"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/vim-rsi",
    url = "https://github.com/tpope/vim-rsi"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-sxhkdrc"] = {
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/vim-sxhkdrc",
    url = "https://github.com/baskerville/vim-sxhkdrc"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n»\t\0\0\a\0=\0”\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\6\0'\4\a\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\b\0'\3\t\0'\4\n\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\b\0'\3\v\0'\4\f\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\3\0'\4\r\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\14\0'\4\15\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\16\0'\4\17\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\18\0'\4\19\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\b\0'\3\20\0'\4\21\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\b\0'\3\22\0'\4\23\0B\0\4\0016\0\0\0009\0\24\0)\1,\1=\1\25\0006\0\26\0'\2\27\0B\0\2\0029\1\28\0005\3 \0005\4\30\0005\5\29\0=\5\31\4=\4!\3B\1\2\0016\1\0\0009\1\1\0019\1\2\1'\3\3\0'\4\"\0'\5#\0005\6$\0B\1\5\0016\1\0\0009\1\1\0019\1\2\1'\3\3\0'\4%\0'\5&\0005\6'\0B\1\5\0016\1\0\0009\1\1\0019\1\2\1'\3\3\0'\4(\0'\5)\0005\6*\0B\1\5\0019\1+\0005\3/\0005\4-\0005\5,\0=\5.\4=\0040\3B\1\2\0016\1\0\0009\1\1\0019\1\2\1'\3\3\0'\0041\0'\0052\0005\0063\0B\1\5\0016\1\0\0009\1\1\0019\1\2\1'\3\3\0'\0044\0'\0055\0005\0066\0B\1\5\0016\1\0\0009\1\1\0019\1\2\1'\3\3\0'\0047\0'\0058\0005\0069\0B\1\5\0016\1\0\0009\1\1\0019\1\2\1'\3\3\0'\4:\0'\5;\0005\6<\0B\1\5\1K\0\1\0\1\0\1\tdesc\26relative line numbers\29:set relativenumber!<CR>\15<leader>tn\1\0\1\tdesc\19spell checking\20:set spell!<CR>\15<leader>ts\1\0\1\tdesc\18line wrapping\19:set wrap!<CR>\15<leader>tr\1\0\1\tdesc\15whitespace\19:set list!<CR>\15<leader>tw\r<leader>\1\0\0\6t\1\0\0\1\0\1\tname\vtoggle\rregister\1\0\1\tdesc\tmake\14:make<CR>\14<leader>m\1\0\1\tdesc\25toggle location list\26<Plug>(qf_loc_toggle)\14<leader>l\1\0\1\tdesc\25toggle quickfix list\25<Plug>(qf_qf_toggle)\14<leader>q\fplugins\1\0\0\fpresets\1\0\0\1\0\3\17text_objects\1\fmotions\1\14operators\1\nsetup\14which-key\frequire\15timeoutlen\bopt\21:m '<-2<CR>gv=gv\6K\21:m '>+1<CR>gv=gv\6J\b#zz\6#\b*zz\6*\bNzz\6N\bnzz\b<gv\6<\b>gv\6>\6v\bGzz\6G\n<nop>\n<C-z>\6n\bset\vkeymap\bvim\0" },
    loaded = true,
    path = "/home/nimai/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: nvim-docs-view
time([[Setup for nvim-docs-view]], true)
try_loadstring("\27LJ\2\ng\0\0\6\0\a\0\t6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\1K\0\1\0\1\0\1\tdesc\tdocs\24:DocsViewToggle<CR>\14<leader>k\6n\bset\vkeymap\bvim\0", "setup", "nvim-docs-view")
time([[Setup for nvim-docs-view]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\1\2\0\5-\0\0\0009\0\0\0005\2\1\0B\0\2\1K\0\1\0\1À\1\0\2\vfollow\2\vhidden\2\15find_files\28\0\0\1\0\1\0\0025\0\0\0L\0\2\0\1\2\0\0\r--followC\1\0\4\1\4\0\a-\0\0\0009\0\0\0005\2\2\0003\3\1\0=\3\3\2B\0\2\1K\0\1\0\1À\20additional_args\1\0\0\0\14live_grepü\a\1\0\n\0002\0U6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\3\4\0005\5\20\0005\6\5\0005\a\6\0=\a\a\0065\a\17\0005\b\t\0009\t\b\2=\t\n\b9\t\v\2=\t\f\b9\t\r\2=\t\14\b9\t\15\2=\t\16\b=\b\18\a=\a\19\6=\6\21\0055\6\23\0005\a\22\0=\a\24\6=\6\25\5B\3\2\0019\3\26\0'\5\24\0B\3\2\0016\3\0\0'\5\27\0B\3\2\0029\3\4\0035\5\29\0005\6\28\0=\6\30\5B\3\2\0016\3\31\0009\3 \0039\3!\3'\5\"\0'\6#\0003\a$\0005\b%\0B\3\5\0016\3\31\0009\3 \0039\3!\3'\5\"\0'\6&\0009\a'\0015\b(\0B\3\5\0016\3\31\0009\3 \0039\3!\3'\5\"\0'\6)\0003\a*\0005\b+\0B\3\5\0016\3\31\0009\3 \0039\3!\3'\5\"\0'\6,\0009\a-\0015\b.\0B\3\5\0016\3\31\0009\3 \0039\3!\3'\5\"\0'\6/\0009\a0\0015\b1\0B\3\5\0012\0\0€K\0\1\0\1\0\1\tdesc\25spelling suggestions\18spell_suggest\az=\1\0\1\tdesc\19search keymaps\fkeymaps\14<leader>?\1\0\1\tdesc\14live grep\0\14<leader>/\1\0\1\tdesc\17recent files\roldfiles\14<leader>o\1\0\1\tdesc\15find files\0\21<leader><leader>\6n\bset\vkeymap\bvim\ninput\1\0\0\1\0\1\fenabled\1\rdressing\19load_extension\15extensions\bfzf\1\0\0\1\0\4\28override_generic_sorter\2\nfuzzy\2\14case_mode\15smart_case\25override_file_sorter\2\rdefaults\1\0\0\rmappings\6i\1\0\0\n<C-k>\28move_selection_previous\n<C-j>\24move_selection_next\n<C-l>\26smart_send_to_loclist\n<C-q>\1\0\0\25smart_send_to_qflist\18layout_config\1\0\1\20prompt_position\btop\1\0\4\21sorting_strategy\14ascending\17entry_prefix\a  \20selection_caret\a  \18prompt_prefix\nî­¨  \nsetup\22telescope.actions\22telescope.builtin\14telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-lightbulb
time([[Config for nvim-lightbulb]], true)
try_loadstring("\27LJ\2\nG\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\21update_lightbulb\19nvim-lightbulb\frequireó\1\1\0\5\0\r\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\0016\0\6\0009\0\a\0009\0\b\0005\2\t\0005\3\v\0003\4\n\0=\4\f\3B\0\3\1K\0\1\0\rcallback\1\0\1\tdesc2Show light bulb when code action is available\0\1\3\0\0\15CursorHold\16CursorHoldI\24nvim_create_autocmd\bapi\bvim\tsign\1\0\0\1\0\1\fenabled\2\nsetup\19nvim-lightbulb\frequire\0", "config", "nvim-lightbulb")
time([[Config for nvim-lightbulb]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\nc\0\1\t\0\3\0\0145\1\0\0006\2\1\0\18\4\1\0B\2\2\4X\5\5€9\a\2\0\5\a\6\0X\a\2€+\a\1\0L\a\2\0E\5\3\3R\5ù\127+\2\2\0L\2\2\0\tname\vipairs\1\4\0\0\rtsserver\thtml\ncsslsP\1\0\4\0\a\0\t6\0\0\0009\0\1\0009\0\2\0009\0\3\0005\2\4\0003\3\5\0=\3\6\2B\0\2\1K\0\1\0\vfilter\0\1\0\1\nasync\2\vformat\bbuf\blsp\bvimà\5\1\2\b\0 \0^6\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\4\0003\6\5\0005\a\6\0=\1\a\aB\2\5\0016\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\b\0006\6\0\0009\6\t\0069\6\n\0069\6\v\0065\a\f\0=\1\a\aB\2\5\0016\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\r\0006\6\0\0009\6\t\0069\6\n\0069\6\14\0065\a\15\0=\1\a\aB\2\5\0016\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\16\0006\6\0\0009\6\t\0069\6\n\0069\6\17\0065\a\18\0=\1\a\aB\2\5\0016\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\19\0006\6\0\0009\6\t\0069\6\n\0069\6\20\0065\a\21\0=\1\a\aB\2\5\0016\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\22\0006\6\0\0009\6\t\0069\6\n\0069\6\23\0065\a\24\0=\1\a\aB\2\5\0016\2\0\0009\2\1\0029\2\2\2'\4\3\0'\5\25\0006\6\0\0009\6\t\0069\6\n\0069\6\26\0065\a\27\0=\1\a\aB\2\5\0016\2\0\0009\2\1\0029\2\2\2'\4\28\0'\5\29\0006\6\0\0009\6\t\0069\6\n\0069\6\30\0065\a\31\0=\1\a\aB\2\5\1K\0\1\0\1\0\1\tdesc\19signature help\19signature_help\n<C-s>\6i\1\0\1\tdesc\17code actions\16code_action\14<leader>c\1\0\1\tdesc\vrename\vrename\14<leader>r\1\0\1\tdesc\26go to type definition\20type_definition\agy\1\0\1\tdesc\25go to implementation\19implementation\agi\1\0\1\tdesc\21go to references\15references\agr\1\0\1\tdesc\21go to definition\15definition\bbuf\blsp\agd\vbuffer\1\0\1\tdesc\18format buffer\0\agq\6n\bset\vkeymap\bvim¢\1\0\2\v\1\3\0\"6\2\0\0\18\4\1\0B\2\2\4H\5\27€6\a\1\0\18\t\6\0B\a\2\2\a\a\2\0X\a\21€6\a\1\0008\t\5\0\14\0\t\0X\n\1€+\t\1\0B\a\2\2\a\a\2\0X\a\v€-\a\0\0008\t\5\0\14\0\t\0X\n\1€4\t\0\0008\n\5\1\14\0\n\0X\v\1€4\n\0\0B\a\3\1X\a\3€<\6\5\0X\a\1€<\6\5\0F\5\3\3R\5ã\127L\0\2\0\3À\ntable\ttype\npairsÌ\r\1\0\16\0X\0£\0016\0\0\0009\0\1\0009\0\2\0009\0\3\0B\0\1\0026\1\4\0'\3\5\0B\1\2\0026\2\0\0009\2\6\0029\2\a\0025\4\b\0B\2\2\0013\2\t\0003\3\n\0005\4\f\0005\5\v\0=\5\r\0045\5\25\0005\6\23\0005\a\14\0005\b\16\0005\t\15\0=\t\17\b=\b\18\a5\b\20\0005\t\19\0=\t\21\b=\b\22\a=\a\24\6=\6\26\5=\5\27\4\18\5\3\0\18\a\0\0\18\b\4\0B\5\3\0015\5\28\0004\6\0\0=\6\29\0054\6\0\0=\6\30\0055\6 \0005\a\31\0=\a!\6=\6\"\0054\6\0\0=\6#\0054\6\0\0=\6$\0055\6&\0005\a%\0=\a'\6=\6(\0054\6\0\0=\6)\0055\6+\0005\a*\0=\a!\6=\6,\0054\6\0\0=\6-\0054\6\0\0=\6.\0054\6\0\0=\6/\0055\0062\0006\a\0\0009\a0\a9\a1\a=\a3\6=\0004\6=\0025\0066\a6\0\18\t\5\0B\a\2\4H\n\b€\18\f\3\0\18\14\v\0\18\15\6\0B\f\3\0018\f\n\0019\f7\f\18\14\v\0B\f\2\1F\n\3\3R\nö\1276\a\4\0'\t8\0B\a\2\0029\a7\a5\t:\0005\n9\0=\n;\t=\6\1\tB\a\2\0015\a=\0005\b<\0=\b'\a\18\b\3\0\18\n\a\0\18\v\6\0B\b\3\0016\b\4\0'\n>\0B\b\2\0029\b7\b5\n?\0=\a@\n5\vB\0005\fA\0=\fC\v=\vD\nB\b\2\0016\b\4\0'\nE\0B\b\2\0029\b7\b5\nF\0=\6@\n5\vH\0005\fG\0=\fC\v=\vI\nB\b\2\0016\b\4\0'\nJ\0B\b\2\0029\t7\b5\vK\0=\0025\v4\f\b\0009\rL\b9\rM\r9\rN\r>\r\1\f9\rL\b9\rM\r9\rO\r>\r\2\f9\rL\b9\rP\r9\rQ\r>\r\3\f9\rL\b9\rM\r9\rR\r>\r\4\f9\rL\b9\rP\r9\rS\r>\r\5\f9\rL\b9\rP\r9\rT\r>\r\6\f9\rL\b9\rU\r9\rV\r>\r\a\f=\fW\vB\t\2\0012\0\0€K\0\1\0\fsources\15dictionary\nhover\14checkmake\veslint\rprettier\bzsh\16diagnostics\nshfmt\nblack\15formatting\rbuiltins\1\0\0\fnull-ls\ntools\1\0\0\1\0\2\27parameter_hints_prefix\n ï˜¼ \23other_hints_prefix\nï˜½  \1\0\0\15rust-tools\15extensions\16inlay_hints\1\0\0\1\0\2\27parameter_hints_prefix\n ï˜¼ \23other_hints_prefix\nï˜½  \vserver\1\0\0\22clangd_extensions\1\0\0\1\6\0\0\vclangd\23--background-index\31--suggest-missing-includes\17--clang-tidy\28--header-insertion=iwyu\18widget_guides\1\0\0\1\0\1\fenabled\2\18flutter-tools\nsetup\npairs\14on_attach\17capabilities\rroot_dir\1\0\0\bcwd\tloop\14grammarly\bhls\ncssls\thtml\1\0\0\1\3\0\0\thtml\15htmldjango\rtsserver\16sumneko_lua\bcmd\1\0\0\1\2\0\0\24lua-language-server\npylsp\njdtls\vbashls\14filetypes\1\0\0\1\4\0\0\ash\bzsh\tbash\vtexlab\rphpactor\1\0\0\17textDocument\15completion\1\0\0\19completionItem\1\0\0\19resolveSupport\15properties\1\0\0\1\4\0\0\18documentation\vdetail\24additionalTextEdits\15tagSupport\rvalueSet\1\0\0\1\2\0\0\3\1\1\0\6\21preselectSupport\2\19snippetSupport\2\28commitCharactersSupport\2\22deprecatedSupport\2\24labelDetailsSupport\2\25insertReplaceSupport\2\19offsetEncoding\1\0\0\1\2\0\0\vutf-16\0\0\1\0\3\nsigns\1\17virtual_text\1\14underline\2\vconfig\15diagnostic\14lspconfig\frequire\29make_client_capabilities\rprotocol\blsp\bvim\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\nn\0\0\6\1\6\1\17-\0\0\0009\0\0\0004\2\3\0006\3\1\0009\3\2\0039\3\3\3'\5\4\0B\3\2\2>\3\1\0026\3\1\0009\3\2\0039\3\3\3'\5\5\0B\3\2\0?\3\0\0B\0\2\1K\0\1\0\0À\6v\6.\tline\afn\bvim\15stage_hunk\5€€À™\4n\0\0\6\1\6\1\17-\0\0\0009\0\0\0004\2\3\0006\3\1\0009\3\2\0039\3\3\3'\5\4\0B\3\2\2>\3\1\0026\3\1\0009\3\2\0039\3\3\3'\5\5\0B\3\2\0?\3\0\0B\0\2\1K\0\1\0\0À\6v\6.\tline\afn\bvim\15reset_hunk\5€€À™\4ÿ\b\1\0\t\0007\0~6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\3\4\0004\5\0\0B\3\2\0019\3\5\0025\5\t\0005\6\a\0005\a\6\0=\a\b\6=\6\n\0055\6\v\0B\3\3\0019\3\5\0025\5\14\0005\6\r\0005\a\f\0=\a\b\6=\6\n\0055\6\15\0B\3\3\0016\3\16\0009\3\17\0039\3\18\3'\5\19\0'\6\20\0003\a\21\0005\b\22\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\19\0'\6\23\0003\a\24\0005\b\25\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\6\27\0009\a\28\0015\b\29\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\6\30\0009\a\31\0015\b \0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\6\20\0009\a!\0005\b\"\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\6#\0009\a$\0005\b%\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\6\23\0009\a&\0005\b'\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\6(\0009\a)\0005\b*\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\6+\0009\a,\0005\b-\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\6.\0009\a/\0005\b0\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\0061\0'\a2\0005\b3\0B\3\5\0016\3\16\0009\3\17\0039\3\18\3'\5\26\0'\0064\0'\a5\0005\b6\0B\3\5\0012\0\0€K\0\1\0\1\0\1\tdesc\18location list\29:Gitsigns setloclist<CR>\15<leader>hl\1\0\1\tdesc\18quickfix list\28:Gitsigns setqflist<CR>\15<leader>hq\1\0\1\tdesc\20undo stage hunk\20undo_stage_hunk\15<leader>hu\1\0\1\tdesc\19preview buffer\17preview_hunk\15<leader>ho\1\0\1\tdesc\17reset buffer\17reset_buffer\15<leader>hR\1\0\1\tdesc\15reset hunk\15reset_hunk\1\0\1\tdesc\17stage buffer\17stage_buffer\15<leader>hS\1\0\1\tdesc\15stage hunk\15stage_hunk\1\0\1\tdesc\18previous hunk\14prev_hunk\a[h\1\0\1\tdesc\14next hunk\14next_hunk\a]h\6n\1\0\1\tdesc\15reset hunk\0\15<leader>hr\1\0\1\tdesc\15stage hunk\0\15<leader>hs\6v\bset\vkeymap\bvim\1\0\1\tmode\6n\1\0\0\1\0\0\1\0\1\tname\nhunks\1\0\1\tmode\6v\r<leader>\1\0\0\6h\1\0\0\1\0\1\tname\nhunks\rregister\nsetup\14which-key\21gitsigns.actions\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: nvim-pqf
time([[Config for nvim-pqf]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\bpqf\frequire\0", "config", "nvim-pqf")
time([[Config for nvim-pqf]], false)
-- Config for: mason.nvim
time([[Config for mason.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\nmason\frequire\0", "config", "mason.nvim")
time([[Config for mason.nvim]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
try_loadstring("\27LJ\2\nÌ\2\0\0\a\0\21\0#6\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\6\0005\4\4\0005\5\3\0=\5\5\4=\4\a\3B\1\2\0016\1\b\0009\1\t\0019\1\n\1'\3\v\0'\4\f\0'\5\r\0005\6\14\0B\1\5\0016\1\b\0009\1\t\0019\1\n\1'\3\v\0'\4\15\0'\5\16\0005\6\17\0B\1\5\0016\1\b\0009\1\t\0019\1\n\1'\3\v\0'\4\18\0'\5\19\0005\6\20\0B\1\5\1K\0\1\0\1\0\1\tdesc\vstatus\20:Git status<CR>\15<leader>gs\1\0\1\tdesc\vcommit\16:Git commit\15<leader>gc\1\0\1\tdesc\vprompt\n:Git \15<leader>gg\6n\bset\vkeymap\bvim\r<leader>\1\0\0\6g\1\0\0\1\0\1\tname\bgit\rregister\14which-key\frequire\0", "config", "vim-fugitive")
time([[Config for vim-fugitive]], false)
-- Config for: vim-qf
time([[Config for vim-qf]], true)
try_loadstring("\27LJ\2\n¨\3\0\0\6\0\16\0!6\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0005\5\6\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\a\0'\4\b\0005\5\t\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\n\0'\4\v\0005\5\f\0B\0\5\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\r\0'\4\14\0005\5\15\0B\0\5\1K\0\1\0\1\0\1\tdesc%Goto previous location list item\28<Plug>(qf_loc_previous)\n<C-k>\1\0\1\tdesc!Goto next location list item\24<Plug>(qf_loc_next)\n<C-j>\1\0\1\tdesc&Goto previous quick-fix list item\27<Plug>(qf_qf_previous)\n<A-k>\1\0\1\tdesc\"Goto next quick-fix list item\23<Plug>(qf_qf_next)\n<A-j>\6n\bset\vkeymap\bvim\0", "config", "vim-qf")
time([[Config for vim-qf]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nÐ\1\0\0\b\0\b\2!6\0\0\0006\2\1\0009\2\2\0029\2\3\2)\4\0\0B\2\2\0A\0\0\3\b\1\0\0X\2\20€6\2\1\0009\2\2\0029\2\4\2)\4\0\0\23\5\1\0\18\6\0\0+\a\2\0B\2\5\2:\2\1\2\18\4\2\0009\2\5\2\18\5\1\0\18\6\1\0B\2\4\2\18\4\2\0009\2\6\2'\5\a\0B\2\3\2\n\2\0\0X\2\2€+\2\1\0X\3\1€+\2\2\0L\2\2\0\a%s\nmatch\bsub\23nvim_buf_get_lines\24nvim_win_get_cursor\bapi\bvim\vunpack\0\2-\0\1\4\1\2\0\5-\1\0\0009\1\0\0019\3\1\0B\1\2\1K\0\1\0\1À\tbody\15lsp_expandÅ\1\0\1\3\3\5\0\29-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4€-\1\0\0009\1\1\1B\1\1\1X\1\19€-\1\1\0009\1\2\1B\1\1\2\15\0\1\0X\2\4€-\1\1\0009\1\3\1B\1\1\1X\1\n€-\1\2\0B\1\1\2\15\0\1\0X\2\4€-\1\0\0009\1\4\1B\1\1\1X\1\2€\18\1\0\0B\1\1\1K\0\1\0\0À\1À\2À\rcomplete\19expand_or_jump\23expand_or_jumpable\21select_next_item\fvisibleŽ\1\0\1\4\2\4\0\23-\1\0\0009\1\0\1B\1\1\2\15\0\1\0X\2\4€-\1\0\0009\1\1\1B\1\1\1X\1\r€-\1\1\0009\1\2\1)\3ÿÿB\1\2\2\15\0\1\0X\2\5€-\1\1\0009\1\3\1)\3ÿÿB\1\2\1X\1\2€\18\1\0\0B\1\1\1K\0\1\0\0À\1À\tjump\rjumpable\21select_prev_item\fvisibleb\0\0\6\1\6\0\v-\0\0\0009\0\0\0005\2\4\0005\3\2\0004\4\3\0005\5\1\0>\5\1\4=\4\3\3=\3\5\2B\0\2\1K\0\1\0\0À\vconfig\1\0\0\fsources\1\0\0\1\0\1\tname\vbuffer\rcompleteb\0\0\6\1\6\0\v-\0\0\0009\0\0\0005\2\4\0005\3\2\0004\4\3\0005\5\1\0>\5\1\4=\4\3\3=\3\5\2B\0\2\1K\0\1\0\0À\vconfig\1\0\0\fsources\1\0\0\1\0\1\tname\vbuffer\rcomplete`\0\0\6\1\6\0\v-\0\0\0009\0\0\0005\2\4\0005\3\2\0004\4\3\0005\5\1\0>\5\1\4=\4\3\3=\3\5\2B\0\2\1K\0\1\0\0À\vconfig\1\0\0\fsources\1\0\0\1\0\1\tname\tpath\rcompletec\0\0\6\1\6\0\v-\0\0\0009\0\0\0005\2\4\0005\3\2\0004\4\3\0005\5\1\0>\5\1\4=\4\3\3=\3\5\2B\0\2\1K\0\1\0\0À\vconfig\1\0\0\fsources\1\0\0\1\0\1\tname\fluasnip\rcomplete’\1\0\0\6\1\b\0\15-\0\0\0009\0\0\0005\2\6\0005\3\4\0004\4\4\0005\5\1\0>\5\1\0045\5\2\0>\5\2\0045\5\3\0>\5\3\4=\4\5\3=\3\a\2B\0\2\1K\0\1\0\0À\vconfig\1\0\0\fsources\1\0\0\1\0\1\tname\tcalc\1\0\1\tname\rnvim_lsp\1\0\1\tname\rnvim_lua\rcomplete„\r\1\0\14\0Z\0ä\0016\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0029\2\4\2B\2\1\0013\2\5\0009\3\6\0005\5\n\0004\6\4\0005\a\a\0>\a\1\0065\a\b\0>\a\2\0065\a\t\0>\a\3\6=\6\v\0055\6\r\0003\a\f\0=\a\14\6=\6\15\0055\6\18\0009\a\16\0009\a\17\aB\a\1\2=\a\19\0069\a\16\0009\a\20\aB\a\1\2=\a\21\0069\a\16\0009\a\22\a)\tüÿB\a\2\2=\a\23\0069\a\16\0009\a\22\a)\t\4\0B\a\2\2=\a\24\0069\a\16\0009\a\25\aB\a\1\2=\a\26\0069\a\16\0009\a\27\a5\t\30\0009\n\28\0009\n\29\n=\n\31\tB\a\2\2=\a \0069\a\16\0003\t!\0005\n\"\0B\a\3\2=\a#\0069\a\16\0003\t$\0005\n%\0B\a\3\2=\a&\6=\6\16\0055\0062\0004\a\t\0009\b'\0009\b(\b9\b)\b>\b\1\a9\b'\0009\b(\b9\b*\b>\b\2\a9\b'\0009\b(\b9\b+\b>\b\3\a6\b\0\0'\n,\0B\b\2\0029\b-\b>\b\4\a9\b'\0009\b(\b9\b.\b>\b\5\a9\b'\0009\b(\b9\b/\b>\b\6\a9\b'\0009\b(\b9\b0\b>\b\a\a9\b'\0009\b(\b9\b1\b>\b\b\a=\a3\6=\0064\5B\3\2\0016\0035\0009\0036\0039\0037\3'\0058\0'\6\21\0003\a9\0005\b:\0B\3\5\0016\0035\0009\0036\0039\0037\3'\0058\0'\6\19\0003\a;\0005\b<\0B\3\5\0016\0035\0009\0036\0039\0037\3'\0058\0'\6=\0003\a>\0005\b?\0B\3\5\0016\0035\0009\0036\0039\0037\3'\0058\0'\6@\0003\aA\0005\bB\0B\3\5\0016\0035\0009\0036\0039\0037\3'\0058\0'\6C\0003\aD\0005\bE\0B\3\5\0016\0035\0009\0036\0039\0037\3'\5F\0'\6G\0'\aH\0B\3\4\0016\0035\0009\0036\0039\0037\3'\5F\0'\6I\0'\aJ\0B\3\4\0016\3K\0005\5L\0B\3\2\4X\6\t€9\b\6\0009\bM\b\18\n\a\0005\vO\0004\f\3\0005\rN\0>\r\1\f=\f\v\vB\b\3\1E\6\3\3R\6õ\1276\3\0\0'\5\1\0B\3\2\0029\3\6\0039\3M\3'\5P\0005\6R\0009\a\16\0009\aQ\a9\aM\aB\a\1\2=\a\16\0064\a\3\0005\bS\0>\b\1\a=\a\v\6B\3\3\0016\3\0\0'\5\1\0B\3\2\0029\3\6\0039\3M\3'\5T\0005\6U\0009\a\16\0009\aQ\a9\aM\aB\a\1\2=\a\16\0064\a\3\0005\bV\0>\b\1\a=\a\v\6B\3\3\0016\3\0\0'\5\1\0B\3\2\0029\3\6\0039\3M\3'\5W\0005\6X\0009\a\16\0009\aQ\a9\aM\aB\a\1\2=\a\16\0064\a\3\0005\bY\0>\b\1\a=\a\v\6B\3\3\0012\0\0€K\0\1\0\1\0\1\tname\fcmdline\1\0\0\6:\1\0\1\tname\vbuffer\1\0\0\6?\1\0\1\tname\vbuffer\1\0\0\vpreset\6/\1\0\0\1\0\1\tname\20cmdline_history\fcmdline\1\5\0\0\6:\6/\6?\6@\vipairs\t<up>\n<C-k>\v<down>\n<C-j>\6c\1\0\1\tdesc\rsnippets\0\14<C-SPACE>\1\0\1\tdesc\rsnippets\0\15<C-x><C-s>\1\0\1\tdesc\20path completion\0\15<C-x><C-f>\1\0\1\tdesc\22buffer completion\0\1\0\1\tdesc\22buffer completion\0\6i\bset\vkeymap\bvim\fsorting\16comparators\1\0\0\norder\vlength\14sort_text\tkind\nunder\25cmp-under-comparator\nscore\nexact\voffset\fcompare\vconfig\f<S-Tab>\1\3\0\0\6i\6s\0\n<Tab>\1\3\0\0\6i\6s\0\t<CR>\rbehavior\1\0\1\vselect\2\fReplace\20ConfirmBehavior\fconfirm\n<C-c>\nclose\n<C-f>\n<C-b>\16scroll_docs\n<C-n>\21select_next_item\n<C-p>\1\0\0\21select_prev_item\fmapping\fsnippet\vexpand\1\0\0\0\fsources\1\0\0\1\0\1\tname\tcalc\1\0\1\tname\rnvim_lsp\1\0\1\tname\rnvim_lua\nsetup\0\14lazy_load luasnip.loaders.from_vscode\fluasnip\bcmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: diaglist.nvim
time([[Config for diaglist.nvim]], true)
try_loadstring("\27LJ\2\nT\0\0\4\0\4\0\a6\0\0\0009\0\1\0009\0\2\0+\2\0\0005\3\3\0B\0\3\1K\0\1\0\1\0\2\nscope\vcursor\nfocus\1\15open_float\15diagnostic\bvimµ\3\1\0\a\0\20\0+6\0\0\0'\2\1\0B\0\2\0029\1\2\0004\3\0\0B\1\2\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\a\0003\5\b\0005\6\t\0B\1\5\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\n\0006\5\3\0009\5\v\0059\5\f\0055\6\r\0B\1\5\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\14\0006\5\3\0009\5\v\0059\5\15\0055\6\16\0B\1\5\0016\1\3\0009\1\4\0019\1\5\1'\3\6\0'\4\17\0009\5\18\0005\6\19\0B\1\5\1K\0\1\0\1\0\1\tdesc%open all diagnostics in quickfix\25open_all_diagnostics\14<leader>d\1\0\1\tdesc\24previous diagnostic\14goto_prev\a[d\1\0\1\tdesc\20next diagnostic\14goto_next\15diagnostic\a]d\1\0\1\tdesc/open cursor diagnostics in floating window\0\n<C-h>\6n\bset\vkeymap\bvim\tinit\rdiaglist\frequire\0", "config", "diaglist.nvim")
time([[Config for diaglist.nvim]], false)
-- Config for: bufdelete.nvim
time([[Config for bufdelete.nvim]], true)
try_loadstring("\27LJ\2\næ\2\0\0\a\0\18\0$6\0\0\0'\2\1\0B\0\2\0026\1\2\0009\1\3\0019\1\4\1'\3\5\0'\4\6\0009\5\a\0005\6\b\0B\1\5\0016\1\2\0009\1\3\0019\1\4\1'\3\5\0'\4\t\0'\5\n\0005\6\v\0B\1\5\0016\1\2\0009\1\3\0019\1\4\1'\3\5\0'\4\f\0'\5\r\0005\6\14\0B\1\5\0016\1\2\0009\1\3\0019\1\4\1'\3\5\0'\4\15\0'\5\16\0005\6\17\0B\1\5\1K\0\1\0\1\0\1\tdesc\17close buffer\17:Bdelete<CR>\14<leader>x\1\0\1\tdesc\20Previous buffer\19:bprevious<CR>\n<C-p>\1\0\1\tdesc\16Next buffer\15:bnext<CR>\n<C-n>\1\0\1\tdesc\16find buffer\fbuffers\14<leader>b\6n\bset\vkeymap\bvim\22telescope.builtin\frequire\0", "config", "bufdelete.nvim")
time([[Config for bufdelete.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n‚\2\0\0\n\0\r\0\0236\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\0016\0\0\0'\2\4\0B\0\2\0026\1\0\0'\3\5\0B\1\2\0029\2\6\0\18\4\2\0009\2\a\2'\5\b\0009\6\t\0015\b\v\0005\t\n\0=\t\f\bB\6\2\0A\2\2\1K\0\1\0\rmap_char\1\0\0\1\0\1\btex\5\20on_confirm_done\17confirm_done\aon\nevent\"nvim-autopairs.completion.cmp\bcmp\1\0\2\vmap_cr\2\30enable_check_bracket_line\1\nsetup\19nvim-autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: dressing.nvim
time([[Config for dressing.nvim]], true)
try_loadstring("\27LJ\2\n¼\1\0\0\a\0\14\0\0176\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\v\0005\4\t\0005\5\a\0005\6\6\0=\6\b\5=\5\n\4=\4\f\3=\3\r\2B\0\2\1K\0\1\0\vselect\14telescope\1\0\0\18layout_config\1\0\0\16bottom_pane\1\0\0\1\0\1\vheight\4\0€€€ÿ\3\ninput\1\0\0\1\0\1\fenabled\1\nsetup\rdressing\frequire\0", "config", "dressing.nvim")
time([[Config for dressing.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n»\t\0\0\a\0=\0”\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\4\0'\4\5\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\6\0'\4\a\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\b\0'\3\t\0'\4\n\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\b\0'\3\v\0'\4\f\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\3\0'\4\r\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\14\0'\4\15\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\16\0'\4\17\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\3\0'\3\18\0'\4\19\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\b\0'\3\20\0'\4\21\0B\0\4\0016\0\0\0009\0\1\0009\0\2\0'\2\b\0'\3\22\0'\4\23\0B\0\4\0016\0\0\0009\0\24\0)\1,\1=\1\25\0006\0\26\0'\2\27\0B\0\2\0029\1\28\0005\3 \0005\4\30\0005\5\29\0=\5\31\4=\4!\3B\1\2\0016\1\0\0009\1\1\0019\1\2\1'\3\3\0'\4\"\0'\5#\0005\6$\0B\1\5\0016\1\0\0009\1\1\0019\1\2\1'\3\3\0'\4%\0'\5&\0005\6'\0B\1\5\0016\1\0\0009\1\1\0019\1\2\1'\3\3\0'\4(\0'\5)\0005\6*\0B\1\5\0019\1+\0005\3/\0005\4-\0005\5,\0=\5.\4=\0040\3B\1\2\0016\1\0\0009\1\1\0019\1\2\1'\3\3\0'\0041\0'\0052\0005\0063\0B\1\5\0016\1\0\0009\1\1\0019\1\2\1'\3\3\0'\0044\0'\0055\0005\0066\0B\1\5\0016\1\0\0009\1\1\0019\1\2\1'\3\3\0'\0047\0'\0058\0005\0069\0B\1\5\0016\1\0\0009\1\1\0019\1\2\1'\3\3\0'\4:\0'\5;\0005\6<\0B\1\5\1K\0\1\0\1\0\1\tdesc\26relative line numbers\29:set relativenumber!<CR>\15<leader>tn\1\0\1\tdesc\19spell checking\20:set spell!<CR>\15<leader>ts\1\0\1\tdesc\18line wrapping\19:set wrap!<CR>\15<leader>tr\1\0\1\tdesc\15whitespace\19:set list!<CR>\15<leader>tw\r<leader>\1\0\0\6t\1\0\0\1\0\1\tname\vtoggle\rregister\1\0\1\tdesc\tmake\14:make<CR>\14<leader>m\1\0\1\tdesc\25toggle location list\26<Plug>(qf_loc_toggle)\14<leader>l\1\0\1\tdesc\25toggle quickfix list\25<Plug>(qf_qf_toggle)\14<leader>q\fplugins\1\0\0\fpresets\1\0\0\1\0\3\17text_objects\1\fmotions\1\14operators\1\nsetup\14which-key\frequire\15timeoutlen\bopt\21:m '<-2<CR>gv=gv\6K\21:m '>+1<CR>gv=gv\6J\b#zz\6#\b*zz\6*\bNzz\6N\bnzz\b<gv\6<\b>gv\6>\6v\bGzz\6G\n<nop>\n<C-z>\6n\bset\vkeymap\bvim\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: license-to-vim
time([[Config for license-to-vim]], true)
try_loadstring("\27LJ\2\ns\0\0\2\0\6\0\t6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\0\0009\0\1\0'\1\5\0=\1\4\0K\0\1\0\28nimai.m.patel@gmail.com\18license_email\17Patel, Nimai\19license_author\6g\bvim\0", "config", "license-to-vim")
time([[Config for license-to-vim]], false)
-- Config for: impatient.nvim
time([[Config for impatient.nvim]], true)
try_loadstring("\27LJ\2\n)\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\14impatient\frequire\0", "config", "impatient.nvim")
time([[Config for impatient.nvim]], false)
-- Config for: nvim-highlight-colors
time([[Config for nvim-highlight-colors]], true)
try_loadstring("\27LJ\2\nm\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\2\vrender\15background\20enable_tailwind\2\nsetup\26nvim-highlight-colors\frequire\0", "config", "nvim-highlight-colors")
time([[Config for nvim-highlight-colors]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\nÉ\2\0\0\4\0\f\0\0156\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\frainbow\1\0\2\venable\2\18extended_mode\2\vindent\1\0\1\venable\2\14highlight\1\0\1\venable\2\21ensure_installed\1\0\0\1\25\0\0\6c\blua\fhaskell\tbash\ncmake\bcpp\bcss\tdart\tfish\ago\thtml\tjava\15javascript\tjson\njson5\blua\tllvm\tmake\bphp\6r\rsolidity\15typescript\tyaml\bvim\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: auto-save.nvim
time([[Config for auto-save.nvim]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\14auto-save\frequire\0", "config", "auto-save.nvim")
time([[Config for auto-save.nvim]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.api.nvim_create_user_command, 'DocsViewToggle', function(cmdargs)
          require('packer.load')({'nvim-docs-view'}, { cmd = 'DocsViewToggle', l1 = cmdargs.line1, l2 = cmdargs.line2, bang = cmdargs.bang, args = cmdargs.args, mods = cmdargs.mods }, _G.packer_plugins)
        end,
        {nargs = '*', range = true, bang = true, complete = function()
          require('packer.load')({'nvim-docs-view'}, {}, _G.packer_plugins)
          return vim.fn.getcompletion('DocsViewToggle ', 'cmdline')
      end})
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType vue ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "vue" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescript ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "typescript" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascript ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "javascript" }, _G.packer_plugins)]]
vim.cmd [[au FileType htmldjango ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "htmldjango" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType xml ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "xml" }, _G.packer_plugins)]]
vim.cmd [[au FileType javascriptreact ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "javascriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType typescriptreact ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "typescriptreact" }, _G.packer_plugins)]]
vim.cmd [[au FileType svelte ++once lua require("packer.load")({'nvim-ts-autotag'}, { ft = "svelte" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
