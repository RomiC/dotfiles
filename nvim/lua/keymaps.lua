-- ~/.config/nvim/lua/keymaps.lua
local map = vim.keymap.set

vim.g.mapleader = ' '

-- ── Session ───────────────────────────────────────────────────────────────────
map('n', 'ZA',          '<cmd>qa!<CR>',  { silent = true, desc = 'Quit all' })
map('n', '<leader>q',   '<cmd>qa!<CR>',  { silent = true, desc = 'Quit all' })
map('n', 'ZS',          '<cmd>wa<CR>',   { silent = true, desc = 'Save all' })
map('n', '<leader>s',   '<cmd>wa<CR>',   { silent = true, desc = 'Save all' })
map('i', '<C-s>',  '<Esc><cmd>wa<CR>',   { silent = true, desc = 'Save all' })

-- ── neo-tree sidebar ──────────────────────────────────────────────────────────
-- Toggle: <space>e
map('n', '<leader>e', '<cmd>Neotree toggle<CR>', { silent = true, desc = 'Toggle neo-tree' })
-- Focus / reveal current file: <space>g<space>r
map('n', '<leader>g<leader>r', '<cmd>Neotree reveal<CR>', { silent = true, desc = 'Reveal current file in neo-tree' })

-- ── Window splits ─────────────────────────────────────────────────────────────
map('n', '<leader>]', '<cmd>vsplit<CR>', { silent = true, desc = 'Split vertical' })

-- Navigate between windows (normal / terminal / insert)
local wins = { k = 'k', j = 'j', l = 'l', h = 'h' }
for key, dir in pairs(wins) do
  map('n', '<leader>' .. key,  '<C-w>' .. dir,              { silent = true })
  map('t', '<C-w>' .. key,    '<C-\\><C-N><C-w>' .. dir,    { silent = true })
  map('i', '<C-w>' .. key,    '<Esc><C-w>' .. dir,          { silent = true })
end

-- ── Tabs ──────────────────────────────────────────────────────────────────────
map('n', '<leader>n', '<cmd>tabnew<CR>',  { silent = true, desc = 'New tab' })
map('n', '<leader>L', '<cmd>tabn<CR>',    { silent = true, desc = 'Next tab' })
map('n', '<leader>H', '<cmd>tabp<CR>',    { silent = true, desc = 'Prev tab' })
map('n', '<leader>W', '<C-w>q',           { silent = true, desc = 'Close window' })
map('n', '<leader>w', '<cmd>confirm bdelete<CR>', { silent = true, desc = 'Close buffer' })

-- ── Quickfix ──────────────────────────────────────────────────────────────────
map('n', '<leader><leader>j', '<cmd>cnext<CR>', { silent = true, desc = 'Quickfix next' })
map('n', '<leader><leader>k', '<cmd>cprev<CR>', { silent = true, desc = 'Quickfix prev' })
-- NOTE: original had <leader><leader>j mapped twice (both to cnext) — fixed above.

-- ── FZF: buffers / windows / files / search ──────────────────────────────────
map('n', '<C-b>',      '<cmd>Buffers<CR>', { silent = true, desc = 'FZF buffers' })
map('t', '<C-b>',   '<C-\\><C-N><cmd>Buffers<CR>', { silent = true })
map('n', '<leader>b',  '<cmd>Buffers<CR>', { silent = true, desc = 'FZF buffers' })
map('n', '<leader>r',  '<cmd>Windows<CR>', { silent = true, desc = 'FZF windows' })
map('n', '<C-p>',      '<cmd>Files<CR>',   { silent = true, desc = 'FZF files' })
map('n', '<leader>p',  '<cmd>Files<CR>',   { silent = true, desc = 'FZF files' })
map('n', '<leader>f',  '<cmd>Rg<CR>',      { silent = true, desc = 'FZF ripgrep' })

-- FZF split actions
vim.g.fzf_action = {
  ['ctrl-t'] = 'tab split',
  ['ctrl-_'] = 'split',
  ['ctrl-]'] = 'vsplit',
}

-- ── Indentation ───────────────────────────────────────────────────────────────
map('n', '<Tab>',   '>>',  { silent = true, desc = 'Indent +' })
map('v', '<Tab>',   '>gv', { silent = true, desc = 'Indent +' })
map('n', '<S-Tab>', '<<',  { silent = true, desc = 'Indent -' })
map('v', '<S-Tab>', '<gv', { silent = true, desc = 'Indent -' })
-- Confirm selected completion item; plain Tab otherwise
map('i', '<Tab>', function()
  return vim.fn.pumvisible() == 1 and vim.fn.complete_info({ 'selected' }).selected ~= -1
    and '<C-y>' or '<Tab>'
end, { expr = true, silent = true, desc = 'Confirm completion / Tab' })

-- ── Commenting (built-in gc / gcc, replaces NERDCommenter) ───────────────────
map('n', '<leader>/', 'gcc', { remap = true,  desc = 'Toggle comment line' })
map('v', '<leader>/', 'gc',  { remap = true,  desc = 'Toggle comment' })

-- ── Multi-cursor (vim-visual-multi) ──────────────────────────────────────────
vim.g.VM_leader = '<leader><leader>'
vim.g.VM_maps = {
  ['Find Under']         = '<C-n>',
  ['Find Subword Under'] = '<C-n>',
  ['Select All']         = '<C-S-n>',
  ['Undo']               = 'u',
  ['Redo']               = '<C-r>',
}

-- ── Completion navigation ─────────────────────────────────────────────────────
-- Navigate popup with C-j / C-k; confirm with C-y (Neovim standard).
map('i', '<C-j>', function()
  return vim.fn.pumvisible() == 1 and '<C-n>' or '<C-j>'
end, { expr = true, silent = true, desc = 'Next completion item' })

map('i', '<C-k>', function()
  return vim.fn.pumvisible() == 1 and '<C-p>' or '<C-k>'
end, { expr = true, silent = true, desc = 'Prev completion item' })

-- ── Completion ───────────────────────────────────────────────────────────────
map('i', '<M-Space>', function() vim.lsp.completion.get() end, { desc = 'Trigger LSP completion' })

-- ── Input language (macOS) ────────────────────────────────────────────────────
-- Switch to US layout when leaving insert mode (handled in autocmds.lua via im-select).
-- Toggle input source manually inside Insert:
map('i', '<C-space>', '<C-^>', { silent = true, desc = 'Toggle input source' })

-- ── Terminal ──────────────────────────────────────────────────────────────────
map('n', 'gs', '<cmd>80vsplit term://zsh<CR>',  { silent = true, desc = 'Terminal right' })
map('n', 'gS', '<cmd>25split  term://zsh<CR>',  { silent = true, desc = 'Terminal below' })

-- ── Miscellaneous ─────────────────────────────────────────────────────────────
-- Reload config: purge all user Lua modules from cache, then re-source init.lua
map('n', '<leader>u', function()
  for mod, _ in pairs(package.loaded) do
    -- remove every module that lives under the nvim config dir
    if mod:match('^plugins') or mod:match('^options') or mod:match('^autocmds')
      or mod:match('^statusline') or mod:match('^lsp') or mod:match('^keymaps')
      or mod:match('^explorer') then
      package.loaded[mod] = nil
    end
  end
  vim.cmd('source ' .. vim.fn.stdpath('config') .. '/init.lua')
  vim.notify('Config reloaded', vim.log.levels.INFO)
end, { desc = 'Reload config' })
map('n', '<F1>',       '<nop>',                   { desc = 'Disable help key' })
map('n', 'q',          '<nop>',                   { desc = 'Disable macro recording' })
