-- 修改coc数据目录, 默认值是XDG config目录
vim.g.coc_data_home = vim.g.datadir..'/coc'

-- 覆盖K键
vim.api.nvim_set_keymap('n', 'K', '', {
    noremap = true,
    callback = function()
      if vim.fn.CocAction('hasProvider', 'hover') then
        vim.fn.CocActionAsync('doHover')
      else
        vim.fn.feedkeys('K', 'in')
      end
    end,
})

-- 补全跳转后显示函数签名
vim.api.nvim_create_autocmd({"User"}, {
  pattern = {"CocJumpPlaceholder"},
  callback = function()
    vim.fn.CocActionAsync('showSignatureHelp')
  end
})

-- readonly文件不显示diagnostic
vim.api.nvim_create_autocmd({"BufRead"}, {
  pattern = {"*"},
  callback = function()
    if vim.bo.readonly == 1 then
      vim.b.coc_diagnostic_disable = 1
    end
  end
})
