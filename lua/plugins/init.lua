local plugin_settings = require("plugins.plugin_settings")
local present, packer = pcall(require, plugin_settings.options.packer.init_file)

if not present then
  return false
end

local plugins = {
  {"nvim-lua/plenary.nvim"},
  {"lewis6991/impatient.nvim"},
  {"nathom/filetype.nvim"},
  {
    "wbthomason/packer.nvim",
    event = "VimEnter"
  },
  {
    "sxcar98/nvim-base16.lua",
    after = "packer.nvim",
    config = function()
      require("colors").init()
      require("colors.autodark").init_dark_notify()
    end
  },
  {
    "kyazdani42/nvim-web-devicons",
    after = "nvim-base16.lua",
    config = function()
      require("plugins.configs.icons").setup()
    end
  },
  {
    "feline-nvim/feline.nvim",
    disable = not plugin_settings.status.feline,
    after = "nvim-web-devicons",
    config = function()
      require("plugins.configs.statusline").setup()
    end
  },
  {
    "akinsho/bufferline.nvim",
    disable = not plugin_settings.status.bufferline,
    after = "nvim-web-devicons",
    config = function()
      require("plugins.configs.bufferline").setup()
    end,
    setup = function()
      require("core.mappings").bufferline()
    end
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    disable = not plugin_settings.status.blankline,
    event = "BufRead",
    config = function()
      require("plugins.configs.indentline").setup()
    end
  },
  {
    "NvChad/nvim-colorizer.lua",
    disable = not plugin_settings.status.colorizer,
    event = "BufRead",
    config = function()
      require("plugins.configs.colorizer").setup()
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    config = function()
      require("plugins.configs.treesitter").setup()
    end
  },
  -- git stuff
  {
    "lewis6991/gitsigns.nvim",
    disable = not plugin_settings.status.gitsigns,
    opt = true,
    config = function()
      require("plugins.configs.gitsigns").setup()
    end,
    setup = function()
      require("core.utils").packer_lazy_load "gitsigns.nvim"
    end
  },
  -- lsp stuff

  {
    "neovim/nvim-lspconfig",
    module = "lspconfig",
    opt = true,
    setup = function()
      require("core.utils").packer_lazy_load "nvim-lspconfig"
      -- reload the current file so lsp actually starts for it
      vim.defer_fn(
        function()
          vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
        end,
        0
      )
    end,
    config = function()
      require("plugins.configs.lspconfig")
    end
  },
  {
    "ray-x/lsp_signature.nvim",
    disable = not plugin_settings.status.lspsignature,
    after = "nvim-lspconfig",
    config = function()
      require("plugins.configs.signature").setup()
    end
  },
  {
    "andymass/vim-matchup",
    disable = not plugin_settings.status.vim_matchup,
    opt = true,
    setup = function()
      require("core.utils").packer_lazy_load "vim-matchup"
    end
  },
  {
    "max397574/better-escape.nvim",
    disable = not plugin_settings.status.better_escape,
    event = "InsertEnter",
    config = function()
      require("plugins.configs.better_escape").setup()
    end
  },
  -- load luasnips + cmp related in insert mode only

  {
    "rafamadriz/friendly-snippets",
    module = "cmp_nvim_lsp",
    disable = not (plugin_settings.status.cmp and plugin_settings.status.snippets),
    event = "InsertEnter"
  },
  -- cmp by default loads after friendly snippets
  -- if snippets are disabled -> cmp loads on insertEnter!
  {
    "hrsh7th/nvim-cmp",
    disable = not plugin_settings.status.cmp,
    event = not plugin_settings.status.snippets and "InsertEnter",
    after = plugin_settings.status.snippets and "friendly-snippets",
    config = function()
      require("plugins.configs.cmp").setup()
    end
  },
  {
    "L3MON4D3/LuaSnip",
    disable = not (plugin_settings.status.cmp and plugin_settings.status.snippets),
    wants = "friendly-snippets",
    after = "nvim-cmp",
    config = function()
      require("plugins.configs.snippets").setup()
    end
  },
  {
    "saadparwaiz1/cmp_luasnip",
    disable = not (plugin_settings.status.cmp and plugin_settings.status.snippets),
    after = plugin_settings.options.cmp.lazy_load and "LuaSnip"
  },
  {
    "hrsh7th/cmp-nvim-lua",
    disable = not plugin_settings.status.cmp,
    after = (plugin_settings.status.snippets and "cmp_luasnip") or "nvim-cmp"
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    disable = not plugin_settings.status.cmp,
    after = "cmp-nvim-lua"
  },
  {
    "hrsh7th/cmp-buffer",
    disable = not plugin_settings.status.cmp,
    after = "cmp-nvim-lsp"
  },
  {
    "hrsh7th/cmp-path",
    disable = not plugin_settings.status.cmp,
    after = "cmp-buffer"
  },
  -- misc plugins
  {
    "windwp/nvim-autopairs",
    disable = not plugin_settings.status.autopairs,
    after = plugin_settings.options.autopairs.loadAfter,
    config = function()
      require("plugins.configs.autopairs").setup()
    end
  },
  {
    "glepnir/dashboard-nvim",
    disable = not plugin_settings.status.dashboard,
    config = function()
      require("plugins.configs.dashboard")
    end,
    setup = function()
      require("core.mappings").dashboard()
    end
  },
  {
    "numToStr/Comment.nvim",
    disable = not plugin_settings.status.comment,
    module = "Comment",
    keys = {"gcc"},
    config = function()
      require("plugins.configs.comment").setup()
    end,
    setup = function()
      require("core.mappings").comment()
    end
  },
  -- file managing , picker etc
  {
    "kyazdani42/nvim-tree.lua",
    disable = not plugin_settings.status.nvimtree,
    -- only set "after" if lazy load is disabled and vice versa for "cmd"
    after = not plugin_settings.options.nvimtree.lazy_load and "nvim-web-devicons",
    -- cmd = plugin_settings.options.nvimtree.lazy_load and { "NvimTreeToggle", "NvimTreeFocus" },
    -- config = function()
    --   require("plugins.configs.nvimtree").setup()
    -- end,
    setup = function()
      require("core.mappings").nvimtree()
    end
  },
  {
    "nvim-telescope/telescope.nvim",
    module = "telescope",
    cmd = "Telescope",
    config = function()
      require("plugins.configs.telescope").setup()
    end,
    setup = function()
      require("core.mappings").telescope()
    end,
    requires = {
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        module = "telescope",
        run = "make",
        after = "telescope.nvim",
        config = function()
          require("telescope").load_extension("fzf")
        end
      }
    }
  },
  {
    "xfyuan/vim-mac-dictionary",
    after = "vim-quickui",
    requires = {
      {
        "skywind3000/vim-quickui",
        cmd = {
          "MacDictPopup",
          "MacDictWord",
          "MacDictQuery"
        }
      }
    },
    config = function()
      require("plugins.configs.vim_mac_dictionary")
    end,
    setup = function()
      require("core.mappings").vim_mac_dictionary()
    end
  },
  {
    "mhartington/formatter.nvim",
    event = "BufWritePre",
    cmd = {
      "Format"
    },
    config = function()
      require("plugins.configs.formatter").setup()
    end
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    setup = function()
      require("plugins.configs.tagbar").setup()
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    disable = false,
    ft = "markdown",
    cmd = {
      "MarkdownPreview",
      "MarkdownPreviewStop",
      "MarkdownPreviewToggle"
    },
    run = [[sh -c 'cd app && yarn install']],
    setup = function()
      require("plugins.configs.MarkdownPreview").setup()
    end
  }
}

return packer.startup {plugins}
