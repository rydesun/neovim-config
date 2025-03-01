-- NvimTree修改文件名的同时通过LSP修改模块名
local prev = { new_name = "", old_name = "" }
vim.api.nvim_create_autocmd("User", {
  pattern = "NvimTreeSetup",
  callback = function()
    local events = require("nvim-tree.api").events
    events.subscribe(events.Event.NodeRenamed, function(data)
      if prev.new_name ~= data.new_name or prev.old_name ~= data.old_name then
        data = data
        Snacks.rename.on_rename_file(data.old_name, data.new_name)
      end
    end)
  end,
})

return {
  bigfile = { enabled = true },
  image = { enabled = true },
  input = { enabled = true },
  picker = { enabled = true },
  scope = { enabled = true, treesitter = { enabled = false } },

  styles = {
    input = {
      keys = {
        hist_up = { "<c-p>", { "hist_up" }, mode = { "i", "n" } },
        hist_down = { "<c-n>", { "hist_down" }, mode = { "i", "n" } },
      },
    },
  },
}
