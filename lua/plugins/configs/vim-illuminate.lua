require 'illuminate'.configure {
  -- 不高亮光标下的单词
  under_cursor = false,

  -- 在大文件上性能太差
  large_file_cutoff = 1000,
}
