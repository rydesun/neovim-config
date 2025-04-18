if not vim.g.rust_playground_dir then return end
local root_dir = vim.fs.normalize(vim.g.rust_playground_dir)

local function get_scratch_dir(name, count)
  if name ~= '' then
    local package_name = name
    if count > 0 then package_name = package_name .. '.' .. count end
    return vim.fs.joinpath(root_dir, package_name)
  end
  local parent_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  local cmd = { 'cargo', 'metadata', '--no-deps', '--format-version', '1' }
  local res = vim.system(cmd, { cwd = parent_dir }):wait()
  local ok, cargo_metadata_json = pcall(vim.fn.json_decode, res.stdout)
  local package_name
  if ok and cargo_metadata_json then
    package_name = cargo_metadata_json.packages[1].name
  else
    package_name = os.date '%Y-%m-%d'
  end
  if count > 0 then package_name = package_name .. '.' .. count end
  return vim.fs.joinpath(root_dir, package_name)
end

local function cargo_init_scratch(dir)
  vim.system { 'cargo', 'new', '--vcs=none', '--name=scratch', dir }:wait()
end

local function open_scratch(dir)
  local file = vim.fs.joinpath(dir, 'src/main.rs')
  local cmd
  if vim.api.nvim_buf_get_name(0) == '' and not vim.bo.modified then
    cmd = 'edit'
  else
    cmd = vim.o.columns < 140 and 'split' or 'vsplit'
  end
  vim.cmd { cmd = cmd, args = { file } }
  vim.g.asynctasks_term_pos = 'bottom'
end

vim.api.nvim_create_user_command(
  'RustPlayground',
  function(opts)
    if opts.count == 0 then opts.count = vim.v.count end
    local dir = get_scratch_dir(opts.args, opts.count)
    if not dir then return end
    cargo_init_scratch(dir)
    open_scratch(dir)
  end, { count = true, nargs = '?' }
)
