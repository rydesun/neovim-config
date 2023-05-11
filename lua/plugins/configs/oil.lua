local border = require 'libs.style'.border()

return {
  -- 不显示concealed ID
  win_options = { concealcursor = 'nvic' },

  columns = {
    { 'icon', default_file = '󰈔', directory = '' },
  },

  keymaps = {
    ['H'] = 'actions.toggle_hidden',
  },

  preview = { border = border },
  progress = { border = border },
}
