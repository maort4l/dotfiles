return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'tzachar/local-highlight.nvim',
       'AndreM222/copilot-lualine',
    },
    config = function()
      -- load	lualine
      require('lualine').setup({
        extensions = {'trouble', 'fugitive', 'lazy','mason'},
        options = {
          icons_enabled = true,
          theme = 'tokyonight',
          globalstatus = true,
          component_separators = '|',
          section_separators = { left = '', right = '' },
        },
        sections = {
          lualine_a = {
            { 'mode', separator = { left = '' }, right_padding = 2 },
          },

          lualine_x = {
            { 'copilot', show_colors = true },
            'encoding',
            'fileformat',
            'filetype',
          },
          lualine_y = {
            'progress',
            function()
              return string.format('match count: %2d', require('local-highlight').match_count())
            end,
          },
          lualine_z = {
            { 'location', separator = { right = '' }, left_padding = 2 },
          },
        },
      })
    end,
  },
  {
    'tzachar/local-highlight.nvim',
    config = function()
      require('local-highlight').setup({
        file_types = { 'python', 'cpp', 'lua', 'rust', 'c', 'cpp' },
      })
    end,
  }
}
