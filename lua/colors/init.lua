local vim = vim

local M = {}

local config = require("colors.config")

local default_theme

-- if theme given, load given theme if given, otherwise nvchad_theme
M.init = function(theme)
  local mode = require("colors.autodark").trim6(vim.fn.system("dark-notify --exit"))
  if not theme then
    if mode == "dark" then
      theme = config.dark_theme
    else
      theme = config.light_theme
    end
  end

  -- set the global theme, used at various places like theme switcher, highlights
  default_theme = theme

  local present, base16 = pcall(require, "base16")

  if present then
    -- first load the base16 theme
    base16(base16.themes(theme), true)

    -- unload to force reload
    package.loaded["colors.highlights" or false] = nil
    -- then load the highlights
    require "colors.highlights"
  end
end

-- returns a table of colors for given or current theme
M.get = function(theme)
  if not theme then
    theme = default_theme
  end

  return require("hl_themes." .. theme)
end

M.reload_plugin = function(plugins)
  local status = true
  local function _reload_plugin(plugin)
    local loaded = package.loaded[plugin]
    if loaded then
      package.loaded[plugin] = nil
    end

    local custom_require = function(plugin)
      require(plugin).setup()
    end

    local ok, err = pcall(custom_require, plugin)
    if not ok then
      print("Error: Cannot load " .. plugin .. " plugin!\n" .. err .. "\n")
      status = false
    end
  end

  if type(plugins) == "string" then
    _reload_plugin(plugins)
  elseif type(plugins) == "table" then
    for _, plugin in ipairs(plugins) do
      _reload_plugin(plugin)
    end
  end
  return status
end

M.reload = function(theme_name)
  local reload_plugin = M.reload_plugin

  -- if theme name is empty or nil, then reload the current theme
  if theme_name == nil or theme_name == "" then
    theme_name = default_theme
  end

  if not pcall(require, "hl_themes." .. theme_name) then
    print("No such theme ( " .. theme_name .. " )")
    return false
  end

  default_theme = theme_name

  -- reload the base16 theme and highlights
  M.init(theme_name)

  if
    not reload_plugin {
      "plugins.configs.bufferline",
      "plugins.configs.statusline"
    }
   then
    print "Error: Not able to reload all plugins."
    return false
  end

  return true
end

return M
