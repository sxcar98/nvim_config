-----------------------------------------------------------
-- Treesitter configuration file
-----------------------------------------------------------

-- Plugin: nvim-treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter


require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
  },
}
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if (not status) then
  return
end

treesitter.setup {
  highlight = {
    enable = true,
    disable = {}
  },
  indent = {
    enable = false,
    disable = {}
  },
  ensure_installed = {
    'c',
    'html',
    'typescript',
    'cpp',
    'python',
    'bash',
    'lua',
    'vim',
    'latex',
    'markdown'
  }
}
