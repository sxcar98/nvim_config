local nvim_lsp = require "lspconfig"
local nvim_lspconfig = require("packers/nvim-lspconfig")

nvim_lsp.tsserver.setup {
  on_attach = nvim_lspconfig.on_attach,
  capabilities = nvim_lspconfig.capabilities,
  flags = nvim_lspconfig.flags
}
