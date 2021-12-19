local files = {
	'cores/keymaps',
  'cores/plugins',
	'cores/colors',
	'cores/settings',
}
for _, file in ipairs(files) do
  pcall(require, file)
end
