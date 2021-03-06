local present, cmp = pcall(require, "cmp")

if not present then
  return
end

local snippets_status = require("plugins.plugin_settings").status.snippets

local default = {
  completion = {
    completeopt = "menuone,noselect"
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  snippet = (snippets_status and
    {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end
    }) or
    {
      expand = function(_)
      end
    },
  formatting = {
    format = function(entry, vim_item)
      local icons = require "plugins.configs.lspkind_icons"
      vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

      vim_item.menu =
        ({
        buffer = "[BUF]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        path = "[Path]",
        luasnip = "[Snippet]",
        cmp_tabnine = "[TabNine]",
        look = "[Look]",
        spell = "[Spell]",
        calc = "[Calc]",
        emoji = "[Emoji]"
      })[entry.source.name]

      return vim_item
    end
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.insert,
      select = true
    },
    ["<Tab>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif snippets_status and require("luasnip").expand_or_jumpable() then
          require("luasnip").expand_or_jump()
        else
          fallback()
        end
      end,
      {"i", "s"}
    ),
    ["<S-Tab>"] = cmp.mapping(
      function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif require("luasnip").jumpable(-1) then
          require("luasnip").jump(-1)
        else
          fallback()
        end
      end,
      {"i", "s"}
    )
  },
  sources = {
    {name = "nvim_lsp"},
    -- {name = "luasnip"},
    {name = "buffer"},
    {name = "nvim_lua"},
    {name = "path"}
  }
}

local M = {}
M.setup = function()
  cmp.setup(default)
end

return M
