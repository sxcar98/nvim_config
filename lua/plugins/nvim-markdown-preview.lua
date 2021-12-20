local map = vim.api.nvim_set_keymap
local g = vim.g
local opts = {noremap = true, silent = false}
local cmd = vim.cmd

local mode = vim.fn.system("dark-notify --exit")

if (mode == "light") then
  g.nvim_markdown_preview_theme = "github"
else
  g.nvim_markdown_preview_theme = "solarized-dark"
end

map("n", "<F5>", ":MarkdownPreview<CR>", opts)
