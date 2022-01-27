return {
  setup = function()
    vim.g.UltiSnipsExpandTrigger = '<NUL>'
    vim.g.snips_author = 'Shakil Rafi'
    vim.o.completeopt = 'menu,menuone,noselect'

    local cmp = require'cmp'

    cmp.setup{
      mapping = {
        ['<C-space>'] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's', 'c'}),
        ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's', 'c'}),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm{
          select = true,
          behavior = cmp.ConfirmBehavior.Replace,
        },
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      },
      sources = {
        { name = 'nvim_lua' },
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'ultisnips' },
        { name = 'buffer' },
      },
      snippet = {
        expand = function(args)
          vim.fn['UltiSnips#Anon'](args.body)
        end,
      },
    }

    cmp.setup.cmdline('/', {
      sources = {
        { name = 'buffer' }
      },
    })

    cmp.setup.cmdline(':', {
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })
  end
}
