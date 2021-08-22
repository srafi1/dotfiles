local popup_opts = {
  border = {
    style = 'single',
    highlight = 'Normal',
    text = {
      top = 'New name'
    }
  },
  relative = 'cursor',
  position = { col = 0, row = 1 },
  size = {
    width = 20,
    height = 1,
  },
  enter = true,
}

return function()
  local input = require'nui.input'(popup_opts, {
    prompt = "> ",
    on_submit = function(val)
      vim.cmd'normal l'
      vim.lsp.buf.rename(val)
    end
  })
  input:mount()
  input:map("i", "<esc>", input.input_props.on_close, { noremap = true })
end
