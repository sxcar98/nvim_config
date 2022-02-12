local present, nvimtree = pcall(require, "nvim-tree")

if not present then
   return
end

local g = vim.g

g.vim_mac_dictionary_use_format = 1
g.vim_mac_dictionary_use_app = false

local default = {
   filters = {
      dotfiles = false,
   },
   disable_netrw = true,
   hijack_netrw = true,
   ignore_ft_on_setup = { "dashboard" },
   auto_close = false,
   open_on_tab = false,
   hijack_cursor = true,
   update_cwd = true,
   update_focused_file = {
      enable = true,
      update_cwd = false,
   },
   view = {
      allow_resize = true,
      side = "left",
      width = 25,
      hide_root_folder = true,
   },
   git = {
      enable = false,
      ignore = false,
   },
}

local M = {}

M.setup = function()
   nvimtree.setup(default)
end

return M
