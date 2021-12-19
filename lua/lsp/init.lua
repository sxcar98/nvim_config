local files = {
  'lsp/tsserver',
  'lsp/clangd',
  'lsp/pyright',
  'lsp/lua',
  'lsp/html',
}
for _, file in ipairs(files) do
  pcall(require, file)
end
