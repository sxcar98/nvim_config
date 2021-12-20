local nvim_lsp = require "lspconfig"
local nvim_lspconfig = require("plugins/nvim-lspconfig")
local g = vim.g

g.tex_flavor = "latex"

nvim_lsp.texlab.setup {
  on_attach = nvim_lspconfig.on_attach,
  capabilities = nvim_lspconfig.capabilities,
  flags = nvim_lspconfig.flags
}
