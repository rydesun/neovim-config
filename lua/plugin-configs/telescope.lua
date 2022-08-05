require'telescope'.setup{
  pickers = {
    live_grep = { theme = 'dropdown' },
    buffers = { theme = 'dropdown', previewer = false },
    find_files = { theme = 'dropdown', previewer = false },
    git_status = { theme = 'dropdown', previewer = false },
  },
}
