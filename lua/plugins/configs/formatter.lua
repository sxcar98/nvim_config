local present, formatter = pcall(require, "formatter")

if not present then
  return
end

local default = {
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
    }
  }
}

local M = {}

M.setup = function()
  formatter.setup(default)
  vim.api.nvim_exec(
    [[
    augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.js,*.rs,*.lua FormatWrite
    augroup END
  ]],
    true
  )
end

return M
