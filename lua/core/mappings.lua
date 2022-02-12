local M = {}

--- MAPPINGS ----

-- non plugin
local maps = {
  -- custom = {}, -- custom user mappings

  misc = {
    close_buffer = "<leader>x",
    copy_whole_file = "<C-a>", -- copy all contents of current buffer
    copy_to_system_clipboard = "<C-c>", -- copy selected text (visual mode) or curent line (normal)
    line_number_toggle = "<leader>n", -- toggle line number
    relative_line_number_toggle = "<leader>rn",
    new_buffer = "<S-t>",
    new_tab = "<C-t>b",
    save_file = "<C-s>" -- save file using :w
  },
  -- navigation in insert mode, only if enabled in options

  insert_nav = {
    backward = "<C-h>",
    end_of_line = "<C-e>",
    forward = "<C-l>",
    next_line = "<C-k>",
    prev_line = "<C-j>",
    beginning_of_line = "<C-a>"
  },
  -- better window movement
  window_nav = {
    moveLeft = "<C-h>",
    moveRight = "<C-l>",
    moveUp = "<C-k>",
    moveDown = "<C-j>"
  },
  -- terminal related mappings
  terminal = {
    -- multiple mappings can be given for esc_termmode, esc_hide_termmode

    -- get out of terminal mode
    esc_termmode = {"jk"},
    -- get out of terminal mode and hide it
    esc_hide_termmode = {"JK"},
    -- show & recover hidden terminal buffers in a telescope picker
    pick_term = "<leader>W",
    -- spawn terminals
    new_horizontal = "<leader>h",
    new_vertical = "<leader>v",
    new_window = "<leader>w"
  }
}

-- plugins related mappings
-- To disable a mapping, equate the variable to "" or false or nil in chadrc
local plugin_maps = {
  bufferline = {
    next_buffer = "<TAB>",
    prev_buffer = "<S-Tab>"
  },
  comment = {
    toggle = "<leader>/"
  },
  dashboard = {
    bookmarks = "<leader>bm",
    new_file = "<leader>fn", -- basically create a new buffer
    open = "<leader>db", -- open dashboard
    session_load = "<leader>l",
    session_save = "<leader>s"
  },
  -- map to <ESC> with no lag
  better_escape = {},
  lspconfig = {
    declaration = "gD",
    definition = "gd",
    hover = "K",
    implementation = "gi",
    signature_help = "gk",
    add_workspace_folder = "<leader>wa",
    remove_workspace_folder = "<leader>wr",
    list_workspace_folders = "<leader>wl",
    type_definition = "<leader>D",
    rename = "<leader>ra",
    code_action = "<leader>ca",
    references = "gr",
    float_diagnostics = "ge",
    goto_prev = "[d",
    goto_next = "]d",
    set_loclist = "<leader>q",
    formatting = "<leader>fm"
  },
  nvimtree = {
    toggle = "<C-n>",
    focus = "<leader>e"
  },
  telescope = {
    buffers = "<leader>fb",
    find_files = "<leader>ff",
    find_hiddenfiles = "<leader>fa",
    git_commits = "<leader>cm",
    git_status = "<leader>gt",
    help_tags = "<leader>fh",
    live_grep = "<leader>fw",
    oldfiles = "<leader>fo"
  },
  vim_mac_dictionary = {
    popup = "<leader>wd"
  }
}

M.plugin_maps = plugin_maps

local nvChad_options = {
  copy_cut = true, -- copy cut text ( x key ), visual and normal mode
  copy_del = true, -- copy deleted text ( dd key ), visual and normal mode
  insert_nav = true, -- navigation in insertmode
  window_nav = true
}

local utils = require "core.utils"
local map_wrapper = utils.map
local cmd = vim.cmd

