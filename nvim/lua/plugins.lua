-- ~/.config/nvim/lua/plugins.lua
-- Package management via vim.pack (built-in, Neovim 0.12+)
-- First run: packages are cloned automatically on startup.
-- Update all plugins: call vim.pack.update() (or :lua vim.pack.update())

local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add({
  -- ── Colorscheme ────────────────────────────────────────────────────
  gh('danilo-augusto/vim-afterglow'),

  -- ── File browser ───────────────────────────────────────────────────
  gh('vifm/vifm.vim'),

  -- ── Fuzzy finder ───────────────────────────────────────────────────
  -- NOTE: fzf binary must also be present: `brew install fzf`
  gh('junegunn/fzf'),
  gh('junegunn/fzf.vim'),

  -- ── Syntax ─────────────────────────────────────────────────────────
  gh('lepture/vim-jinja'),         -- Nunjucks / Jinja2

  -- ── Editing helpers ────────────────────────────────────────────────
  gh('mg979/vim-visual-multi'),    -- multi-cursor  (<C-n>)
  gh('tpope/vim-surround'),        -- surround motions (cs, ds, ys)

  -- ── REMOVED (built-in replacements) ────────────────────────────────
  -- ms-jpq/coq_nvim + coq.artifacts  → vim.lsp.completion (built-in)
  -- preservim/nerdcommenter           → gcc / gc  (built-in since 0.10)
  -- neoclide/coc.nvim and friends     → vim.lsp.*  (built-in)
})
