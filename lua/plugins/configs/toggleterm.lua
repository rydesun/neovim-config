return {
  open_mapping = [[<c-\>]],

  -- 不要变暗
  shade_terminals = false,

  float_opts = {
    border = require 'libs.style'.border(),
  },
  highlights = {
    FloatBorder = { link = 'FloatBorder' },
  },
}
