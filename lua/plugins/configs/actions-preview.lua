vim.keymap.set({ 'v', 'n' }, 'gra', require 'actions-preview'.code_actions)

local delta = require 'actions-preview.highlight'.delta
local delta_cmd = { 'delta', '--paging=never',
  '--file-style=omit',
  '--hunk-header-style="file line-number"',
  '--hunk-header-line-number-style=',
  '--hunk-header-decoration-style=omit' }
return {
  highlight_command = { delta(table.concat(delta_cmd, ' ')) },
  snacks = { layout = { preset = 'vertical' } },
}
