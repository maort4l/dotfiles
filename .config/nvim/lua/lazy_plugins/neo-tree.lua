return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require('neo-tree').setup({
      close_if_last_window = true,
      filesystem = {
        hijack_netrw_behavior = "open_default",
        follow_current_file = {
          enable = true,
        }
      },
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            require("neo-tree.command").execute({ action = "close" })
          end
        },
      }
    })
    vim.keymap.set("n", "<c-n>", ":Neotree toggle filesystem reveal left<CR>", {})
    vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
  end,
}
