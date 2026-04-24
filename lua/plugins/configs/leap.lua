vim.keymap.set({ 'n', 'x', 'o' }, 'f',
  function() require 'leap'.leap { inputlen = 1 } end)
vim.keymap.set({ 'n', 'x', 'o' }, 'F',
  function() require 'leap'.leap { inputlen = 1, backward = true } end)

return {
  equivalence_classes = {
    ' \t\r\n',
    ',，',
    '.。',
    ':：',
    ';；',
    [['"“”「」『』]],
    '(（',
    ')）',
    '\\、',
    '<《',
    '>》',
  },
}
