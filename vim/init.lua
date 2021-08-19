-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local use = require'packer'.use
require'packer'.startup(function()
  use 'wbthomason/packer.nvim'
  use 'michaeljsmith/vim-indent-object'
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'jiangmiao/auto-pairs'
  use 'nelstrom/vim-visual-star-search'
  use 'tomtom/tcomment_vim'
  use 'tpope/vim-fugitive'
  use 'vimwiki/vimwiki'
  use 'itchyny/lightline.vim'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-rsi'
  use 'chrisbra/unicode.vim'
  use 'puremourning/vimspector'
  use 'justinmk/vim-dirvish'
  use 'liuchengxu/vista.vim'
  use 'junegunn/fzf.vim'
  use 'stsewd/fzf-checkout.vim'
  use 'junegunn/vim-easy-align'
  use 'junegunn/goyo.vim'
  use 'junegunn/limelight.vim'
  use 'folke/tokyonight.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'romgrk/nvim-treesitter-context'
  use 'nvim-treesitter/playground'
  use 'norcalli/nvim-colorizer.lua'
  use 'itchyny/vim-qfedit'
  use 'akinsho/nvim-toggleterm.lua'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'SirVer/ultisnips'
  use 'nvim-lua/lsp-status.nvim'
  use { 'RishabhRD/nvim-lsputils', requires = { 'RishabhRD/popfix' } }
  use 'kosayoda/nvim-lightbulb'
  use 'ray-x/lsp_signature.nvim'
  use 'MunifTanjim/nui.nvim'
end)

local opts = {
  'termguicolors',
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
for _, opt in ipairs(opts) do
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

-- terminal autocmd with fzf
vim.cmd [[
  au TermOpen * tnoremap <buffer> <Esc><Esc> <C-\><C-n>
  au FileType fzf tunmap <buffer> <Esc><Esc>
  au FileType fzf tnoremap <buffer> <Esc> <C-c>
]]

-- don't ignore strings and comments with EasyAlign
vim.g.easy_align_ignore_groups = {}

-- if the directory for a new file doesn't exist, create it
vim.cmd [[
  augroup Mkdir
    autocmd!
    autocmd BufWritePre *
      \ if !isdirectory(expand("<afile>:p:h")) |
      \ call mkdir(expand("<afile>:p:h"), "p") |
      \ endif
  augroup END
]]

-- compile pdf after saving tex file
vim.cmd [[autocmd BufWritePost *.tex !pdflatex %]]
vim.g.tex_flavor = 'latex'

-- custom tab config by file extension
vim.cmd [[
  autocmd BufRead,BufNewFile 
    \ *.html,*.css,*.js,*.jsx,*.ts,*.tsx,*.dart,*.lua
    \ setlocal tabstop=2 shiftwidth=2
  autocmd BufRead,BufNewFile *.go setlocal noexpandtab
]]


-- break lines and enable spellcheck for document based files
vim.cmd [[
  autocmd BufRead,BufNewFile *.tex,*.md,*.mdx,*.wiki,*.txt call WritingMode()
  function! WritingMode()
    setlocal linebreak spell
    nnoremap <buffer> j gj
    nnoremap <buffer> k gk
  endfunction
]]

-- Vimspector function key keybindings
vim.g.vimspector_enable_mappings = 'HUMAN'
