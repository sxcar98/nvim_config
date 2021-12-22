local files = {
  "lsp/tsserver",
  "lsp/clangd",
  "lsp/pyright",
  "lsp/lua",
  "lsp/html",
  "lsp/latex",
  "lsp/markdown"
}
for _, file in ipairs(files) do
  pcall(require, file)
end
