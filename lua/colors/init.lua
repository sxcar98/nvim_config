local files = {
--  'colors/filename',
}
for _, file in ipairs(files) do
  pcall(require, file)
end
