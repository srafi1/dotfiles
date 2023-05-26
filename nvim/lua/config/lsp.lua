local lsp_status = require('lsp-status')
lsp_status.register_progress()
lsp_status.config({
  current_function = false,
  status_symbol = '',
  indicator_errors = 'E',
  indicator_warnings = 'W',
  indicator_info = 'I',
  indicator_hint = 'H',
  indicator_ok = 'LSP',
  spinner_frames = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
})

local nvim_lsp = require('lspconfig')
local vimp = require'vimp'

local on_attach = function(client, bufnr)
  lsp_status.on_attach(client)
  require'lsp_signature'.on_attach{
    hint_enable = false,
    hi_parameter = 'IncSearch',
  }
  require'nvim-navic'.attach(client, bufnr)

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { 'buffer', 'silent' }
  vimp.nnoremap(opts, 'gd', vim.lsp.buf.definition)
  vimp.nnoremap(opts, 'gD', vim.lsp.buf.declaration)
  vimp.nnoremap(opts, 'gm', vim.lsp.buf.implementation)
  vimp.nnoremap(opts, 'gr', vim.lsp.buf.references)
  vimp.nnoremap(opts, 'K', vim.lsp.buf.hover)
  -- vimp.inoremap(opts, '<C-p>', vim.lsp.buf.signature_help)
  vimp.nnoremap(opts, 'gy', vim.lsp.buf.type_definition)
  vimp.nnoremap(opts, '<space>cw', vim.lsp.buf.rename)
  vimp.nnoremap(opts, '<space>ca', vim.lsp.buf.code_action)
  vimp.vnoremap(opts, '<space>ca', vim.lsp.buf.code_action)
  vimp.nnoremap(opts, '<space>e', function()
    vim.diagnostic.open_float({border = "single"})
  end)
  vimp.nnoremap(opts, '[e', function()
    vim.diagnostic.goto_prev({enable_popup = false})
  end)
  vimp.nnoremap(opts, ']e', function()
    vim.diagnostic.goto_next({enable_popup = false})
  end)
  vimp.nnoremap(opts, '<space>f', vim.lsp.buf.formatting)

  vim.cmd [[autocmd CursorMoved <buffer> lua vim.lsp.buf.document_highlight()]]
  vim.cmd [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
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

-- lightbulb
vim.cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]
vim.fn.sign_define('LightBulbSign', { text='!', texthl='WarningMsg' })

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
  config.capabilities = lsp_status.capabilities
  nvim_lsp[lsp].setup(config)
end
