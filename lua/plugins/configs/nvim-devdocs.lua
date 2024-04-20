return {
  previewer_cmd = 'glow',
  cmd_args = { '-s', 'dark', '-w', '80' },

  after_open = function(bufnr)
    local kopts = { silent = true, buffer = true }
    vim.keymap.set('n', 'q', '<Cmd>DevdocsToggle<CR>', kopts)
  end
}
