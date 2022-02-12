local M = {}

M.setup = function()
   local present, luasnip = pcall(require, "luasnip")
   if present then
      local default = {
         history = true,
         updateevents = "TextChanged,TextChangedI",
      }
      luasnip.config.set_config(default)
      require("luasnip/loaders/from_vscode").load { paths = require("plugins.plugin_settings").options.luasnip.snippet_path }
      require("luasnip/loaders/from_vscode").load()
   end
end

return M
