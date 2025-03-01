return {
  routes = {
    { filter = { event = 'msg_show' }, view = 'mini' },
  },
  views = {
    mini = { win_options = { winblend = 0 }, format = {' {message}'} },
  },
  lsp = {
    progress = {
      format = {
        -- 去掉进度条
        "({data.progress.percentage}%) ",
        { "{spinner} ", hl_group = "NoiceLspProgressSpinner" },
        { "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
        { "{data.progress.client} ", hl_group = "NoiceLspProgressClient" },
      }
    },
  },
}
