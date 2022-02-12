local M = {}

M.setup_lsp = function(attach, capabilities)
  local lspconfig = require "lspconfig"

  -- lspservers with default config
  local servers = {
    "html",
    "texlab",
    "clangd",
    "sumneko_lua",
    "grammarly",
    "pyright",
    "tsserver"
  }

  for _, lsp in ipairs(servers) do
    local conf = nil
    local _ok, configure = pcall(require, "lsp." .. lsp)
    if _ok then
      conf = configure.settings
    end
    lspconfig[lsp].setup {
      on_attach = attach,
      capabilities = capabilities,
      flags = {
        debounce_text_changes = 150
      },
      settings = conf
    }
  end
end

return M
