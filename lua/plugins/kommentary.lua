local map=vim.api.nvim_set_keymap
local g=vim.g

g.kommentary_create_default_mappings = false

map("n", "<leader>cc", "<Plug>kommentary_line_default", {})
map("n", "<leader>gc", "<Plug>kommentary_motion_default", {})
map("x", "<leader>gc", "<Plug>kommentary_visual_default", {})
map("n", "<leader>cic", "<Plug>kommentary_line_increase", {})
map("n", "<leader>ci", "<Plug>kommentary_motion_increase", {})
map("x", "<leader>ci", "<Plug>kommentary_visual_increase", {})
map("n", "<leader>cdc", "<Plug>kommentary_line_decrease", {})
map("n", "<leader>cd", "<Plug>kommentary_motion_decrease", {})
map("x", "<leader>cd", "<Plug>kommentary_visual_decrease", {})

--[[ require('kommentary.config').configure_language("default", {
    prefer_single_line_comments = true,
})

require('kommentary.config').configure_language({"c", "rust"}, {
    prefer_single_line_comments = true,
}) ]]--

