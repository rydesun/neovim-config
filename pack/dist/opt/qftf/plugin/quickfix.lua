-- https://github.com/kevinhwang91/nvim-bqf/#format-new-quickfix

local fn = vim.fn
local fname_maxlen = 16
local fname_fmt1 = '%-' .. fname_maxlen .. 's'
local fname_fmt2 = '…%.' .. (fname_maxlen - 1) .. 's'
local valid_fmt = '%s │%4d:%-3d│%s %s'

local function format_line(e)
  if e.valid ~= 1 then return e.text end

  local fname = ''
  if e.bufnr > 0 then
    fname = fn.bufname(e.bufnr)
    fname = fn.fnamemodify(fname, ':t')
    if #fname <= fname_maxlen then -- 中文炸裂
      fname = fname_fmt1:format(fname)
    else
      fname = fname_fmt2:format(fname:sub(1 - fname_maxlen))
    end
  end
  local lnum = e.lnum > 99999 and -1 or e.lnum
  local col = e.col > 999 and -1 or e.col
  local qtype = e.type == '' and '' or ' ' .. e.type:sub(1, 1):upper()
  return valid_fmt:format(fname, lnum, col, qtype, fn.trim(e.text))
end

function _G.qftf(info)
  local items
  if info.quickfix == 1 then
    items = fn.getqflist({ id = info.id, items = 0 }).items
  else
    items = fn.getloclist(info.winid, { id = info.id, items = 0 }).items
  end

  local ret = {}
  for i = info.start_idx, info.end_idx do
    local str = format_line(items[i])
    table.insert(ret, str)
  end
  return ret
end

vim.o.qftf = '{info -> v:lua._G.qftf(info)}'
