-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- https://github.com/wbthomason/packer.nvim

-- For information about installed plugins see the README
--- neovim-lua/README.md
--- https://github.com/brainfucksec/neovim-lua#readme

local fn = vim.fn
local cmd = vim.cmd
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- auto install packer on a new system
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
  cmd "packadd packer.nvim"
end

cmd [[packadd packer.nvim]]

local packer = require "packer"

-- Add packages
return packer.startup(
  function()
    -- packer can manage itself
    use "wbthomason/packer.nvim"

    -- dark/light theme autochange
    use "cormacrelf/dark-notify"

    -- transparent background
    use "tribela/vim-transparent"

    -- themes
    use {
      "ellisonleao/gruvbox.nvim",
      requires = "rktjmp/lush.nvim"
    }
    use "doums/darcula"

    -- indent line
    use "lukas-reineke/indent-blankline.nvim"

    -- file explorer
    use "kyazdani42/nvim-tree.lua"

    -- show css color
    use "ap/vim-css-color"

    -- syntax highlight
    use "nvim-treesitter/nvim-treesitter"

    -- autopair
    use "windwp/nvim-autopairs"

    -- autotag for html, etc
    use "windwp/nvim-ts-autotag"

    --  -- rainbow bracket
    --  use 'p00f/nvim-ts-rainbow'

    -- commentary
    use "b3nj5m1n/kommentary"

    -- remove whitespace on save
    use "cappyzawa/trim.nvim"

    -- formatter for filetype LSP doesn't support yet
    use "mhartington/formatter.nvim"

    -- status line
    use {
      "nvim-lualine/lualine.nvim"
      --requires = 'kyazdani42/nvim-web-devicons',
    }

    -- buffertab
    use {
      "akinsho/bufferline.nvim"
      --requires = 'kyazdani42/nvim-web-devicons',
    }

    -- tagviewer
    use "liuchengxu/vista.vim"

    -- Language Server Protocal
    use "neovim/nvim-lspconfig"

    -- Snippets
    use {
      "L3MON4D3/LuaSnip",
      requires = {
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets"
      }
    }

    -- autocomplete
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "octaltree/cmp-look",
        "hrsh7th/cmp-calc",
        "f3fora/cmp-spell",
        "hrsh7th/cmp-emoji",
        "onsails/lspkind-nvim",
        "hrsh7th/cmp-cmdline"
      }
    }

    -- fuzzy finder
    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim"
      }
    }
    use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}

    -- git tools
    use {
      "lewis6991/gitsigns.nvim",
      requires = "nvim-lua/plenary.nvim"
    }

    -- using mac built-in dict
    use {
      "xfyuan/vim-mac-dictionary",
      requires = "skywind3000/vim-quickui"
    }

    -- nvim markdown previewer
    use "davidgranstrom/nvim-markdown-preview"

    -- vim startup
    use {
      "goolord/alpha-nvim"
      -- require = { 'kyazdani42/nvim-web-devicons' }
    }
  end
)
