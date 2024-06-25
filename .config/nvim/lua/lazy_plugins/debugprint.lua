-- debug prints
return {
  'andrewferrier/debugprint.nvim',
  opts = {
    keymaps = {
      normal = {
        plain_below = '<leader>d',
        plain_above = '<leader>D',
        variable_below = '<leader>vd',
        variable_above = '<leader>vD',
      },
      visual = {
        plain_below = '<leader>d',
        plain_above = '<leader>D',
        variable_below = '<leader>vd',
        variable_above = '<leader>vD',
      },
    },
    commands = {
      toggle_comment_debug_prints = "ToggleCommentDebugPrints",
      delete_debug_prints = "DeleteDebugPrints",
    },
  },
}
