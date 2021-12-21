-----------------------------------------------------------
-- Autocomplete configuration file
-----------------------------------------------------------

-- Plugin: nvim-cmp
-- https://github.com/hrsh7th/nvim-cmpa


local cmp = require 'cmp'
local luasnip = require 'luasnip'
local lspkind = require 'lspkind'

local cmpFormat1 = function(entry, vim_item)
  -- fancy icons and a name of kind
  vim_item.kind = lspkind.presets.default[vim_item.kind] .. " " .. vim_item.kind
  -- set a name for each source
  vim_item.menu =
    ({
    buffer = "[Buffer]",
    nvim_lsp = "[LSP]",
    luasnip = "[Snippet]",
    nvim_lua = "[Lua]",
    cmp_tabnine = "[TabNine]",
    look = "[Look]",
    path = "[Path]",
    spell = "[Spell]",
    calc = "[Calc]",
    emoji = "[Emoji]"
  })[entry.source.name]
  return vim_item
end

local cmpFormat2 = function(entry, vim_item)
  vim_item.kind = lspkind.presets.default[vim_item.kind]
  return vim_item
end

local cmpFormat3 = function(entry, vim_item)
  -- fancy icons and a name of kind
  vim_item.kind = lspkind.presets.default[vim_item.kind] .. ""
  -- set a name for each source
  vim_item.menu =
    ({
    buffer = "[Buffer]",
    nvim_lsp = "",
    luasnip = "[Snippet]",
    nvim_lua = "[Lua]",
    cmp_tabnine = "[TabNine]",
    look = "[Look]",
    path = "[Path]",
    spell = "[Spell]",
    calc = "[Calc]",
    emoji = "[Emoji]"
  })[entry.source.name]
  return vim_item
end

cmp.setup {
  -- set format
  formatting = {
    format = cmpFormat1
  },
  -- load snippet support
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

-- completion settings
  completion = {
    --completeopt = 'menu,menuone,noselect'
    keyword_length = 2
  },

  -- key mapping
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },

    -- Tab mapping
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end
  },

  -- load sources, see: https://github.com/topics/nvim-cmp
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'buffer' },
    -- { name = 'look'},
    -- { name = 'calc'},
    -- { name = 'spell'},
    -- { name = 'emoji'},
  },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
