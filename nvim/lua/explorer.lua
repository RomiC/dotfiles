-- ~/.config/nvim/lua/explorer.lua
-- neo-tree.nvim — sidebar file explorer

-- Palette aligned with the Yazi Afterglow flavor (yazi/flavors/afterglow.yazi/flavor.toml).
-- neo-tree no longer reads a `highlights` setup option; it uses `highlight default`,
-- so groups defined here before setup() are respected.
local palette = {
  NeoTreeNormal            = { bg = "NONE", fg = "#d6d6d6" },
  NeoTreeNormalNC          = { bg = "NONE", fg = "#d6d6d6" },
  NeoTreeCursorLine        = { bg = "#343434" },
  NeoTreeSignColumn        = { bg = "NONE" },
  NeoTreeWinSeparator      = { bg = "NONE", fg = "#444444" },
  NeoTreeIndentMarker      = { fg = "#444444" },
  NeoTreeExpander          = { fg = "#444444" },
  NeoTreeRootName          = { fg = "#6c99bb", bold = true },
  NeoTreeTitleBar          = { bg = "#444444", fg = "#ffc66d" },
  -- Folder marked by orange icon only; name stays neutral like regular files
  NeoTreeDirectoryName     = { fg = "#d6d6d6" },
  NeoTreeDirectoryIcon     = { fg = "#ffc66d" },
  NeoTreeFileName          = { fg = "#d6d6d6" },
  NeoTreeFileNameOpened    = { fg = "#d6d6d6", bold = true },
  NeoTreeFileIcon          = { fg = "#d6d6d6" },
  NeoTreeDotfile           = { fg = "#979797" },
  NeoTreeHiddenByName      = { fg = "#979797" },
  NeoTreeIgnored           = { fg = "#979797" },
  NeoTreeDimText           = { fg = "#5a5a5a" },
  NeoTreeFadeText1         = { fg = "#5a5a5a" },
  NeoTreeFadeText2         = { fg = "#444444" },
  NeoTreeMessage           = { fg = "#979797", italic = true },
  NeoTreeSymbolicLinkTarget = { fg = "#7fb9cf", italic = true },
  NeoTreeModified          = { fg = "#ffc66d" },
  NeoTreeFilterTerm        = { fg = "#ffc66d", bold = true },
  NeoTreeSelected          = { bg = "#5a647e" },
  NeoTreeGitAdded          = { fg = "#b4c973" },
  NeoTreeGitDeleted        = { fg = "#c45837" },
  NeoTreeGitModified       = { fg = "#ffc66d" },
  NeoTreeGitStaged         = { fg = "#b4c973" },
  NeoTreeGitUntracked      = { fg = "#979797", italic = true },
  NeoTreeGitConflict       = { fg = "#c45837", bold = true },
  NeoTreeGitIgnored        = { fg = "#979797" },
  NeoTreeGitRenamed        = { fg = "#ffc66d" },
  NeoTreeGitUnstaged       = { fg = "#ffc66d", bold = true },
  NeoTreeStatusLine        = { bg = "#444444", fg = "#ffc66d", reverse = true },
  NeoTreeStatusLineNC      = { bg = "#444444", fg = "#979797", reverse = true },
  NeoTreeFloatTitle        = { bg = "#444444", fg = "#ffc66d" },
  NeoTreeFloatBorder       = { fg = "#5a647e" },
  NeoTreeFloatNormal       = { bg = "NONE" },
}
local apply_palette = function()
  for group, spec in pairs(palette) do
    vim.api.nvim_set_hl(0, group, spec)
  end
end
apply_palette()
-- Re-apply after any colorscheme switch (:colorscheme wipes custom groups)
vim.api.nvim_create_autocmd("ColorScheme", { callback = apply_palette })

require("neo-tree").setup({
  close_if_last_window = true,
  default_source = "filesystem",
  sources = { "filesystem", "git_status", "buffers" },

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
      enabled = false,    -- don't track buffer changes / change root
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

-- Open neo-tree on startup only when invoked with no arguments or a directory
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Open neo-tree on startup when no file argument is passed",
  nested = true,
  callback = function()
    -- Don't open neo-tree if any argument is a file path
    for _, arg in ipairs(vim.fn.argv()) do
      -- Skip special directory cases
      if arg == "." or arg == ".." then
        -- continue (these are directories)
      elseif vim.fn.isdirectory(arg) == 1 then
        -- continue (existing directory)
      elseif vim.fn.filereadable(arg) == 1 then
        -- Existing file — don't open neo-tree
        return
      elseif arg:match("%.[a-zA-Z0-9]+$") then
        -- Has a file extension (like .md, .lua, .go) — assume it's a file, don't open
        return
      end
    end
    -- Defer to let the UI finish rendering first
    vim.defer_fn(function()
      require("neo-tree.command").execute({ toggle = false, source = "filesystem" })
    end, 10)
  end,
})
