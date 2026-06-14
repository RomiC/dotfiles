-- ~/.config/nvim/lua/explorer.lua
-- neo-tree.nvim — sidebar file explorer

require("neo-tree").setup({
  close_if_last_window = true,
  default_source = "filesystem",
  sources = { "filesystem", "git_status", "buffers" },

  -- Highlight groups matching the Afterglow (Monokai) colorscheme
  highlights = {
    ["NeoTreeNormal"] = { bg = "NONE", fg = "#d6d6d6" },
    ["NeoTreeNormalNC"] = { bg = "NONE", fg = "#d6d6d6" },
    ["NeoTreeCursorLine"] = { bg = "#393939" },
    ["NeoTreeSignColumn"] = { bg = "NONE" },
    ["NeoTreeWinSeparator"] = { bg = "NONE", fg = "#4d5057" },
    ["NeoTreeIndentMarker"] = { fg = "#4d5057" },
    ["NeoTreeExpander"] = { fg = "#4d5057" },
    ["NeoTreeRootName"] = { fg = "#e5b567", bold = true },
    ["NeoTreeTitleBar"] = { bg = "#4d5057", fg = "#e5b567" },
    ["NeoTreeDirectoryName"] = { fg = "#6c99bb" },
    ["NeoTreeDirectoryIcon"] = { fg = "#6c99bb" },
    ["NeoTreeFileName"] = { fg = "#d6d6d6" },
    ["NeoTreeFileNameOpened"] = { fg = "#d6d6d6", bold = true },
    ["NeoTreeFileIcon"] = { fg = "#d6d6d6" },
    ["NeoTreeDotfile"] = { fg = "#797979" },
    ["NeoTreeHiddenByName"] = { fg = "#797979" },
    ["NeoTreeIgnored"] = { fg = "#797979" },
    ["NeoTreeDimText"] = { fg = "#606367" },
    ["NeoTreeFadeText1"] = { fg = "#606367" },
    ["NeoTreeFadeText2"] = { fg = "#4d5057" },
    ["NeoTreeMessage"] = { fg = "#797979", italic = true },
    ["NeoTreeSymbolicLinkTarget"] = { fg = "#9e86c8" },
    ["NeoTreeModified"] = { fg = "#e87d3e" },
    ["NeoTreeFilterTerm"] = { fg = "#e5b567", bold = true },
    ["NeoTreeSelected"] = { bg = "#5a647e" },
    ["NeoTreeGitAdded"] = { fg = "#b4c973" },
    ["NeoTreeGitDeleted"] = { fg = "#ac4142" },
    ["NeoTreeGitModified"] = { fg = "#e5b567" },
    ["NeoTreeGitStaged"] = { fg = "#b4c973" },
    ["NeoTreeGitUntracked"] = { fg = "#797979", italic = true },
    ["NeoTreeGitConflict"] = { fg = "#e87d3e", bold = true },
    ["NeoTreeGitIgnored"] = { fg = "#797979" },
    ["NeoTreeGitRenamed"] = { fg = "#e5b567" },
    ["NeoTreeGitUnstaged"] = { fg = "#e87d3e", bold = true },
    ["NeoTreeStatusLine"] = { bg = "#4d5057", fg = "#e5b567", reverse = true },
    ["NeoTreeStatusLineNC"] = { bg = "#4d5057", fg = "#797979", reverse = true },
    ["NeoTreeFloatTitle"] = { bg = "#4d5057", fg = "#e5b567" },
    ["NeoTreeFloatBorder"] = { fg = "#4d5057" },
    ["NeoTreeFloatNormal"] = { bg = "NONE" },
  },

  window = {
    position = "left",       -- sidebar on the left
    width = 35,
    mappings = {
      -- h = toggle hidden files, l = expand folder / open file
      -- j/k work as standard vim motions by default — no remap needed
      ["h"] = "toggle_hidden",
      ["l"] = "open",
    },
  },

  filesystem = {
    filtered_items = {
      hide_dotfiles = false,      -- show .dotfiles (toggle via h)
      hide_gitignored = false,
      never_show = { ".DS_Store" },
    },
    follow_current_file = {
      enabled = true,
    },
    use_libuv_file_watcher = true,
    -- open files in the last-focused window (not inside neo-tree)
    window = {
      mappings = {
        ["<CR>"] = "open",
      },
    },
  },

  git_status = {
    window = {
      position = "left",
    },
  },
})
