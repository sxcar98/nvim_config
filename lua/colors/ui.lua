local M = {
  italic_comments = false,
  theme = "",
  -- Change terminal bg to nvim theme's bg color so it'll match well
  -- For Ex : if you have onedark set in nvchad, set onedark's bg color on your terminal
  transparency = true
}

local mode = require("colors.autodark").trim6(vim.fn.system("dark-notify --exit"))

local theme = ""
if mode == "dark" then
  M.theme = "gruvbox"
else
  M.theme = "one-light"
end

return M
