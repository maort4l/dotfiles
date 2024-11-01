local function setup()
  local lspkind = require('lspkind')
  local cmp = require('cmp')
  local compare = require('cmp.config.compare')
  local types = require('cmp.types')
  local copilot = require('copilot_cmp').setup()

  -- local tabnine = require('cmp_tabnine.config')

  -- tabnine:setup({
  --   max_lines = 1000,
  --   max_num_results = 20,
  --   sort = true,
  --   priority = 5000,
  --   show_prediction_strength = true,
  --   run_on_every_keystroke = true,
  --   -- snippet_placeholder = '';
  -- })

  local source_mapping = {
    buffer = '[Buffer]',
    nvim_lsp = '[LSP]',
    nvim_lua = '[Lua]',
    -- cmp_tabnine = '[TN]',
    -- cmp_ai = '[AI]',
    supermaven = '[SuperMaven]',
    -- copilot = '[Copilot]',
    path = '[Path]',
    calc = '[Calc]',
    treesitter = '[TS]',
    fuzzy_buffer = '[FZ]',
  }


  local comparators = {
    -- require('copilot_cmp.comparators').prioritize,
    -- require('cmp_ai.compare'),
    require('cmp_fuzzy_buffer.compare'),
    compare.offset,
    compare.exact,
    compare.score,
    compare.recently_used,
    compare.locality,
    compare.kind,
    compare.sort_text,
    compare.length,
    compare.order,
  }

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.snippet.expand(args.body)
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    completion = {
      autocomplete = { types.cmp.TriggerEvent.InsertEnter, types.cmp.TriggerEvent.TextChanged },
      keyword_length = 1,
    },
    confirmation = {
      default_behavior = cmp.ConfirmBehavior.Replace,
    },
    sorting = {
      priority_weight = 2,
      comparators = comparators,
    },

    -- You must set mapping.
    mapping = {
      ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-e>'] = cmp.mapping(cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        { 'i', 'c' }),
      ['<CR>'] = cmp.mapping(function(fallback)
        if cmp.get_active_entry() then
          cmp.confirm()
        else
          -- require('ultimate-autopair.configs.default.maps.cr').newline()
          fallback()
        end
      end),
      -- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }), { 'i', 'c' }),
      ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert }, { 'i', 'c' })
        elseif vim.snippet.active({ direction = 1 }) then
          vim.snippet.jump(1)
        else
          fallback()
        end
      end, { 'i', 'c' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert }, { 'i', 'c' })
        elseif vim.snippet.active({ direction = -1 }) then
          vim.snippet.jump(-1)
        else
          fallback()
        end
      end, { 'i', 'c' }),
    },
    formatting = {
      -- format = lspkind.cmp_format({
      --   mode = "symbol",
      --   max_width = 80,
      --   symbol_map = { copilot = "" }
      -- }),
      format = function(entry, vim_item)
        vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = 'symbol' })
        vim_item.menu = source_mapping[entry.source.name]
        if entry.source.name == 'copilot' or entry.source.name == 'supermaven' then
          local detail = (entry.completion_item.labelDetails or {}).detail
          vim_item.kind = ''
          if detail and detail:find('.*%%.*') then
            vim_item.kind = vim_item.kind .. ' ' .. detail
          end

          if (entry.completion_item.data or {}).multiline then
            vim_item.kind = vim_item.kind .. ' ' .. '[ML]'
          end
        end

        local maxwidth = 80
        vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
        return vim_item
      end,
    },

    matching = {
      disallow_fuzzy_matching = false,
      disallow_partial_fuzzy_matching = false,
      disallow_partial_matching = false,
      disallow_prefix_unmatching = false,
    },
    -- You should specify your *installed* sources.
    sources = cmp.config.sources({
      -- { name = 'copilot', keyword_length = 0 },
      { name = 'supermaven' ,keyword_length = 0 },
      {
        name = 'fuzzy_buffer',
        option = {
          max_match_length = 150,
          get_bufnrs = function()
            local bufs = { vim.api.nvim_get_current_buf() }
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.api.nvim_buf_is_loaded(buf) and buf ~= bufs[1] then
                local buftype = vim.bo[buf].buftype
                if buftype ~= 'nofile' and buftype ~= 'prompt' then
                  bufs[#bufs + 1] = buf
                end
              end
            end
            return bufs
          end,
        },
      },
      { name = 'nvim_lsp' },
      { name = 'nvim_lua' },
      { name = 'nvim_lsp_signature_help' },
      { name = 'treesitter' },
      -- { name = 'buffer' },
      { name = 'path' },
      { name = 'emoji' },
      { name = 'calc' },
      -- { name = 'fuzzy_path' },
    }),

    preselect = cmp.PreselectMode.None,

    experimental = {
      ghost_text = true,
    },

    view = {
      entries = { name = 'custom', selection_order = 'near_cursor', follow_cursor = true },
    },
  })

  cmp.setup.cmdline({ '/', '?' }, {
    view = {
      entries = { name = 'custom', separator = '|' },
    },
    sources = cmp.config.sources({
      {
        name = 'fuzzy_buffer',
        option = {
          get_bufnrs = function()
            return { vim.api.nvim_get_current_buf() }
          end,
        },
      },
    }),
  })

  cmp.setup.cmdline(':', {
    view = {
      entries = { name = 'custom', selection_order = 'near_cursor' },
    },
    sources = cmp.config.sources({
      {
        name = 'fuzzy_path',
        option = {
          fd_cmd = { 'fd', '-d', '20', '-p', '-i' },
        },
      },
    }, {
      { name = 'cmdline' },
    }),
  })

  -- cmp.setup.cmdline(':', {
  --   mapping = cmp.mapping.preset.cmdline(),
  --   sources = cmp.config.sources({
  --     { name = 'path' },
  --   }, {
  --     { name = 'cmdline' },
  --   }),
  -- })

  cmp.event:on('menu_opened', function(evt)
    if vim.api.nvim_get_mode().mode:sub(1, 1) == 'c' then
      return
    end
    -- local character
    local border
    -- local cursor = vim.api.nvim_win_get_cursor(0)
    -- local row = cursor[1] - 1
    -- local col = cursor[2]

    -- remove_marks()

    if evt.window.bottom_up then
      border = { '╭', '─', '╮', '│', '╯', '↑', '╰', '│' }
    else
      border = { '╭', '↓', '╮', '│', '╯', '─', '╰', '│' }
    end
    vim.api.nvim_win_set_config(evt.window.entries_win.win, {
      border = border,
    })
  end)
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
end

vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", {fg ="#6CC644"})
return {
  {

    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    config = setup,
    lazy = false,
    dependencies = {
      {
        'hrsh7th/cmp-nvim-lsp',
        dependencies = 'onsails/lspkind-nvim',
      },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-calc' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-emoji' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-cmdline' },
      {
        'zbirenbaum/copilot-cmp',
        dependencies = 'zbirenbaum/copilot.lua',
      },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'ray-x/cmp-treesitter' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },
      {
        'tzachar/fuzzy.nvim',
        dependencies = { 'nvim-telescope/telescope-fzf-native.nvim' },
      },
      {
        'tzachar/cmp-fuzzy-buffer',
        dependencies = 'tzachar/fuzzy.nvim',
      },
    },
  },
}