-- This is a wrapper function made to disable a plugin mapping from chadrc
-- If keys are nil, false or empty string, then the mapping will be not applied
-- Useful when one wants to use that keymap for any other purpose
local map = function(...)
  local keys = select(2, ...)
  if not keys or keys == "" then
    return
  end
  map_wrapper(...)
end

-- these mappings will only be called during initialization
M.misc = function()
  local function disable_arrowkeys()
    map_wrapper("", "<left>", "<nop>")
    map_wrapper("", "<right>", "<nop>")
    map_wrapper("", "<up>", "<nop>")
    map_wrapper("", "<down>", "<nop>")
  end

  local function non_config_mappings()
    -- Don't copy the replaced text after pasting in visual mode
    map_wrapper("v", "p", '"_dP')

    -- Allow moving the cursor through wrapped lines with j, k
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    map_wrapper("", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', {expr = true})
    map_wrapper("", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', {expr = true})

    -- center cursor when moving (goto_definition)

    -- yank from current cursor to end of line
    map_wrapper("n", "Y", "yg$")
  end

  local function optional_mappings()
    -- don't yank text on cut ( x )
    if not nvChad_options.copy_cut then
      map_wrapper({"n", "v"}, "x", '"_x')
    end

    -- don't yank text on delete ( dd )
    if not nvChad_options.copy_del then
      map_wrapper({"n", "v"}, "d", '"_d')
    end

    -- navigation within insert mode
    if nvChad_options.insert_nav then
      local inav = maps.insert_nav

      map("i", inav.backward, "<Left>")
      map("i", inav.end_of_line, "<End>")
      map("i", inav.forward, "<Right>")
      map("i", inav.next_line, "<Up>")
      map("i", inav.prev_line, "<Down>")
      map("i", inav.beginning_of_line, "<ESC>^i")
    end

    -- easier navigation between windows
    if nvChad_options.window_nav then
      local wnav = maps.window_nav

      map("n", wnav.moveLeft, "<C-w>h")
      map("n", wnav.moveRight, "<C-w>l")
      map("n", wnav.moveUp, "<C-w>k")
      map("n", wnav.moveDown, "<C-w>j")
    end
  end

  local function required_mappings()
    map("n", maps.misc.close_buffer, ":lua require('core.utils').close_buffer() <CR>") -- close  buffer
    map("n", maps.misc.copy_whole_file, ":%y+ <CR>") -- copy whole file content
    map("v", maps.misc.copy_to_system_clipboard, '"+y')
    map("n", maps.misc.copy_to_system_clipboard, '"+yy') -- copy curent line in normal mode
    map("n", maps.misc.new_buffer, ":enew <CR>") -- new buffer
    map("n", maps.misc.new_tab, ":tabnew <CR>") -- new tabs
    map("n", maps.misc.line_number_toggle, ":set nu! <CR>") -- toggle numbers
    map("n", maps.misc.relative_line_number_toggle, ":set rnu! <CR>") -- toggle relative numbers
    map("n", maps.misc.save_file, ":w <CR>") -- ctrl + s to save file

    -- terminal mappings --
    local term_maps = maps.terminal
    -- get out of terminal mode
    map("t", term_maps.esc_termmode, "<C-\\><C-n>")
    -- hide a term from within terminal mode
    map("t", term_maps.esc_hide_termmode, "<C-\\><C-n> :lua require('core.utils').close_buffer() <CR>")
    -- pick a hidden term
    map("n", term_maps.pick_term, ":Telescope terms <CR>")
    -- Open terminals
    -- TODO this opens on top of an existing vert/hori term, fixme
    map("n", term_maps.new_horizontal, ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>")
    map("n", term_maps.new_vertical, ":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>")
    map("n", term_maps.new_window, ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>")
    -- terminal mappings end --

    -- Add Packer commands because we are not loading it at startup
    cmd "silent! command PackerClean lua require 'plugins' require('packer').clean()"
    cmd "silent! command PackerCompile lua require 'plugins' require('packer').compile()"
    cmd "silent! command PackerInstall lua require 'plugins' require('packer').install()"
    cmd "silent! command PackerStatus lua require 'plugins' require('packer').status()"
    cmd "silent! command PackerSync lua require 'plugins' require('packer').sync()"
    cmd "silent! command PackerUpdate lua require 'plugins' require('packer').update()"
  end

  disable_arrowkeys()
  non_config_mappings()
  optional_mappings()
  required_mappings()
end

-- below are all plugin related mappings

M.bufferline = function()
  local m = plugin_maps.bufferline

  map("n", m.next_buffer, ":BufferLineCycleNext <CR>")
  map("n", m.prev_buffer, ":BufferLineCyclePrev <CR>")
end

M.comment = function()
  local m = plugin_maps.comment.toggle
  map("n", m, ":lua require('Comment.api').toggle_current_linewise()<CR>")
  map("v", m, ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>")
end

M.dashboard = function()
  local m = plugin_maps.dashboard

  map("n", m.bookmarks, ":DashboardJumpMarks <CR>")
  map("n", m.new_file, ":DashboardNewFile <CR>")
  map("n", m.open, ":Dashboard <CR>")
  map("n", m.session_load, ":SessionLoad <CR>")
  map("n", m.session_save, ":SessionSave <CR>")
end

M.lspconfig = function()
  local m = plugin_maps.lspconfig

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map("n", m.declaration, "<cmd>lua vim.lsp.buf.declaration()<CR>")
  map("n", m.definition, "<cmd>lua vim.lsp.buf.definition()<CR>")
  map("n", m.hover, "<cmd>lua vim.lsp.buf.hover()<CR>")
  map("n", m.implementation, "<cmd>lua vim.lsp.buf.implementation()<CR>")
  map("n", m.signature_help, "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  map("n", m.add_workspace_folder, "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
  map("n", m.remove_workspace_folder, "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
  map("n", m.list_workspace_folders, "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
  map("n", m.type_definition, "<cmd>lua vim.lsp.buf.type_definition()<CR>")
  map("n", m.rename, "<cmd>lua vim.lsp.buf.rename()<CR>")
  map("n", m.code_action, "<cmd>lua vim.lsp.buf.code_action()<CR>")
  map("n", m.references, "<cmd>lua vim.lsp.buf.references()<CR>")
  map("n", m.float_diagnostics, "<cmd>lua vim.diagnostic.open_float()<CR>")
  map("n", m.goto_prev, "<cmd>lua vim.diagnostic.goto_prev()<CR>")
  map("n", m.goto_next, "<cmd>lua vim.diagnostic.goto_next()<CR>")
  map("n", m.set_loclist, "<cmd>lua vim.diagnostic.setloclist()<CR>")
  map("n", m.formatting, "<cmd>lua vim.lsp.buf.formatting()<CR>")
end

M.nvimtree = function()
  map("n", plugin_maps.nvimtree.toggle, ":NvimTreeToggle <CR>")
  map("n", plugin_maps.nvimtree.focus, ":NvimTreeFocus <CR>")
end

M.telescope = function()
  local m = plugin_maps.telescope

  map("n", m.buffers, ":Telescope buffers <CR>")
  map("n", m.find_files, ":Telescope find_files <CR>")
  map("n", m.find_hiddenfiles, ":Telescope find_files follow=true no_ignore=true hidden=true <CR>")
  map("n", m.git_commits, ":Telescope git_commits <CR>")
  map("n", m.git_status, ":Telescope git_status <CR>")
  map("n", m.help_tags, ":Telescope help_tags <CR>")
  map("n", m.live_grep, ":Telescope live_grep <CR>")
  map("n", m.oldfiles, ":Telescope oldfiles <CR>")
end

M.vim_mac_dictionary = function()
  local m = plugin_maps.vim_mac_dictionary

  map("n", m.popup, ":MacDictPopup <CR>")
end

return M
