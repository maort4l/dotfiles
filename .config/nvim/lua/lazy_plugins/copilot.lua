return {
  'zbirenbaum/copilot.lua',
  enabled = true,
  config = function()
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  end,
}
