local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = false}
local g = vim.g

-- map('n', 'wd', ':MacDictWord<CR>', opts)
-- map('n', 'wq', ':MacDictQuery<CR>', opts)
map("n", "wd", ":MacDictPopup<CR>", opts)

g.vim_mac_dictionary_use_format = 1
g.vim_mac_dictionary_use_app = false
