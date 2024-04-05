return {
  "catppuccin/nvim",
  enabled = false,
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "mocha",
      color_overrides = {
        mocha = {
          base = "#16161e",
          mantle = "#101016",
          -- crust = "#ff0000";
        }
      },
      integrations = {
        cmp = true,
        mason = true,
        neotree = true,
        neogit = true,
        flash = true,
        gitsigns = true,
        semantic_tokens = true,
        treesitter = true,
        ts_rainbow2 = false,
        notify = true,
        treesitter_context = true,
        lsp_trouble = true,
        which_key = true,
        indent_blankline = {
          enabled = true,
          scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = false,
        },
      }
    })
    vim.cmd('colorscheme catppuccin-mocha')
  end,
  build = function()
    require('catppuccin-mocha').compile()
  end,
}
