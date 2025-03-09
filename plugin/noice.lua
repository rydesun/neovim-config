function NoiceScrollDoc(offset, fallback, mode)
  local ok, noice = pcall(require, 'noice.lsp')
  if not (ok and noice.scroll(offset)) then
    local t = type(fallback)
    if t == 'string' then
      vim.api.nvim_feedkeys(fallback, mode, true)
    elseif t == 'function' then
      fallback()
    end
  end
end
