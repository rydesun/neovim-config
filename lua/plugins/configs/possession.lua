vim.o.sessionoptions = 'folds,help,tabpages,winsize'

return {
  silent = true,
  autosave = {
    current = true,
    cwd = true,
    on_load = false,
    on_quit = true,
  },
  plugins = {
    close_windows = {
      preserve_layout = false,
      match = {
        floating = true,
        buftype = { 'quickfix' },
      },
    },
  },
  hooks = {
    before_save = function()
      if vim.env.KITTY_SCROLLBACK_NVIM == 'true' then return end
      local win_bufs = vim.iter(vim.api.nvim_list_tabpages())
          :map(vim.api.nvim_tabpage_list_wins)
          :flatten()
          :map(vim.api.nvim_win_get_buf)
      local valid_buf = win_bufs:find(function(buf)
        local buf_name = vim.api.nvim_buf_get_name(buf)
        local buf_bt = vim.api.nvim_get_option_value('buftype', { buf = buf })
        local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = buf })
        return buf_name ~= '' and buf_bt == '' and
            not vim.tbl_contains({ 'gitcommit', 'xxd' }, buf_ft)
      end)
      return valid_buf and {} or nil
    end,
  },
}
