local vimp = require'vimp'

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

-- paste without overwriting default register
vimp.vnoremap('<leader>p', '"_dP')
vimp.nnoremap('<leader>p', ':set opfunc=ReplaceMotion<CR>g@')
vim.cmd [[
  function! ReplaceMotion(type)
    silent exe "normal! `[v`]\\"_dP"
  endfunction
]]

vimp.nnoremap('<C-p>', function()
  if vim.b.git_dir == "" then
    vim.cmd [[FZF]]
  else
    vim.cmd [[GFiles]]
  end
end)
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

-- view unsaved edits in current buffer
vimp.nnoremap('<leader>d', ':w !diff % -<CR>')

-- close buffer
vimp.nnoremap('<C-q>', ':lclose<bar>b#<bar>bd #<CR>')

-- delete trailing whitespace in file
vimp.nnoremap('<leader><BS>', ':%s/\\s\\+$//e<CR>')

-- format text into columns
vimp.vnoremap('<leader>t', ':%!column -t<CR>')

-- navigate quickfix list
vimp.nnoremap(']q', ':cn<CR>')
vimp.nnoremap(']Q', ':cnf<CR>')
vimp.nnoremap('[q', ':cp<CR>')
vimp.nnoremap('[Q', ':cpf<CR>')

-- goyo and limelight for writing
vimp.nnoremap('<leader><leader>l', ':Goyo<CR>:Limelight!!<CR>')

-- toggle editor layout
vimp.nnoremap({'silent'}, '<M-o>', ':Vista!!<CR>')
