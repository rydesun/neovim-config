local view_ivy = { theme = 'ivy', trim_text = true }
local view_dropdown = { theme = 'dropdown', previewer = false }

require 'telescope'.setup {
  pickers = {
    lsp_definitions = view_ivy,
    lsp_type_definitions = view_ivy,
    lsp_implementations = view_ivy,
    lsp_references = view_ivy,
    grep_string = view_ivy,

    live_grep = view_ivy,
    current_buffer_fuzzy_find = view_ivy,
    command_history = view_ivy,

    diagnostics = view_ivy,
    jumplist = view_ivy,
    marks = view_ivy,

    buffers = view_dropdown,
    oldfiles = view_dropdown,

    find_files = view_dropdown,
    git_status = view_dropdown,

    help_tags = view_ivy,

    registers = { theme = 'cursor', layout_config = { height = 20 } },
    symbols = { theme = 'cursor', layout_config = { width = 40 } },
  },
}

require 'telescope'.load_extension 'fzf'

require 'telescope'.load_extension 'neoclip'
require 'neoclip'.setup {
  keys = {
    telescope = {
      -- 不要覆盖<c-p>
      i = { paste = '<c-y>' },
    }
  }
}
