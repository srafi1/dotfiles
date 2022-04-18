local enable = {
  'termguicolors',
  'number',
  'relativenumber',
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
vim.o.laststatus = 3
