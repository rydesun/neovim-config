local M = {}

function M.setup()
  require 'utils.term-git'.setup()
  require 'utils.zh'.setup()
end

return M
