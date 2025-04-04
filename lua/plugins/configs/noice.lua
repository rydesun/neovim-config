return {
  routes = {
    { filter = { event = 'notify', min_height = 20 }, view = 'cmdline_output' },
    { filter = { event = 'msg_show', min_height = 20 }, view = 'cmdline_output' },
  },
  views = {
    mini = { win_options = { winblend = 0 }, format = { ' {message}' } },
    -- 不要背景色
    split = { win_options = { winhighlight = { Normal = 'Normal' } } },
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
    },
  },
}
