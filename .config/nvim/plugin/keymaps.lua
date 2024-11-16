local vim = vim


-- Debug prints
vim.keymap.set("n", "<Leader>d", function() return require('debugprint').debugprint() end,
  { expr = true, desc = "Debug line below" })
vim.keymap.set("n", "<Leader>D", function() return require('debugprint').debugprint({ above = true }) end,
  { expr = true, desc = 'Debug line above' })
vim.keymap.set('n', '<leader>v', function() return require("debugprint").debugprint({ variable = true }) end,
  { expr = true, desc = 'Variable debug line below' })
vim.keymap.set('n', '<leader>V',
  function() return require("debugprint").debugprint({ above = true, variable = true }) end,
  { expr = true, desc = 'Variable debug line above' })

-- Remove silent from ; : mapping, so that : shows up in command mode
vim.keymap.set({ 'n', 'v' }, ';', ':', { silent = false })
vim.keymap.set({ 'n', 'v' }, ':', ';', { silent = false })

-- escape editing mode
vim.keymap.set({ 'i', 't' }, 'jj', '<c-\\><c-n>', { silent = false })
vim.keymap.set('i', '<C-c>', '<c-\\><c-n>', { silent = false })
vim.keymap.set('t', '<C-w><C-w>', '<c-\\><c-n><c-w><c-w>', { silent = false })

-- when moving to next search, center and open folds
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
-- remove search highlight
vim.keymap.set('n', '<space>', '<CMD>nohlsearch<CR>', { silent = true })


-- move between buffers
vim.keymap.set('n', '<C-l>', '<Cmd>bnext<cr>')
vim.keymap.set('n', '<C-j>', '<Cmd>bprev<cr>')
vim.keymap.set('n', '<C-k>', '<Cmd>b#<cr>')

-- David-Kunz/treesitter-unit
vim.keymap.set({'x','o'},'iu', ':lua require"treesitter-unit".select()<CR>')
vim.keymap.set({'x','o'},'au', ':lua require"treesitter-unit".select(true)<CR>')

-- undo
-- vim.keymap.set('n', '<F5>', '<Cmd>MundoToggle<cr>')


-- buf_set_keymap('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
