-- install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local use = require'packer'.use
require'packer'.startup(function()
  use 'wbthomason/packer.nvim'
  use 'svermeulen/vimpeccable'
  use 'michaeljsmith/vim-indent-object'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'jiangmiao/auto-pairs'
  use 'nelstrom/vim-visual-star-search'
  use 'tomtom/tcomment_vim'
  use 'tpope/vim-fugitive'
  use 'itchyny/lightline.vim'
  use 'nvim-lua/lsp-status.nvim'
  use {
    'smiteshp/nvim-gps',
    requires = 'nvim-treesitter/nvim-treesitter',
    config = function() require'nvim-gps'.setup{} end,
  }
  use 'tpope/vim-eunuch'
  use 'tpope/vim-rsi'
  use 'chrisbra/unicode.vim'
  use {
    'puremourning/vimspector', config = function()
      vim.g.vimspector_enable_mappings = 'HUMAN'
    end
  }
  use 'justinmk/vim-dirvish'
  use 'liuchengxu/vista.vim'
  use { 'junegunn/fzf', run = './install --bin' }
  use 'junegunn/fzf.vim'
  use 'stsewd/fzf-checkout.vim'
  use {
    'junegunn/vim-easy-align', config = function()
      -- don't ignore strings and comments
      vim.g.easy_align_ignore_groups = {}
    end
  }
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use 'folke/tokyonight.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'nvim-treesitter/playground'
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require'colorizer'.setup{} end,
  }
  use 'itchyny/vim-qfedit'
  use {
    'akinsho/nvim-toggleterm.lua',
    config = function()
      require"toggleterm".setup{
        size = 10,
        open_mapping = '<M-t>',
        persist_size = true,
      }
    end
  }
  use 'neovim/nvim-lspconfig'
  use {
    'hrsh7th/nvim-compe',
    config = function()
      require'compe'.setup {
        source = {
          nvim_lsp = true,
          nvim_lua = true,
          path = true,
          ultisnips = true,
        }
      }
    end
  }
  use 'SirVer/ultisnips'
  use { 'RishabhRD/nvim-lsputils', requires = 'RishabhRD/popfix', commit = 'ae2f20d6938bab234815e0bc69dae1a991307b99' }
  use 'kosayoda/nvim-lightbulb'
  use 'ray-x/lsp_signature.nvim'
  use 'MunifTanjim/nui.nvim'
end)

local vimp = require'vimp'

-- command for opening config
vim.cmd [[ command Config e ~/.config/nvim/init.lua ]]

-- section: general options
local enable = {
  'termguicolors',
  'number',
  'relativenumber',
  'hidden',
  'wrap',
  'cursorline',
  'showmatch',
  'splitbelow',
  'splitright',
  'expandtab',
  'ignorecase',
  'smartcase'
}
for _, opt in ipairs(enable) do
  vim.o[opt] = true
end

vim.g.tokyonight_style = 'night'
vim.g.tokyonight_colors = {border = '#a9b1d6', comment = '#848cb4'}
vim.cmd [[colorscheme tokyonight]]
vim.g.mapleader = ' '
vim.o.history = 100
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.mouse = 'nv'
vim.o.scrolloff = 3
vim.o.updatetime = 300
vim.o.signcolumn = 'yes'
vim.o.shell = '/usr/bin/zsh'
vim.o.shortmess = vim.o.shortmess .. 'c'
vim.o.wildignore =  vim.o.wildignore .. '.git,node_modules'

-- TODO: have fzf use fd if not switching to telescope
vim.g.fzf_branch_actions = {
  delete = {
    execute = 'G branch -d {branch}'
  },
  checkout = {
    execute = 'G checkout {branch}'
  }
}

-- section augroups/autocmd
-- terminal autocmd with fzf
vim.cmd [[
  au TermOpen * tnoremap <buffer> <Esc><Esc> <C-\><C-n>
  au FileType fzf tunmap <buffer> <Esc><Esc>
  au FileType fzf tnoremap <buffer> <Esc> <C-c>
]]

