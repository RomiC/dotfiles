-- ~/.config/nvim/lua/fuzzy.lua
-- fzf-lua configuration

require("fzf-lua").setup({
  fzf = {
    bin = "fzf",
  },
  grep = {
    rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden",
  },
  winopts = {
    -- Disable window title to avoid Neovim 0.12 conflicts
    title = false,
  },
})
