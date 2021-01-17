local function map(mode, input, output)
    vim.api.nvim_set_keymap(mode, input, output, {})
end

local function noremap(mode, input, output)
    vim.api.nvim_set_keymap(mode, input, output, { noremap = true })
end

function nnoremap(input, output)
    noremap('n', input, output)
end

function inoremap(input, output)
    noremap('i', input, output)
end

function vnoremap(input, output)
    noremap('v', input, output)
end

function tnoremap(input, output)
    noremap('t', input, output)
end

function nmap(input, output)
	map('n', input, output)
end

function imap(input, output)
	map('i', input, output)
end

function vmap(input, output)
	map('v', input, output)
end

function tmap(input, output)
	map('t', input, output)
end

local globalListenerName = 'globallistenername'
local autocmdhandlers = {}

_G[globalListenerName] = function (name)
  autocmdhandlers[name]()
end

function AddEventListener (name, events, cb)
    autocmdhandlers[name] = cb
    vim.cmd('augroup ' .. name)
    vim.cmd('autocmd!')
    for _, v in ipairs(events) do
        local cmd = 'lua ' .. globalListenerName .. '("' .. name ..'")'
        vim.cmd('au ' .. v .. ' ' .. cmd)
    end
    vim.cmd('augroup end')
end

function RemoveEventListener (name)
    vim.cmd('augroup ' .. name)
    vim.cmd('autocmd!')
    vim.cmd('augroup end')
    autocmdhandlers[name] = nil
end
