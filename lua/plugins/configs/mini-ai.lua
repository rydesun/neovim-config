local spec_treesitter = require 'mini.ai'.gen_spec.treesitter

return {
  -- 50也太少了
  n_lines = 1000,

  -- 出现在a和i后面的字母保留情况：ab hiI l n pq sSt wW
  -- 出现在a和i后面的按键被占用的情况：
  -- n和l被占用：在mini.ai自定义的文本对象前面：n=next, l=last
  -- ii和ai被snacks.scope占用
  -- 在keymaps.vim手动设置nvim-various-textobjs
  -- 字母abq、空格、数字、标点符号，以及其他见h: MiniAi-textobject-builtin

  -- mini.ai为被覆盖的默认键位提供search_method，但有n_lines限制
  custom_textobjects = {
    c = spec_treesitter { a = '@comment.outer', i = '@comment.inner' },
    k = spec_treesitter { a = '@assignment.lhs', i = '@assignment.lhs' },
    v = spec_treesitter { a = '@assignment.rhs', i = '@assignment.rhs' },
    d = spec_treesitter { a = '@conditional.outer', i = '@conditional.inner' },
    o = spec_treesitter { a = '@loop.outer', i = '@loop.inner' },
    f = spec_treesitter { a = '@call.outer', i = '@call.inner' },
    r = spec_treesitter { a = '@return.outer', i = '@return.inner' },

    B = spec_treesitter { a = '@block.outer', i = '@block.inner' },
    C = spec_treesitter { a = '@class.outer', i = '@class.inner' },
    F = spec_treesitter { a = '@function.outer', i = '@function.inner' },
  },
}
