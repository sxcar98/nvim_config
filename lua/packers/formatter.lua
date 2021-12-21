local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

require('formatter').setup()

map('n', '<F3>', ':Format<CR>',opts)

-- Format on save
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.rs,*.lua FormatWrite
augroup END
]], true)

-- setup lua-fmt
require('formatter').setup({
  filetype = {
    lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
    },
  }
})
