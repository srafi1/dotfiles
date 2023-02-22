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
  use 'tpope/vim-rhubarb'
  use 'itchyny/lightline.vim'
  use 'nvim-lua/lsp-status.nvim'
  use {
    'b0o/incline.nvim',
    config = function()
      require('incline').setup({
        window = {
          padding_char = "|"
        }
      })
    end
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
  use {
    'junegunn/fzf.vim', config = function()
      vim.g.fzf_colors = {
        fg =      {'fg', 'Normal'},
        bg =      {'bg', 'Normal'},
        hl =      {'fg', 'Comment'},
        info =    {'fg', 'PreProc'},
        border =  {'fg', 'Ignore'},
        prompt =  {'fg', 'Conditional'},
        pointer = {'fg', 'Exception'},
        marker =  {'fg', 'Keyword'},
        spinner = {'fg', 'Label'},
        header =  {'fg', 'Comment'},
      }
      vim.g.fzf_colors['fg+'] = {'fg', 'CursorLine', 'CursorColumn', 'Normal'}
      vim.g.fzf_colors['bg+'] = {'bg', 'CursorLine', 'CursorColumn'}
      vim.g.fzf_colors['hl+'] = {'fg', 'Statement'}
    end
  }
  use 'stsewd/fzf-checkout.vim'
  use {
    'ojroques/nvim-lspfuzzy',
    config = function()
      require'lspfuzzy'.setup({
        fzf_action = {
          ['ctrl-q'] = function(lines)
            local entries = {}
            for _, line in ipairs(lines) do
              local filename, lnum, col = line:match('(.*):([0-9]+):([0-9]+)')
              table.insert(entries, {filename = filename, lnum = lnum, col = col, text = line})
            end
            vim.fn.setqflist(entries)
            vim.cmd[[copen]]
            vim.cmd[[cc]]
          end,
        }
      })
    end,
  }
  use {
    'junegunn/vim-easy-align', config = function()
      -- don't ignore strings and comments
      vim.g.easy_align_ignore_groups = {}
    end
  }
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use {
    'folke/tokyonight.nvim',
    config = function ()
      require('tokyonight').setup({
        style = 'moon',
        on_colors = function(colors)
          colors.border = '#a9b1d6'
        end
      })
      vim.cmd[[colorscheme tokyonight]]
    end
  }
  use 'smiteshp/nvim-navic'
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
    },
    run = ':TSUpdate',
  }
  use {
    'norcalli/nvim-colorizer.lua',
    config = function() require'colorizer'.setup{} end,
  }
  use 'itchyny/vim-qfedit'
  use {
    'akinsho/nvim-toggleterm.lua',
    config = function()
      require"toggleterm".setup{
        size = 15,
        open_mapping = '<M-CR>',
        persist_size = true,
      }
    end
  }
  use 'neovim/nvim-lspconfig'
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'SirVer/ultisnips',
      'quangnguyen30192/cmp-nvim-ultisnips',
    },
    config = require'config/nvim-cmp'.setup,
  }
  use 'kosayoda/nvim-lightbulb'
  use 'ray-x/lsp_signature.nvim'
  use {
    'stevearc/dressing.nvim',
    requires = 'MunifTanjim/nui.nvim',
    config = function ()
      require'dressing'.setup{
        input = {
          anchor = 'NW',
          relative = 'cursor',
        },
        select = {
          backend = { 'nui' },
          nui = {
            relative = 'cursor',
            position = { col = 0, row = 1 },
            border = {
              style = 'single'
            },
          },
        },
      }
    end
  }
end)
