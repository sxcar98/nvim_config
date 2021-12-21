local nvim_lsp = require "lspconfig"
local nvim_lspconfig = require("plugins/nvim-lspconfig")
local g = vim.g
local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = false}

g.tex_flavor = "latex"

nvim_lsp.texlab.setup {
  on_attach = nvim_lspconfig.on_attach,
  capabilities = nvim_lspconfig.capabilities,
  flags = nvim_lspconfig.flags,
  settings = {
    texlab = {
      rootDirectory = nil,
      build = {
        executable = "latexmk",
        args = {"-pdf", "-interaction=nonstopmode", "-synctex=1", "%f", "-pv"},
        onSave = true,
        forwardSearchAfter = true
      },
      auxDirectory = ".",
      forwardSearch = {
        executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
        args = {
          "-r",
          "%l",
          "%p",
          "%f"
        }
      },
      chktex = {
        onOpenAndSave = false,
        onEdit = false
      },
      diagnosticsDelay = 300,
      latexFormatter = "latexindent",
      latexindent = {
        ["local"] = nil, -- local is a reserved keyword
        modifyLineBreaks = false
      },
      bibtexFormatter = "texlab",
      formatterLineLength = 80
    }
  }
}

map("n", "<F4>", ":TexlabForward<CR>", opts)