-- if the directory for a new file doesn't exist, create it
vim.cmd(([[
  augroup Mkdir
      autocmd!
      autocmd BufWritePre * \
                   if !isdirectory(expand("<afile>:p:h")) | \
                   call mkdir(expand("<afile>:p:h"), "p") | \
                   endif
  augroup END
]]):gsub('\\\n', ' '))

-- compile pdf after saving tex file
vim.cmd [[autocmd BufWritePost *.tex !pdflatex %]]
vim.g.tex_flavor = 'latex'

-- custom tab config by file extension
vim.cmd(([[
  autocmd BufRead,BufNewFile
    *.html,*.css,*.js,*.jsx,*.ts,*.tsx,*.dart,*.lua
    setlocal tabstop=2 shiftwidth=2
]]):gsub('\n', ' '))
vim.cmd [[ autocmd BufRead,BufNewFile *.go setlocal noexpandtab ]]

-- break lines and enable spellcheck for document based files
vim.cmd [[
  autocmd BufRead,BufNewFile *.tex,*.md,*.mdx,*.txt call WritingMode()
  function! WritingMode()
    setlocal linebreak spell
    nnoremap <buffer> j gj
    nnoremap <buffer> k gk
  endfunction
]]

-- section: key mappings
vimp.nnoremap({'silent'}, '<esc>', function()
  vim.cmd [[nohlsearch | echo]]
  -- close all floating windows (usually hover) after clearing search
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end)
vimp.nnoremap('U', ':redo<CR>')
vimp.nnoremap('Y', 'y$')
-- paste without overwriting default register
vimp.vnoremap('<leader>p', '"_dP')
vimp.nnoremap('<leader>p', ':set opfunc=ReplaceMotion<CR>g@')
vim.cmd [[
  function! ReplaceMotion(type)
    silent exe "normal! `[v`]\\"_dP"
  endfunction
]]
vimp.nnoremap('<C-p>', ':FZF<CR>')
vimp.nnoremap('<C-b>', ':Buffers<CR>')
vimp.nnoremap('<C-f>', ':BLines<CR>')
-- reload file
vimp.nnoremap('<leader>s', ':e!<CR>')
-- resize splits
vimp.nnoremap('<M-h>', '<C-w><')
vimp.nnoremap('<M-j>', '<C-w>+')
vimp.nnoremap('<M-k>', '<C-w>-')
vimp.nnoremap('<M-l>', '<C-w>>')
vimp.nnoremap('<M-e>', '<C-W>=')
-- save file
vimp.nnoremap('<C-s>', ':w<CR>')
vimp.inoremap('<C-s>', '<C-o>:w<CR>')
-- close buffer
vimp.nnoremap('<C-q>', ':lclose<bar>b#<bar>bd #<CR>')
-- delete trailing whitespace in file
vimp.nnoremap('<leader><BS>', ':%s/\\s\\+$//e<CR>')
-- format text into columns
vimp.vnoremap('<leader>t', ':%!column -t<CR>')
-- view unsaved edits in current buffer
vimp.nnoremap('<leader>d', ':w !diff % -<CR>')
-- navigate quickfix list
vimp.nnoremap('gn', ':cn<CR>')
vimp.nnoremap('gN', ':cnf<CR>')
vimp.nnoremap('gp', ':cp<CR>')
vimp.nnoremap('gP', ':cpf<CR>')
-- goyo and limelight for writing
vimp.nnoremap('<leader><leader>l', ':Goyo<CR>:Limelight!!<CR>')
-- toggle editor layout
vimp.nnoremap({'silent'}, '<M-o>', ':Vista!!<CR>')

-- section: lsp
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

