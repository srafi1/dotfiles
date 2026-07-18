-- shared on-attach behavior (keymaps, navic, signature help)
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    require'lsp_signature'.on_attach{
      hint_enable = false,
      hi_parameter = 'IncSearch',
    }
    if client then
      require'nvim-navic'.attach(client, bufnr)
    end

    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

    vim.api.nvim_create_autocmd('CursorMoved', {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.clear_references()
        vim.lsp.buf.document_highlight()
      end
    })

    local opts = { buffer = bufnr, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gm', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>cw', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('v', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<space>e', function()
      vim.diagnostic.open_float({border = "single"})
    end, opts)
    vim.keymap.set('n', '[e', function()
      vim.diagnostic.jump({count = -1, float = false})
    end, opts)
    vim.keymap.set('n', ']e', function()
      vim.diagnostic.jump({count = 1, float = false})
    end, opts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.format, opts)
  end,
})

-- add borders to hover and limit width
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'single'
  opts.max_width= opts.max_width or 100
  vim.schedule(function() vim.fn['lightline#update']() end) -- fix lightline on hover
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- diagnostics display + signs
vim.diagnostic.config({
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '>>',
      [vim.diagnostic.severity.WARN]  = '>>',
      [vim.diagnostic.severity.INFO]  = '?',
      [vim.diagnostic.severity.HINT]  = '~',
    },
  },
})

-- individual server config
-- remember to add installation instructions for new servers to ./lsp-install.sh
local servers = {
  pyright = {},
  ccls = {},
  texlab = {},
  ts_ls = {},
  bashls = {},
  cssls = {},
  dockerls = {},
  html = {},
  vimls = {},
  gopls = {
    settings = {
      gopls = {
        linksInHover = false
      }
    }
  },
  lua_ls = {
    cmd = {'lua-language-server'},
    settings = {
      Lua = {
        workspace = {
          preloadFileSize = 200 -- increase this if necessary
        }
      }
    }
  },
  jdtls = {
    cmd = {'jdtls'},
    cmd_env = {
      PATH = '/usr/lib/jvm/java-11-openjdk/bin/:/usr/sbin',
    },
  },
  rust_analyzer = {},
  dartls = {},
}

-- add cmp capabilities to every server
local capabilities = require('cmp_nvim_lsp').default_capabilities()

for name, config in pairs(servers) do
  config.capabilities = capabilities
  vim.lsp.config(name, config)  -- merges over nvim-lspconfig's shipped defaults
end
vim.lsp.enable(vim.tbl_keys(servers))
