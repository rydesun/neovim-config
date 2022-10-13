require 'neo-tree'.setup {
  log_level = 'warn',
  -- 如果是最后一个窗口则直接退出
  close_if_last_window = true,
  default_component_configs = {
    icon = { folder_empty = '', default = '' },
    git_status = {
      symbols = {
        added = '', modified = '',
        ignored = 'i', unstaged = '*', staged = '+',
      }
    },
    diagnostics = {
      symbols = { error = '● ', warn = '▲ ', info = '■ ', hint = '■ ' },
      highlights = {
        error = 'DiagnosticSignError',
        warn = 'DiagnosticSignWarn',
        info = 'DiagnosticSignInfo',
        hint = 'DiagnosticSignHint',
      },
    },
  },
  window = {
    position = 'float',
    popup = { size = { width = 40, height = 20 } },
    mappings = {
      ['a'] = { 'add', config = { show_path = 'relative' } },
    }
  },
  filesystem = {
    -- 让位dirbuf.nvim接管netrw
    hijack_netrw_behavior = 'disabled',
    -- 别碰我的cwd！
    bind_to_cwd = false,
    -- 压缩空目录路径
    group_empty_dirs = true,
    window = {
      mappings = {
        ['<c-k>'] = 'prev_git_modified',
        ['<c-j>'] = 'next_git_modified',
      }
    },
  },
}
