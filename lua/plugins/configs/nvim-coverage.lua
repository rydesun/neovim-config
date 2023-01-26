require 'coverage'.setup {
  lang = {
    rust = { project_files = { 'crates/*', 'src/*', 'tests/*' } },
  },
}
