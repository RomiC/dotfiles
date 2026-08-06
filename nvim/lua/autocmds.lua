-- ~/.config/nvim/lua/autocmds.lua
local augroup  = vim.api.nvim_create_augroup
local autocmd  = vim.api.nvim_create_autocmd

-- ── Auto-reload buffers on disk change (hotreload.nvim) ─────────────────────
-- Uses native file system watchers (FSEvents) instead of CursorHold polling
require('hotreload').setup({
  silent = true,   -- no notifications on reload
})

-- ── Terminal ──────────────────────────────────────────────────────────────────
-- Hide relative numbers inside terminal buffers
autocmd('TermOpen', {
  pattern  = '*',
  callback = function() vim.opt_local.relativenumber = false end,
})

-- Auto-enter insert mode when focusing a terminal window
autocmd('BufEnter', {
  pattern  = 'term://*',
  callback = function() vim.cmd('startinsert') end,
})

-- ── Yank highlight ────────────────────────────────────────────────────────────
autocmd('TextYankPost', {
  group    = augroup('highlight_yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 700 })
  end,
})

-- ── macOS: switch to US layout on leaving Insert mode ────────────────────────
-- Requires `im-select` to be installed: brew install im-select
autocmd('InsertLeave', {
  callback = function()
    vim.fn.system('im-select com.apple.keylayout.US')
  end,
})
