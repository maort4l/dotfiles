local function config()
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')

  local select_buffer = function(_)
    local entry = action_state.get_selected_entry()
    if not entry then
      return
    end
    local buffers = vim.tbl_filter(function(b)
      if 1 ~= vim.fn.buflisted(b) then
        return false
      end

      return true
    end, vim.api.nvim_list_bufs())
    table.sort(buffers, function(a, b)
      return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
    end)
    vim.cmd(string.format('buffer! %s', vim.api.nvim_buf_get_name(entry.bufnr)))
    vim.fn.setreg('#', buffers[1])
    return false
  end

  require('telescope').setup({
    defaults = {
      mappings = {
        i = {
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
        },
        n = {
          ['q'] = actions.close,
        },
      },
    },
    pickers = {
      find_files = {
        find_command = { 'fd', '-H', '--type', 'f', '--strip-cwd-prefix' },
        timeout = 2000,
      },
      buffers = {
        initial_mode = 'normal',
        show_all_buffers = true,
        sort_lastused = false,
        timeout = 2000,
        mappings = {
          i = {
            ['<C-d>'] = 'delete_buffer',
            ['<cr>'] = select_buffer,
          },
          n = {
            ['d'] = 'delete_buffer',
          },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
        recent_files = {}, ---@diagnostic disable-line
      },
    },
  })
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('project')
  require('telescope').load_extension('recent_files')
end

return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-project.nvim',
      'smartpde/telescope-recent-files',
      'nvim-telescope/telescope-file-browser.nvim',
    } },
    config = config,
    lazy = true,
    keys = {
      -- telescope
      -- { '<leader>pb', '<cmd>lua require("telescope.builtin").buffers()<cr>', mode = { 'n' }, desc = 'Buffers' },
      -- { '<leader>pp', '<cmd>lua require("telescope.builtin").find_files()<cr>', mode = { 'n' } },
      { '<leader>pf', '<cmd>lua require ("telescope").extensions.project.project{}<cr>', mode = { 'n' }, desc = 'Find Project' },
      { '<leader>pr', '<cmd>lua require("telescope").extensions.recent_files.pick()<CR>', mode = { 'n' }, desc = 'Recent Files' },
      { '<leader>fb', '<cmd>lua require("telescope").extensions.file_browser.file_browser()<CR>', mode = { 'n' }, desc = 'File Browser' },
    },
  },
}