local on_attach = function(client, bufnr)
  lsp_status.on_attach(client)
  require'lsp_signature'.on_attach{
    hint_enable = false,
    hi_parameter = 'IncSearch',
  }

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { 'buffer', 'silent' }
  vimp.nnoremap(opts, 'gd', vim.lsp.buf.definition)
  vimp.nnoremap(opts, 'gr', vim.lsp.buf.references)
  vimp.nnoremap(opts, 'K', vim.lsp.buf.hover)
  vimp.inoremap(opts, '<C-p>', vim.lsp.buf.signature_help)
  vimp.nnoremap(opts, 'gy', vim.lsp.buf.type_definition)
  vimp.nnoremap(opts, '<space>cw', require'rename')
  vimp.nnoremap(opts, '<space>ca', vim.lsp.buf.code_action)
  vimp.vnoremap(opts, '<space>ca', vim.lsp.buf.range_code_action)
  vimp.nnoremap(opts, '<space>e', function()
    vim.lsp.diagnostic.show_line_diagnostics({border = "single"})
  end)
  vimp.nnoremap(opts, '[e', function()
    vim.lsp.diagnostic.goto_prev({enable_popup = false})
  end)
  vimp.nnoremap(opts, ']e', function()
    vim.lsp.diagnostic.goto_next({enable_popup = false})
  end)
  vimp.nnoremap(opts, '<space>f', vim.lsp.buf.formatting)

  vim.cmd [[autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()]]
  vim.cmd [[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
end

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
  sumneko_lua = {
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

-- add borders to popups
vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })

-- lsputil handlers
vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler

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

-- section: completion
vim.o.completeopt = vim.o.completeopt .. ',menuone,noinsert,noselect'
vim.g.UltiSnipsExpandTrigger = '<NUL>'
vim.g.snips_author = 'Shakil Rafi'
vimp.inoremap({'silent'}, '<C-Space>', vim.fn['compe#complete'])
vimp.inoremap({'silent', 'expr'}, '<CR>', 'pumvisible() ? compe#confirm("<CR>") : "\\<CR>"')
vimp.inoremap({'silent', 'expr'}, '<C-e>', 'compe#close("<C-e>")')
vimp.inoremap({'expr'}, '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"')
vimp.inoremap({'expr'}, '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"')

-- section: lightline
LightlineFilename = function()
  if vim.fn.expand('%') == '' then
    return '[No name]'
  end
  local root = vim.fn.fnamemodify(vim.b.git_dir, ':h')
  local path = vim.fn.expand('%:p')
  if path:sub(1, #root) == root then
    return path:sub(#root+2)
  end
  return vim.fn.expand('%:p:~')
end

LightlineGPS = function()
  local gps = require'nvim-gps'
  if gps.is_available() and gps.get_location() ~= '' then
    return '> ' .. gps.get_location()
  else
    return ''
  end
end

LspStatus = function()
  if #vim.lsp.buf_get_clients() > 0 then
    return require'lsp-status'.status()
  end
end

vim.g.lightline = {
  colorscheme = 'tokyonight',
  active = {
    left = {
      { 'mode', 'paste' },
      { 'gitbranch', 'filename' },
      { 'readonly', 'modified' }
    },
    right = {
      { 'lineinfo' },
      { 'lspstatus', 'filetype' }
    }
  },
  component_function = {
    gitbranch = 'fugitive#head'
  },
  component = {
    filename = "%{luaeval('LightlineFilename()')} %{luaeval('LightlineGPS()')}",
    lspstatus = "%{luaeval('LspStatus()')}",
    lineinfo = "%{'(' . line('.') . ':' . col('.') .  ')/' . line('$')}"
  }
}

-- section: treesitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      node_incremental = "+",
      node_decremental = "-",
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
        ["if"] = "@function.inner",
        ["af"] = "@function.outer",
        ["ic"] = "@call.inner",
        ["ac"] = "@call.outer",
        ["ia"] = "@parameter.inner",
        ["aa"] = "@parameter.outer",
      },
    },
    move = {
      enable = true,
      goto_next_start = {
        ["]]"] = "@function.outer",
        ["]a"] = "@parameter.inner",
      },
      goto_next_end = {
        ["]["] = "@function.outer",
      },
      goto_previous_start = {
        ["[["] = "@function.outer",
        ["[a"] = "@parameter.inner",
      },
      goto_previous_end = {
        ["[]"] = "@function.outer",
      },
    },
  },
}
