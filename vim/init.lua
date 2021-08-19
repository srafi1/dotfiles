-- Install packer
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

local vimp = require'vimp'

local enable = {
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

-- terminal autocmd with fzf
vim.cmd [[
  au TermOpen * tnoremap <buffer> <Esc><Esc> <C-\><C-n>
  au FileType fzf tunmap <buffer> <Esc><Esc>
  au FileType fzf tnoremap <buffer> <Esc> <C-c>
]]

-- don't ignore strings and comments with EasyAlign
vim.g.easy_align_ignore_groups = {}

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
  autocmd BufRead,BufNewFile *.tex,*.md,*.mdx,*.wiki,*.txt call WritingMode()
  function! WritingMode()
    setlocal linebreak spell
    nnoremap <buffer> j gj
    nnoremap <buffer> k gk
  endfunction
]]

-- Vimspector function key keybindings
vim.g.vimspector_enable_mappings = 'HUMAN'

-- key mappings
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
