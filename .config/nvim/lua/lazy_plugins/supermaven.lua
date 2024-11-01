return {
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup({
        keymaps = {
          accept_suggestion = '<C-s>',
          clear_suggestion = '<C-]>',
          accept_word = '<C-j>',
        },
        log_level = 'off',
        -- disable_keymaps = true,
      })
    end,
  },
}
