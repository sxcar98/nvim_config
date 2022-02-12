local M = {}

M.setup = function()
  local tmp = vim.g.symbols_outline
  tmp = {
    show_symbol_details = false
  }
  vim.g.symbols_outline = tmp
end

return M
