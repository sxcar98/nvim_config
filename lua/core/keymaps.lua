---------------------------------------------------------
-- Keymaps configuration file: keymaps of neovim
-- and plugins.
-----------------------------------------------------------

local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = false}
local g = vim.g
local opt = vim.opt
local fn = vim.fn
-----------------------------------------------------------
-- Neovim shortcuts:
-----------------------------------------------------------

g.mapleader = "," -- change leader to a comma
opt.mouse = "c" -- enable mouse support
opt.pastetoggle = "<F2>" -- use <F2> as paste toggle

-- auto skip pairs
-- uncomplete
--[[ function SkipPair()
  if fn.getline(".")[fn.col(".") - 1] == ")" then
    return
  else
    return
  end
end ]]
map("i", "<leader><leader>", "<Esc>%%a", default_opts)

-- clear search highlighting
map("n", "<leader>c", ":nohl<CR>", default_opts)

-- map Esc to jj
-- map("i", "jj", "<Esc>", default_opts)

-- don't use arrow keys
map("", "<up>", "<C-b>", default_opts)
map("", "<down>", "<C-f>", default_opts)
--[[ map("", "<left>", "<nop>", default_opts)
map("", "<right>", "<nop>", default_opts) ]]
-- move cursor in Insert-mode using Ctrl + {h,j,k,l}
map("i", "<C-h>", "<left>", default_opts)
map("i", "<C-j>", "<down>", default_opts)
map("i", "<C-k>", "<up>", default_opts)
map("i", "<C-l>", "<right>", default_opts)
-- fast saving with <leader> and w
map("n", "<leader>w", ":w<CR>", default_opts)
map("i", "<leader>w", "<C-c>:w<CR>", default_opts)

-- move around splits using Ctrl + {h,j,k,l}
map("n", "<C-h>", "<C-w>h", default_opts)
map("n", "<C-j>", "<C-w>j", default_opts)
map("n", "<C-k>", "<C-w>k", default_opts)
map("n", "<C-l>", "<C-w>l", default_opts)

-- close all windows and exit from neovim
map("n", "<leader>q", ":qa!<CR>", default_opts)

-- refresh configuration using R
map("n", "<leader>r", ":source $MYVIMRC<CR>", default_opts)

-- press <leader,[ ko jump to my placeholder '<++>' and edit it
-- kap('', '<leader>[', '<Esc>/<++><CR>c4l', default_opts)

-- find iterate word using <leader>fd
-- Not Working! map('n', '<leader>fd', '/\(\<\w\+\>\)\_s*\1', default_opts)

-- sudo write using :w!!
-- Not Working! map('c', 'w!!', 'w !sudo -S tee %', default_opts)

-- Need Change! toggle spellcheck using <leader>sc and <leader>scc
-- map("n", "<F5>", ":set spell<CR>", default_opts)
-- map("n", "<F4>", ":set nospell<CR>", default_opts)

-- open terminal
map("n", "<C-t>", ":Term<CR>", default_opts)

-- some keyshorts tips
-- go to the file when cursor is on a filename using gf
-- open spell advisor page when spell check on and cursor on a highlighted word using z=
-- open spell advisor tag in Insert-mode when spell check on
