-- ~/.config/nvim/lua/statusline.lua
-- Custom statusline — no external plugin required.

local mode_map = {
  n   = 'N ',
  v   = 'V ',
  V   = 'V·Line ',
  [''] = 'V·Block ',
  i   = 'I ',
  r   = 'R ',
  Rv  = 'V·Replace ',
  c   = 'C ',
  t   = 'T ',
}

-- ── Highlight groups ─────────────────────────────────────────────────────────
local hl_normal = { reverse = true, fg = '#afd787', bg = '#4d5057', ctermfg = 150, ctermbg = 59 }
local hl_insert = { fg = '#a54242', bg = '#f9e7c4' }

vim.api.nvim_set_hl(0, 'User1', hl_normal)
vim.api.nvim_set_hl(0, 'User2', { bold = true, fg = '#ff0000', bg = '#4d5057', ctermfg = 9, ctermbg = 59 })

-- Switch User1 colour when entering / leaving Insert mode
local stl_aug = vim.api.nvim_create_augroup('user_statusline', { clear = true })

vim.api.nvim_create_autocmd('InsertEnter', {
  group    = stl_aug,
  callback = function() vim.api.nvim_set_hl(0, 'User1', hl_insert) end,
})
vim.api.nvim_create_autocmd('InsertLeave', {
  group    = stl_aug,
  callback = function() vim.api.nvim_set_hl(0, 'User1', hl_normal) end,
})

-- ── Statusline render function (called via v:lua) ────────────────────────────
function _G.pw_statusline()
  local m   = mode_map[vim.fn.mode()] or vim.fn.mode()
  local mod = vim.bo.modified and ' *' or ''
  local ft  = vim.bo.filetype ~= '' and ('[' .. vim.bo.filetype .. ']') or ''
  local pos = ('%d:%d/%d'):format(vim.fn.line('.'), vim.fn.col('.'), vim.fn.line('$'))
  -- %w = [Preview] flag,  %f = relative file path
  return ('%%1* %s%%* %%w %%f%%2*%s%%*%%=%s %s '):format(m, mod, pos, ft)
end

vim.opt.statusline = '%!v:lua.pw_statusline()'

-- Re-apply per-window on every focus change
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
  group    = stl_aug,
  callback = function() vim.opt_local.statusline = '%!v:lua.pw_statusline()' end,
})
