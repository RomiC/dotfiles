-- ~/.config/nvim/lua/options.lua
local opt = vim.opt

-- ── Indentation ──────────────────────────────────────────────────────────────
opt.shiftwidth  = 2
opt.tabstop     = 2
opt.softtabstop = 2
opt.smartindent = true
opt.autoindent  = true
opt.expandtab   = true
opt.smarttab    = false

-- ── Files ─────────────────────────────────────────────────────────────────────
opt.swapfile   = false
opt.autoread   = true
opt.updatetime = 1000  -- ms idle before CursorHold fires (used for auto-reload)

-- ── UI ────────────────────────────────────────────────────────────────────────
opt.number         = true
opt.relativenumber = true
opt.cursorline     = true   -- highlight current line (required for CursorLineNr)
opt.mouse          = 'a'
opt.clipboard      = 'unnamedplus'
opt.showcmd        = false
opt.laststatus     = 2
opt.signcolumn     = 'yes'        -- always show, prevents layout shift on diagnostics
opt.termguicolors  = true

-- Cursor: block in normal, bar in insert
opt.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'

-- ── Search ────────────────────────────────────────────────────────────────────
opt.ignorecase = true
opt.smartcase  = true

-- ── Windows ───────────────────────────────────────────────────────────────────
opt.splitbelow = true
opt.splitright = true

-- ── Buffers ───────────────────────────────────────────────────────────────────
opt.hidden = true

-- ── Folding ───────────────────────────────────────────────────────────────────
opt.foldmethod = 'indent'
opt.foldenable = false

-- ── Completion ────────────────────────────────────────────────────────────────
-- Required for built-in LSP completion popup
opt.completeopt = { 'menuone', 'noinsert', 'popup', 'fuzzy' }

-- ── Disable built-in file manager (using neo-tree instead) ────────────────────
vim.g.loaded_netrwPlugin = 1

-- ── Colorscheme ───────────────────────────────────────────────────────────────
vim.opt.background = 'dark'
vim.g.afterglow_inherit_background = 1
vim.cmd.colorscheme('afterglow')
vim.api.nvim_set_hl(0, 'Normal',       { bg = 'NONE', ctermbg = 'NONE' })
vim.api.nvim_set_hl(0, 'CursorLine',   { bg = 'NONE', ctermbg = 'NONE' })  -- no full-line highlight
vim.api.nvim_set_hl(0, 'LineNr',       { bg = 'NONE', ctermbg = 'NONE', fg = '#606367' })
vim.api.nvim_set_hl(0, 'CursorLineNr', { bg = 'NONE', ctermbg = 'NONE', fg = '#f0c674', bold = true })
vim.api.nvim_set_hl(0, 'SignColumn',   { bg = 'NONE', ctermbg = 'NONE' })
