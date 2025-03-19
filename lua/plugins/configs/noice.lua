return {
  routes = {
    -- 过滤掉写入信息，除非是新文件
    {
      filter = { event = 'msg_show', find = '^".+" %d+L, %d+B ' },
      opts = { skip = true },
    },
    { filter = { event = 'msg_show' }, view = 'mini' },
  },
  views = {
    mini = { win_options = { winblend = 0 }, format = { ' {message}' } },
  },
  lsp = {
    progress = {
      format = {
        -- 去掉进度条
        '({data.progress.percentage}%) ',
        { '{spinner} ', hl_group = 'NoiceLspProgressSpinner' },
        { '{data.progress.title} ', hl_group = 'NoiceLspProgressTitle' },
        { '{data.progress.client} ', hl_group = 'NoiceLspProgressClient' },
      },
    },
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
  },
}
