local present, nvimtree = pcall(require, "nvim-tree")

if not present then
  return
end

local g = vim.g

g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
g.nvim_tree_git_hl = 0
g.nvim_tree_highlight_opened_files = 0
g.nvim_tree_indent_markers = 1
g.nvim_tree_disable_window_picker = 1
g.nvim_tree_quit_on_open = 0 -- closes tree when file's opened
g.nvim_tree_root_folder_modifier = table.concat {":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??"}

g.nvim_tree_window_picker_exclude = {
  filetype = {"notify", "packer", "qf"},
  buftype = {"terminal"}
}

g.nvim_tree_show_icons = {
  folders = 1,
  files = 1,
  git = 1
}

g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    deleted = "",
    ignored = "◌",
    renamed = "➜",
    staged = "✓",
    unmerged = "",
    unstaged = "✗",
    untracked = "★"
  },
  folder = {
    default = "",
    empty = "",
    empty_open = "",
    open = "",
    symlink = "",
    symlink_open = ""
  }
}

local default = {
  filters = {
    dotfiles = true,
    custom = {".git", "node_modules", ".cache", ".bin"}
  },
  disable_netrw = true,
  hijack_netrw = true,
  ignore_ft_on_setup = {"dashboard"},
  auto_close = false,
  open_on_tab = false,
  hijack_cursor = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = false
  },
  view = {
    allow_resize = true,
    side = "left",
    width = 25,
    hide_root_folder = true
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500
  }
}

local M = {}

M.setup = function()
  nvimtree.setup(default)
end

return M
