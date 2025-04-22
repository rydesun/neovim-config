local M = {}

M.alternative_file = {
  multi = { 'buffers', 'files' },
  transform = 'unique_file',
  pattern = function(picker)
    local name = vim.fn.expand(picker.opts.without_ext and '%:t:r' or '%:t')
    if not picker.opts.affix then return name end

    local affix_pat
    if name:find(picker.opts.affix) then
      name = name:gsub(picker.opts.affix, '')
          :gsub('^[-_]', ''):gsub('[-_]$', '')
      affix_pat = '!' .. picker.opts.affix
    elseif vim.fn.expand '%:h':find(picker.opts.affix) then
      affix_pat = '!' .. picker.opts.affix
    else
      affix_pat = picker.opts.affix
    end
    return ('%s %s'):format(affix_pat, name)
  end,
}

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

M.keymap_file = {
  finder = 'grep',
  layout = 'ivy_split',
  need_search = false,
  regex = false,
  dirs = { vim.fn.stdpath 'config' .. '/plugin/keymaps.vim' },
  sort = { fields = { 'score:desc', 'idx' } },
}

return M
