return {
  overwrite = {
    -- 在init.lua中已经设置
    yank = { enabled = false },

    -- 在yanky.nvim中已经设置
    paste = { enabled = false },

    undo = {
      enabled = true,
      default_animation = { settings = { from_color = 'TextChanged' } },
    },
    redo = {
      enabled = true,
      default_animation = { settings = { from_color = 'TextChanged' } },
    },
  },
}
