local present, trim = pcall(require, "trim")
if not present then
  return
end

local default = {
  -- if you want to ignore markdown file.
  -- you can specify filetypes.
  disable = {"markdown"},

  -- if you want to ignore space of top
  patterns = {
    [[%s/\s\+$//e]],
    [[%s/\($\n\s*\)\+\%$//]],
    [[%s/\(\n\n\)\n\+/\1/]],
  },
}

local M = {}

M.setup = function()
  trim.setup(default)
end

return M
