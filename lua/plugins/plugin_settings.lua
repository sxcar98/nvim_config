---- PLUGIN OPTIONS ----

local M = {
  -- enable/disable plugins (false for disable)
  status = {
    blankline = true, -- indentline stuff
    bufferline = true, -- manage and preview opened buffers
    colorizer = false, -- color RGB, HEX, CSS, NAME color codes
    comment = true, -- easily (un)comment code, language aware
    dashboard = false,
    better_escape = true, -- map to <ESC> with no lag
    feline = true, -- statusline
    gitsigns = true,
    lspsignature = true, -- lsp enhancements
    vim_matchup = true, -- improved matchit
    cmp = true,
    snippets = true,
    nvimtree = true,
    autopairs = true
  },
  options = {
    packer = {
      init_file = "plugins.packerInit"
    },
    autopairs = {loadAfter = "nvim-cmp"},
    cmp = {
      lazy_load = true
    },
    lspconfig = {
      setup_lspconf = "lsp" -- path of file containing setups of different lsps
    },
    nvimtree = {
      -- packerCompile required after changing lazy_load
      lazy_load = true
    },
    luasnip = {
      snippet_path = {}
    },
    statusline = {
      -- hide, show on specific filetypes
      hidden = {
        "help",
        "dashboard",
        "NvimTree",
        "terminal"
      },
      shown = {},
      -- truncate statusline on small screens
      shortline = true,
      style = "default" -- default, round , slant , block , arrow
    },
    esc_insertmode_timeout = 300
  }
}

return M
