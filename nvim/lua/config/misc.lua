-- command for opening config
vim.cmd [[ command! Config e ~/.config/nvim/init.lua ]]

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

-- go fmt on save
vim.cmd [[ autocmd BufWritePost *.go silent lua vim.lsp.buf.format() vim.cmd'w' ]]

-- break lines and enable spellcheck for document based files
vim.cmd [[
  autocmd BufRead,BufNewFile *.tex,*.md,*.mdx,*.txt call WritingMode()
  function! WritingMode()
    setlocal linebreak spell
    nnoremap <buffer> j gj
    nnoremap <buffer> k gk
  endfunction
]]

vim.cmd [[ autocmd User FugitiveChanged :LspRestart ]]
