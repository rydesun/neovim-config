return {
  input = {
    insert_only = false,
    mappings = {
      n = {
        ['<Esc>'] = false,
        ['<C-c>'] = 'Close',
      },
      i = {
        ['<C-p>'] = 'HistoryPrev',
        ['<C-n>'] = 'HistoryNext',
      },
    },

    win_options = {
      winhighlight = 'NormalFloat:WarningMsg',
      winblend = 0,
    },
  },

  select = {
    telescope = require 'telescope.themes'.get_cursor(),
  },
}
