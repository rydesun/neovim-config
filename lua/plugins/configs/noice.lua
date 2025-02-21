return {
  cmdline = { enabled = true },
  routes = {
    { filter = { event = 'msg_show' }, view = 'mini' },
  },
  views = {
    mini = { win_options = { winblend = 0 } },
  }
}
