local files = {
  'plugins/dark-notify',
  'plugins/telescope',
  'plugins/lualine',
  'plugins/bufferline',
  'plugins/vista',
  'plugins/nvim-tree',
  'plugins/indent-blankline',
  'plugins/nvim-treesitter',
  'plugins/nvim-ts-rainbow',
  'plugins/nvim-autopairs',
  'plugins/kommentary',
  'plugins/nvim-lspconfig',
  'plugins/luasnip',
  'plugins/nvim-cmp',
  'plugins/vim-mac-dictionary',
  'plugins/gitsigns',
}
for _, file in ipairs(files) do
  pcall(require,file)
end
