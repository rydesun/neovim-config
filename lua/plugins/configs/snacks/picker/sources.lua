local M = {}

M.tagstack = {
  finder = function()
    local curidx = vim.fn.gettagstack().curidx
    local tags = vim.fn.gettagstack().items
    local ret = {}
    for idx, tag in ipairs(tags) do
      if idx >= curidx then return ret end
      local bufnr = tag.from[1]
      if vim.api.nvim_buf_is_valid(bufnr) then
        local file = vim.api.nvim_buf_get_name(bufnr)
        local pos = { tag.from[2], tag.from[3] }
        ret[#ret+1] = { file = file, pos = pos, text = tag.tagname, idx = idx }
      end
    end
    return ret
  end,
  format = function(item, p)
    local ret = Snacks.picker.format.filename(item, p)
    ret[#ret+1] = { item.text, 'Tag' }
    return ret
  end,

  win = {
    input = { keys = { ['<S-CR>'] = { 'pop', mode = { 'i', 'n' } } } },
  },
  actions = {
    pop = function(p, item)
      p:close()
      local curidx = vim.fn.gettagstack().curidx
      local target_idx = item.idx
      local offset = curidx - target_idx
      if offset > 0 then vim.cmd(tostring(offset) .. 'pop') end
    end,
  },
}

return M
