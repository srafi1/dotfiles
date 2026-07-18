require('nvim-treesitter').setup{}

require('nvim-treesitter').install({
  'python',
  'c', 'cpp', 'c_sharp',
  'latex', 'bibtex',
  'typescript', 'tsx', 'javascript',
  'bash',
  'css',
  'dockerfile',
  'html',
  'vim',
  'go',
  'lua',
  'java',
  'rust',
  'dart',
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function(ev)
    pcall(vim.treesitter.start, ev.buf)
  end,
})

require('nvim-treesitter-textobjects').setup{}

local select = require('nvim-treesitter-textobjects.select').select_textobject
local sel = {
  ib = '@block.inner',      ab = '@block.outer',
  ['if'] = '@function.inner', af = '@function.outer',
  ic = '@call.inner',       ac = '@call.outer',
  ia = '@parameter.inner',  aa = '@parameter.outer',
}
for lhs, obj in pairs(sel) do
  vim.keymap.set({'x', 'o'}, lhs, function() select(obj, 'textobjects') end)
end

local move = require('nvim-treesitter-textobjects.move')
vim.keymap.set({'n', 'x', 'o'}, ']]', function() move.goto_next_start('@function.outer', 'textobjects') end)
vim.keymap.set({'n', 'x', 'o'}, ']a', function() move.goto_next_start('@parameter.inner', 'textobjects') end)
vim.keymap.set({'n', 'x', 'o'}, '][', function() move.goto_next_end('@function.outer', 'textobjects') end)
vim.keymap.set({'n', 'x', 'o'}, '[[', function() move.goto_previous_start('@function.outer', 'textobjects') end)
vim.keymap.set({'n', 'x', 'o'}, '[a', function() move.goto_previous_start('@parameter.inner', 'textobjects') end)
vim.keymap.set({'n', 'x', 'o'}, '[]', function() move.goto_previous_end('@function.outer', 'textobjects') end)
