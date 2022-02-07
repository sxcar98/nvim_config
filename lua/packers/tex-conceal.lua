local g = vim.g
local opt = vim.opt

opt.conceallevel = 2

g.tex_superscripts = "[0-9a-zA-W.,:;+-<>/()=]"
g.tex_subscripts = "[0-9aehijklmnoprstuvx,+-/().]"
g.tex_conceal_frac = 1
g.tex_conceal = "abdgm"
