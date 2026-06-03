-- ~/.config/nvim/lua/lsp.lua
-- Built-in LSP (Neovim 0.11+) — no nvim-lspconfig needed.
--
-- Add more servers below following the same pattern:
--   vim.lsp.config('<name>', { cmd = {…}, filetypes = {…}, root_markers = {…} })
--   vim.lsp.enable('<name>')
--
-- Find available server binaries: mason.nvim or manual installs via npm/pip/brew.

-- ── HTML ─────────────────────────────────────────────────────────────────────
-- Install: npm i -g vscode-langservers-extracted
vim.lsp.config('html', {
  cmd        = { 'vscode-html-language-server', '--stdio' },
  filetypes  = { 'html', 'htmldjango', 'jinja' },
  root_markers = { '.git' },
})
vim.lsp.enable('html')

-- ── CSS / SCSS / LESS ────────────────────────────────────────────────────────
-- Install: npm i -g vscode-langservers-extracted
vim.lsp.config('cssls', {
  cmd        = { 'vscode-css-language-server', '--stdio' },
  filetypes  = { 'css', 'scss', 'less' },
  root_markers = { '.git', 'package.json' },
})
vim.lsp.enable('cssls')

-- ── TypeScript / JavaScript ──────────────────────────────────────────────────
-- Install: npm i -g typescript typescript-language-server
vim.lsp.config('ts_ls', {
  cmd        = { 'typescript-language-server', '--stdio' },
  filetypes  = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  root_markers = { 'package.json', 'tsconfig.json', '.git' },
  init_options = {
    hostInfo = 'neovim',
    preferences = {
      -- tell tsserver to treat .cjs/.mjs as JS modules
      allowJs = true,
    },
  },
  settings = {
    typescript = { preferences = { allowJs = true } },
    javascript = { preferences = { allowJs = true } },
  },
})
vim.lsp.enable('ts_ls')

-- ── On attach: keymaps + built-in completion ─────────────────────────────────
vim.api.nvim_create_autocmd('LspAttach', {
  group    = vim.api.nvim_create_augroup('user_lsp', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufmap = function(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
    end

    -- Enable built-in LSP completion for this buffer
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })
    end

    -- Navigation
    bufmap('n', 'gd',        vim.lsp.buf.definition,      'Go to definition')
    bufmap('n', 'gD',        vim.lsp.buf.declaration,     'Go to declaration')
    bufmap('n', 'gr',        vim.lsp.buf.references,      'References')
    bufmap('n', 'gi',        vim.lsp.buf.implementation,  'Go to implementation')
    bufmap('n', 'K',         vim.lsp.buf.hover,           'Hover docs')
    bufmap('n', '<leader>k', vim.lsp.buf.signature_help,  'Signature help')

    -- Refactoring
    bufmap('n', '<leader>rn', vim.lsp.buf.rename,          'Rename symbol')
    bufmap('n', '<leader>ca', vim.lsp.buf.code_action,     'Code action')
    bufmap('n', '==',         function() vim.lsp.buf.format({ async = true }) end, 'Format')
    bufmap('v', '==',         function() vim.lsp.buf.format({ async = true }) end, 'Format selection')

    -- Diagnostics
    bufmap('n', '[d', vim.diagnostic.goto_prev, 'Prev diagnostic')
    bufmap('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')
    bufmap('n', '<leader>e', vim.diagnostic.open_float, 'Diagnostic float')
  end,
})

-- ── Diagnostic display ───────────────────────────────────────────────────────
vim.diagnostic.config({
  virtual_text   = true,
  signs          = true,
  underline      = true,
  update_in_insert = false,
  severity_sort  = true,
})
