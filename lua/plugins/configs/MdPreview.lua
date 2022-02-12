local mode = require("colors.autodark").trim6(vim.fn.system("dark-notify --exit"))

if mode == "dark" then
  vim.g.nvim_markdown_preview_theme = "solarized-dark"
end
