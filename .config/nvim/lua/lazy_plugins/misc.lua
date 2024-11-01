return {
  {
    'echasnovski/mini.hipatterns',
    -- event = "BufReadPre",
    config = function()
      require('mini.hipatterns').setup({
        highlighters = {
          -- Hex colours
          hex_colour = require('mini.hipatterns').gen_highlighter.hex_color(),
        },
      })
    end,
  },
  {
    'LunarVim/bigfile.nvim',
    opts = {
      filesize = 2,
      pattern = { '*' },
    },
  },
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {
      modes = {
        search = {
          enabled = false,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    },
  },
  {
    'norcalli/nvim-terminal.lua',
    opts = {},
  },

  -- zephyr-nvim dependencies nvim-treesitter
  -- use {'glepnir/zephyr-nvim', branch = 'main', dependencies = 'nvim-treesitter/nvim-treesitter'}
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    enabled = true,
    config = function()
      require('tokyonight').setup({
        style = 'night',
        transparent = false,
      })
      vim.cmd('colorscheme tokyonight')
    end,
  },
  -- jump to last place
  { 'farmergreg/vim-lastplace' },
  {
    'vim-scripts/ExtractMatches',
    cmd = {
      'GrepToReg',
      'GrepRangeToReg',
      'YankMatches',
      'YankUniqueMatches',
      'PrintMatches',
      'PrintUniqueMatches',
      'SubstituteAndYank',
      'SubstituteAndYankUnique',
      'PutMatches',
      'PutUniqueMatches',
    },
    dependencies = { 'vim-scripts/ingo-library' },
  },

  -- c cpp stuff
  {
    'tpope/vim-repeat',
    event = 'VeryLazy',
  },
  { 'vim-scripts/dbext.vim', ft = 'sql', enabled = false },
  {
    'wellle/targets.vim',
    event = 'VeryLazy',
  },
  {
    'tommcdo/vim-exchange',
    keys = { 'cx', nil, mode = { 'n', 'v' } },
  },
  -- { "vim-scripts/TextTransform" },

  { 'godlygeek/tabular', cmd = 'Tabularize' },

  -- add cmd utils as vim commands
  {
    'tpope/vim-eunuch',
    cmd = {
      'Delete',
      'Unlink',
      'Remove',
      'Move',
      'Rename',
      'Chmod',
      'Mkdir',
      'Cfind',
      'Lfind',
      'Clocate',
      'Llocate',
      'SudoEdit',
      'SudoWrite',
    },
  },

  -- show mappings
  {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup({})
    end,
    event = 'VeryLazy',
  },

  -- align on character
  {
    'tommcdo/vim-lion',
    keys = {
      { 'gl', nil, desc = 'align right on character', mode = { 'n', 'v' } },
      { 'gL', nil, desc = 'align left on character', mode = { 'n', 'v' } },
    },
  },

  {
    'ntpeters/vim-better-whitespace',
    event = 'VeryLazy',
  },
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    config = function()
      require('git-conflict').setup({
        default_mappings = false,
      })
    end,
  },

  -- dev icons
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      -- load devicons
      require('nvim-web-devicons').setup({
        default = true,
      })
    end,
  },

  { 'dstein64/vim-startuptime', cmd = { 'StartupTime' } },

  -- user defined text objects
  {
    'kana/vim-textobj-user',
    event = 'VeryLazy',
  },
  {
    'Julian/vim-textobj-variable-segment',
    dependencies = { 'kana/vim-textobj-user' },
    event = 'VeryLazy',
  },

  -- trouble
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
    cmd = { 'Trouble' },
  },
  {
    'smjonas/inc-rename.nvim',
    cmd = 'IncRename',
    keys = {
      {
        'gt',
        function()
          return ':IncRename ' .. vim.fn.expand('<cword>')
        end,
        expr = true,
        desc = 'Incremental rename',
      },
    },
    config = function()
      require('inc_rename').setup()
    end,
  },
  -- live command preview
  {
    'smjonas/live-command.nvim',
    config = function()
      -- live command setup
      require('live-command').setup({
        commands = {
          Norm = { cmd = 'norm' },
        },
      })
    end,
    event = 'VeryLazy',
  },

  -- inc dec
  {
    'monaqa/dial.nvim',
    config = function()
      local augend = require('dial.augend')
      require('dial.config').augends:register_group({
        default = {
          augend.integer.alias.decimal_int,
          augend.integer.alias.hex,
          augend.date.alias['%Y/%m/%d'],
          augend.constant.alias.alpha,
          augend.constant.alias.Alpha,
          augend.integer.alias.binary,
          augend.constant.alias.bool,
          augend.constant.new({ elements = { 'True', 'False' } }),
        },
      })
    end,
    keys = {
      { '<C-a>', '<Plug>(dial-increment)', noremap = true, mode = 'n' },
      { '<C-x>', '<Plug>(dial-decrement)', noremap = true, mode = 'n' },
      { '+',     '<Plug>(dial-increment)', noremap = true, mode = 'n' },
      { '-',     '<Plug>(dial-decrement)', noremap = true, mode = 'n' },
      { '<C-a>', '<Plug>(dial-increment)', noremap = true, mode = 'v' },
      { '<C-x>', '<Plug>(dial-decrement)', noremap = true, mode = 'v' },
      -- these are buggy for now!
      -- {'g<C-a>', require("dial.map").inc_gvisual(), options = {noremap = true} },
      -- {'g<C-x>', require("dial.map").dec_gvisual(), options = {noremap = true} },
    },
  },

  -- ts query builder
  {
    'ziontee113/query-secretary',
    keys = {
      {
        '<leader>z',
        function()
          require('query-secretary').query_window_initiate()
        end,
        noremap = true,
        desc = 'query secretary',
      },
    },
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        disable_filetype = { 'TelescopePrompt' },
        fast_wrap = {
          map = '<M-e>',
          end_key = '$',
        },
      })
    end,
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require('notify')
    end,
  },

  {
    'tzachar/highlight-undo.nvim',
    config = function()
      require('highlight-undo').setup({})
    end,
  },
}
