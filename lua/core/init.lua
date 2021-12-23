local files = {
  "core/keymaps",
  "core/packer",
  "core/color",
  "core/settings"
}
for _, file in ipairs(files) do
  pcall(require, file)
end
