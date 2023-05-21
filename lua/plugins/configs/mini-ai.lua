local spec_treesitter = require 'mini.ai'.gen_spec.treesitter

return {
  -- f a n l 已被占用
  custom_textobjects = {
    c = spec_treesitter { a = '@comment.outer', i = '@comment.inner' },
    k = spec_treesitter { a = '@assignment.lhs', i = '@assignment.lhs' },
    v = spec_treesitter { a = '@assignment.rhs', i = '@assignment.rhs' },
    d = spec_treesitter { a = '@conditional.outer', i = '@conditional.inner' },
    o = spec_treesitter { a = '@loop.outer', i = '@loop.inner' },
    e = spec_treesitter { a = '@return.outer', i = '@return.inner' },

    C = spec_treesitter { a = '@class.outer', i = '@class.inner' },
    F = spec_treesitter { a = '@function.outer', i = '@function.inner' },
  }
}
