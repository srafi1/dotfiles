BaseFilename = function()
  if vim.fn.expand('%') == '' then
    return '[No name]'
  end
  local root = vim.fn.fnamemodify(vim.b.git_dir, ':h')
  local path = vim.fn.expand('%:p')
  if path:sub(1, #root) == root and path:sub(1, #path-1) ~= root then
    return path:sub(#root+2)
  end
  return vim.fn.expand('%:p:~')
end

ShortFilename = function(full_name)
  local parts = {}
  local current = ''
  for i = 1, #full_name do
    local c = full_name:sub(i, i)
    if c == '/' then
      table.insert(parts, current)
      current = ''
    else
      current = current .. c
    end
  end
  local trailing_slash = current == ''
  if not trailing_slash then
    table.insert(parts, current)
  end
  local short_name = ''
  for i = 1, #parts do
    local add
    if i <= #parts - 2 then
      add = parts[i]:sub(1,1)
    else
      add = parts[i]
    end
    short_name = short_name .. add .. '/'
  end
  if not trailing_slash then
    short_name = short_name:sub(1, #short_name-1)
  end
  return short_name
end

LightlineFilename = function()
  local full_name = BaseFilename()
  if #full_name > 70 then
    return ShortFilename(full_name)
  end
  return full_name
end

GetLocation = function()
  local navic = require'nvim-navic'
  if navic.is_available() and navic.get_location() ~= '' then
    return '> ' .. navic.get_location()
  else
    return ''
  end
end

LspStatus = function()
  local parts = require'fidget'.get_fidgets()
  return '[' .. vim.fn.join(parts, ',') .. ']'
end

vim.g.lightline = {
  colorscheme = 'tokyonight',
  active = {
    left = {
      { 'mode', 'paste' },
      { 'gitbranch' },
      { 'filename', 'readonly', 'modified' },
    },
    right = {
      { 'lineinfo' },
      { 'filetype' },
      { 'lspstatus' },
    }
  },
  component_function = {
    gitbranch = 'FugitiveHead'
  },
  component = {
    filename = "%{luaeval('LightlineFilename()')} %{luaeval('GetLocation()')}",
    lspstatus = "%{luaeval('LspStatus()')}",
    lineinfo = "%{'(' . line('.') . ':' . col('.') .  ')/' . line('$')}"
  }
}
