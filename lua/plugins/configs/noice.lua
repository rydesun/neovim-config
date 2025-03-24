return {
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
