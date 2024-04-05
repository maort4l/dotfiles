vim.loader.enable()
-- vim.g.loaded_python_provider = 1
vim.g.python_host_prog = ''
vim.g.python3_host_prog = vim.fn.environ()['HOME'] .. '/.pyenv/shims/python3'

function dump(...) ---@diagnostic disable-line
  local objects = vim.tbl_map(vim.inspect, { ... })
  print(unpack(objects))
end

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require('vim_opts')
require('plugins')
require('misc')
