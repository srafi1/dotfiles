vim.keymap.set('n', '<esc>', function()
  vim.cmd [[nohlsearch | echo]]
  -- close all floating windows (usually hover) after clearing search
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_config(win).relative ~= "" then
      vim.api.nvim_win_close(win, false)
    end
  end
end, {silent = true})
vim.keymap.set('n', 'U', ':redo<CR>')

-- paste without overwriting default register
vim.keymap.set('v', '<leader>p', '"_dP')
vim.keymap.set('n', '<leader>p', ':set opfunc=ReplaceMotion<CR>g@')
vim.cmd [[
  function! ReplaceMotion(type)
    silent exe "normal! `[v`]\\"_dP"
  endfunction
]]

vim.keymap.set('n', '<C-p>', function()
  if vim.b.git_dir == "" then
    vim.cmd [[FZF]]
  else
    vim.cmd [[GFiles]]
  end
end)
vim.keymap.set('n', '<C-b>', ':Buffers<CR>')
vim.keymap.set('n', '<C-f>', ':BLines<CR>')

-- reload file
vim.keymap.set('n', '<leader>s', ':e!<CR>')

-- resize splits
vim.keymap.set('n', '<M-h>', '<C-w><')
vim.keymap.set('n', '<M-j>', '<C-w>+')
vim.keymap.set('n', '<M-k>', '<C-w>-')
vim.keymap.set('n', '<M-l>', '<C-w>>')
vim.keymap.set('n', '<M-e>', '<C-W>=')

-- save file
vim.keymap.set('n', '<C-s>', ':w<CR>')
vim.keymap.set('i', '<C-s>', '<C-o>:w<CR>')

-- view unsaved edits in current buffer
vim.keymap.set('n', '<leader>d', ':w !diff % -<CR>')

-- close buffer
vim.keymap.set('n', '<C-q>', ':lclose<bar>b#<bar>bd #<CR>')

-- delete trailing whitespace in file
vim.keymap.set('n', '<leader><BS>', ':%s/\\s\\+$//e<CR>')

-- format text into columns
vim.keymap.set('v', '<leader>t', ':%!column -t<CR>')

-- navigate quickfix list
vim.keymap.set('n', ']q', ':cn<CR>')
vim.keymap.set('n', ']Q', ':cnf<CR>')
vim.keymap.set('n', '[q', ':cp<CR>')
vim.keymap.set('n', '[Q', ':cpf<CR>')

-- goyo and limelight for writing
vim.keymap.set('n', '<leader><leader>l', ':Goyo<CR>:Limelight!!<CR>')

-- toggle editor layout
vim.keymap.set('n', '<M-o>', ':Vista!!<CR>', {silent = true})

-- copy the github link at the current line
vim.keymap.set('n', 'gl', ':.GBrowse!<CR>')
-- open oil
vim.keymap.set("n", "-", ":Oil<CR>")

-- revJ
vim.keymap.set('n', '<leader>j', function() require('trevj').format_at_cursor() end)
