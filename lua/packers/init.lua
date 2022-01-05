local files = {
  "packers/dark-notify",
  "packers/telescope",
  "packers/lualine",
  "packers/bufferline",
  "packers/alpha-nvim",
  "packers/vista",
  "packers/nvim-tree",
  "packers/indent-blankline",
  "packers/nvim-treesitter",
  "packers/nvim-ts-rainbow",
  "packers/nvim-autopairs",
  "packers/nvim-ts-autotag",
  "packers/kommentary",
  "packers/trim",
  "packers/formatter",
  "packers/nvim-lspconfig",
  "packers/luasnip",
  "packers/nvim-cmp",
  "packers/vim-mac-dictionary",
  "packers/gitsigns",
  "packers/nvim-markdown-preview",
  "packers/nvim-startup"
}

for _, file in ipairs(files) do
  pcall(require, file)
end
