return {
  -- 更细点的竖线
  borders = {
    vert = '│',
    strong_cross = '┿',
    strong_end = '┥',
    soft_cross = '┼',
    soft_end = '┤',
  },
  keys = {
    {
      '<leader>j',
      function()
        require 'quicker'.expand {
          before = 0,
          after = 1,
          add_to_existing = true,
        }
      end,
    },
    {
      '<leader>k',
      function()
        require 'quicker'.expand {
          before = 1,
          after = 0,
          add_to_existing = true,
        }
      end,
    },
    { '<leader>s', function() require 'quicker'.collapse() end },
  },
}
