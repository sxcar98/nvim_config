local fn = vim.fn
local opt = vim.opt
local cmd = vim.cmd
if fn.has('termguicolors') then
  opt.termguicolors = true
end

RdTm = fn.localtime()

function ConstRandNumb(length)
  return RdTm%length+1
end

Colors = {
  'gruvbox',
  'darcula',
}
LightColors = {
  'gruvbox',
}
DarkColors = {
  'gruvbox',
  'darcula',
}

local colorscheme = Colors[ConstRandNumb(fn.len(Colors))]
LightColor = LightColors[ConstRandNumb(fn.len(LightColors))]
DarkColor = DarkColors[ConstRandNumb(fn.len(DarkColors))]

-- decomment below command if dark_notify doesn't work
-- vim.api.nvim_command('colorscheme ' .. colorscheme)
