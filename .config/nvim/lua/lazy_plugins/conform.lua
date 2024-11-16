vim.api.nvim_set_option_value('formatexpr', "v:lua.require'conform'.formatexpr(#{timeout_ms:3000})", { buf = bufnr })
-- vim.api.nvim_create_user_command("Format", function(args)
--   local range = nil
--   if args.count ~= -1 then
--     local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
--     range = {
--       start = { args.line1, 0 },
--       ["end"] = { args.line2, end_line:len() },
--     }
--   end
--   require("conform").format({ async = true, lsp_fallback = true, range = range })
-- end, { range = true })

return {
  'stevearc/conform.nvim',
  keys = {
    {
      -- Customize or remove this keymap to your liking
      '<leader>f',
      function()
        require('conform').format({ async = true, lsp_fallback = true })
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  opts = {
    formatters = {
      ruff = {
        prepend_args = { '--line-length', 320 },
      }
    },
    formatters_by_ft = {
      json = { 'fixjson' },
      jsonl = { 'jq' },
      python = { 'ruff_format', 'ruff_fix', 'ruff_organize_imports' },
      -- python = { 'black', 'isort'},
      bash = { 'beautysh' },
      yaml = { 'yamlfmt' },
      sql = { 'sqlfmt' },
      lua = { 'stylua' },
      toml = { 'taplo' },
    },

  },
}
