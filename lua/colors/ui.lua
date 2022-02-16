local M = {
  italic_comments = false,
  theme = "",
  -- Change terminal bg to nvim theme's bg color so it'll match well
  -- For Ex : if you have onedark set in nvchad, set onedark's bg color on your terminal
  transparency = true
}

local mode = vim.fn.system({'powershell.exe', '-c', 'dark-notify'})

local theme = ""


if (mode - 1 == 0) then
  M.theme = "one-light"
else
  M.theme = "gruvbox"
end

return M
