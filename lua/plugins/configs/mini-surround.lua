local ts_input = require 'mini.surround'.gen_spec.input.treesitter

return {
  n_lines = 1000, -- 初始值20

  mappings = { update_n_lines = 's+', find = '', find_left = '' },
  custom_surroundings = {
    f = { input = ts_input { outer = '@call.outer', inner = '@call.inner' } },
    B = { input = ts_input { outer = '@block.outer', inner = '@block.inner' } },
  },

  respect_selection_type = true,
}
