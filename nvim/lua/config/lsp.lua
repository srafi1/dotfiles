local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
  require'lsp_signature'.on_attach{
    hint_enable = false,
    hi_parameter = 'IncSearch',
  }
  require'nvim-navic'.attach(client, bufnr)

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.api.nvim_create_autocmd('CursorMoved', {
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.clear_references()
      vim.lsp.buf.document_highlight()
    end
  })

  local opts = { buffer = true, silent = true }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  vim.keymap.set('n', 'gm', vim.lsp.buf.implementation, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  -- vimp.inoremap(opts, '<C-p>', vim.lsp.buf.signature_help)
  vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
  vim.keymap.set('n', '<space>cw', vim.lsp.buf.rename, opts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('v', '<space>ca', vim.lsp.buf.code_action, opts)
  vim.keymap.set('n', '<space>e', function()
    vim.diagnostic.open_float({border = "single"})
  end, opts)
  vim.keymap.set('n', '[e', function()
    vim.diagnostic.goto_prev({enable_popup = false})
  end, opts)
  vim.keymap.set('n', ']e', function()
    vim.diagnostic.goto_next({enable_popup = false})
  end, opts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, opts)
end

-- add borders to hover and limit width
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or 'single'
  opts.max_width= opts.max_width or 100
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
  }
)

-- diagnostics sign/highlight definitions
vim.fn.sign_define('LspDiagnosticsSignWarning',     { text='>>' })
vim.fn.sign_define('LspDiagnosticsSignError',       { text='>>' })
vim.fn.sign_define('LspDiagnosticsSignInformation', { text='?'  })
vim.fn.sign_define('LspDiagnosticsSignHint',        { text='~'  })

-- individual server config
-- remember to add installation instructions for new servers to ./lsp-install.sh
local servers = {
  pyright = {},
  ccls = {},
  texlab = {},
  tsserver = {},
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
}
for lsp, config in pairs(servers) do
  config.on_attach = on_attach
  nvim_lsp[lsp].setup(config)
end
