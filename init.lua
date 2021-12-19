-----------------------------------------------------------
-- Import Lua modules
-----------------------------------------------------------
-- You should keep plugins module load before other modules so if
-- some plugins fall down you can still use PackerSync to fix it.
local files = {
--  'colors',
  'cores',
  'snippets',
  'lsp',
  'plugins',
}

for _, file in ipairs(files) do
  pcall(require, file)
end
