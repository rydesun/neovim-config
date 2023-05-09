local border = { '▄', '▄', '▄', '█', '▀', '▀', '▀', '█' }

return {
  show_guides = true,
  float = {
    border = border,

    -- https://github.com/stevearc/aerial.nvim/issues/107#issuecomment-1272243325
    relative = "win",
    override = function(conf, source_winid)
      local padding = 1
      conf.anchor = 'NE'
      conf.row = 0
      conf.col = vim.api.nvim_win_get_width(source_winid) - padding
      return conf
    end,
  },
  nav = {
    border = border,
    win_opts = { winblend = 0 },
  },
  icons = require 'libs.kind'.symbols(),
}
