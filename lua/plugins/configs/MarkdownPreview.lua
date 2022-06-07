local M = {}
local g = vim.g

M.setup = function()
  g.mkdp_auto_start = false
  g.mkdp_auto_close = false
  g.mkdp_refresh_slow = false
  g.mkdp_command_for_global = false
  g.mkdp_open_to_the_world = false
  g.mkdp_open_ip = ""
  g.mkdp_echo_preview_url = false
  g.mkdp_browserfunc = ""
  g.mkdp_markdown_css = ""
  g.mkdp_highlight_css = ""
  g.mkdp_port = ""
  g.mkdp_page_title = "「${name}」"
end

return M
