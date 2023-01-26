require 'aerial'.setup {
  layout = {
    max_width = 40,
    default_direction = 'float',
  },
  highlight_on_hover = true,
  close_on_select = true,
  show_guides = true,
  icons = require 'plugins.configs.lspkind'.symbols(),
}
