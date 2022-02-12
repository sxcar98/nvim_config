local M = {}

M.setup = function()
   require("better_escape").setup {
      mapping = require("core.mappings").plugin_maps.better_escape.esc_insertmode,
      timeout = require("plugins.plugin_settings").options.esc_insertmode_timeout,
   }
end

return M
