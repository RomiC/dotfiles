-- ~/.config/nvim/init.lua
-- Neovim 0.12 config — Lua migration

require('plugins')     -- vim.pack declarations (must be first)
require('options')     -- vim.opt settings
require('autocmds')    -- autocommands
require('statusline')  -- custom statusline
require('lsp')         -- built-in LSP + completion
require('explorer')    -- sidebar file explorer
require('keymaps')     -- keybindings (last — plugins are loaded by now)
