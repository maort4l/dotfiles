local M = {}

function M.setup_codelens_refresh(client, bufnr)
  local status_ok, codelens_supported = pcall(function()
    return client.supports_method('textDocument/codeLens')
  end)
  if not status_ok or not codelens_supported then
    return
  end
  local group = 'lsp_code_lens_refresh'
  local cl_events = { 'BufEnter', 'InsertLeave' }
  local ok, cl_autocmds = pcall(vim.api.nvim_get_autocmds, {
    group = group,
    buffer = bufnr,
    event = cl_events,
  })
  if ok and #cl_autocmds > 0 then
    return
  end
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_create_autocmd(cl_events, {
    group = group,
    buffer = bufnr,
    callback = function(...)
      local ok2 = pcall(vim.lsp.codelens.refresh, {bufnr = bufnr})
      if not ok2 then
        vim.notify('Error calling codelense refresh', vim.log.levels.ERROR)
        return true -- remove this autocommand
      end
    end
  })
end

function M.on_attach(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end
  vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })
  -- Mappings.
  local opts = { noremap = true, silent = true }
  buf_set_keymap('n', 'gs', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gv', '<Cmd>vsplit | lua vim.lsp.buf.definition() <CR>', opts)
  buf_set_keymap('n', 'gr', '<Cmd>FzfLua lsp_references<CR>', opts)
  buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.get_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', 'dp', '<cmd>lua vim.diagnostic.goto_prev({float = false, severity = { min = vim.diagnostic.severity.HINT }})<CR>', opts)
  buf_set_keymap('n', 'dn', '<cmd>lua vim.diagnostic.goto_next({float = false, severity = { min = vim.diagnostic.severity.HINT }})<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

  vim.keymap.set({ 'n', 'v' }, '<leader>ca', function()
    require('fzf-lua').lsp_code_actions {
      winopts = {
        title = "Code actions",
        relative = 'cursor',
        row = 0,
        width = 0.8,
        height = 0.7,
        preview = {
          title = 'Changes',
          title_pos = 'Center',
          -- border = 'noborder',
          layout = "vertical",
          vertical = "up"
        },
        -- preview = { vertical = 'up:70%' },
      }
    }
  end, opts)


  -- mark semantic
  local caps = client.server_capabilities
  if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
    vim.b.semantic_tokens = true
  end
  if client.supports_method('textDocument/inlayHintProvider') then
    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    vim.api.nvim_set_hl(0, 'LspInlayHint', { fg = '#7c8fa1' })
  end
  --   vim.lsp.buf.inlay_hint(bufnr, true)
  -- setup codelens
  M.setup_codelens_refresh(client, bufnr)
end

return M
