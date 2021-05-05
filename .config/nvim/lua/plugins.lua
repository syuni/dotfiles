vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()

  -- package manager
  use 'wbthomason/packer.nvim'

  -- color schema
  use {
    'folke/tokyonight.nvim',
    setup = function()
      vim.g.tokyonight_italic_comments = 1
      vim.g.tokyonight_italic_keywords = 1
      vim.g.tokyonight_italic_functions = 1
      vim.g.tokyonight_italic_variables = 0
      vim.g.tokyonight_sidebars = { 'qf', 'vista', 'terminal', 'packer' }
    end,
    config = function()
      vim.cmd [[colorscheme tokyonight]]
    end,
  }

  -- terminal
  use {
    'vimlab/split-term.vim',
    cmd = { 'Term', 'VTerm' },
    setup = function()
      vim.api.nvim_set_keymap('n', '<Leader>ts', '<Cmd>Term<Cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>tv', '<Cmd>VTerm<Cr>', { noremap = true, silent = true })
    end,
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('treesitter')
    end,
  }
  use 'romgrk/nvim-treesitter-context'

  -- explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      vim.g.nvim_tree_follow = 1
      vim.g.nvim_tree_indent_markers = 1
      vim.g.nvim_tree_hide_dotfiles = 0
      vim.g.nvim_tree_git_hl = 1
      vim.api.nvim_set_keymap('n', '<C-n>', '<Cmd>NvimTreeToggle<Cr>', { noremap = true })
    end,
  }
  use {
    'kevinhwang91/rnvimr',
    cmd = { 'RnvimrToggle' },
    setup = function()
      vim.g.rnvimr_ex_enable = 1
      vim.api.nvim_set_keymap('n', '<Leader>r', '<Cmd>RnvimrToggle<Cr>', { noremap = true })
    end,
  }

  -- buffer
  use {
    'moll/vim-bbye',
    cmd = { 'Bdelete' },
    setup = function()
      vim.api.nvim_set_keymap('n', '<Leader>bd', '<Cmd>Bdelete<Cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>bad', ':bufdo :Bdelete<Cr>', { noremap = true, silent = true })
    end,
  }
  use {
    'akinsho/nvim-bufferline.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('bufferline').setup()
      vim.api.nvim_set_keymap('n', '<Leader>bs', '<Cmd>BufferLinePick<Cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>bp', '<Cmd>BufferLineCyclePrev<Cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>bn', '<Cmd>BufferLineCycleNext<Cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<A-,>', '<Cmd>BufferLineCyclePrev<Cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<A-.>', '<Cmd>BufferLineCycleNext<Cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<A-<>', '<Cmd>BufferLineMovePrev<Cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<A->>', '<Cmd>BufferLineMoveNext<Cr>', { noremap = true, silent = true })
    end,
  }

  -- bufferline / statusline
  use {
    'glepnir/galaxyline.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
        require('eviline')
      end,
  }

  -- finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-lua/popup.nvim' },
    cmd = { 'Telescope' },
    setup = function()
      vim.api.nvim_set_keymap('n', '<C-s>', '<Cmd>Telescope current_buffer_fuzzy_find<Cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<Leader>ff', '<Cmd>Telescope find_files<Cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<Leader>fg', '<Cmd>Telescope live_grep<Cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<Leader>fb', '<Cmd>Telescope buffers<Cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<Leader>fh', '<Cmd>Telescope help_tags<Cr>', { noremap = true })
      vim.api.nvim_set_keymap('n', '<Leader>fs', '<Cmd>Telescope symbols<Cr>', { noremap = true })
    end
  }
  use {
    'nvim-telescope/telescope-symbols.nvim',
    requires = { 'nvim-telescope/telescope.nvim' }
  }

  -- list
  use 'Valloric/ListToggle'

  -- zen
  use {
    'junegunn/goyo.vim',
    cmd = { 'Goyo' },
    setup = function()
      vim.g.goyo_width = 120
      vim.g.goyo_height = '85%'
      vim.g.goyo_linenr = 0
    end,
  }

  -- git support
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('gitsigns').setup()
    end,
  }

  -- editor support
  use {
    'Yggdroot/indentLine',
    config = function()
      vim.g.indentLine_enabled = 1
    end,
  }
  use 'lukas-reineke/indent-blankline.nvim'
  use {
    'luochen1990/rainbow',
    config = function()
      vim.g.rainbow_active = 1
    end,
  }
  use {
    'easymotion/vim-easymotion',
    config = function()
      vim.g.EasyMotion_do_mapping = 0
      vim.g.EasyMotion_smartcase = 0
      vim.g.EasyMotion_use_migemo = 1
      vim.api.nvim_set_keymap('n', 's', '<Plug>(easymotion-bd-f2)', {})
      vim.api.nvim_set_keymap('n', 'S', '<Plug>(easymotion-overwin-f2)', {})
    end,
  }
  use {
    'scrooloose/nerdcommenter',
    config = function()
      vim.g.NERDSpaceDelims = 1
      vim.g.NERDDefaultAlign = 'left'
    end,
  }
  use 'Raimondi/delimitMate'
  use 'editorconfig/editorconfig-vim'
  use 'tpope/vim-surround'
  use 'andymass/vim-matchup'

  -- syntax check
  use {
    'dense-analysis/ale',
    config = function()
      vim.g.ale_linters = {
        javascript = { 'eslint' },
        javascriptreact = { 'eslint' },
        typescript = { 'eslint' },
        typescriptreact = { 'eslint' },
        vue = { 'eslint' },
        svelte = { 'eslint' },
        go = { 'govet' },
        rust = { 'rls' },
        python = { 'flake8', 'mypy' },
        terraform = { 'terraform' },
      }
      vim.g.ale_fixers = {
        javascript = { 'prettier', 'eslint' },
        javascriptreact = { 'prettier', 'eslint' },
        typescript = { 'prettier', 'eslint' },
        typescriptreact = { 'prettier', 'eslint' },
        vue = { 'eslint' },
        svelte = { 'eslint' },
        go = { 'goimports' },
        rust = { 'rustfmt' },
        python = { 'black', 'isort' },
        terraform = { 'terraform' },
      }
      vim.g.ale_disable_lsp = 1
      vim.g.ale_linters_explicit = 1
      vim.g.ale_sign_column_always = 1
      vim.g.ale_fix_on_save = 1
      vim.g.ale_completion_enabled = 0
      vim.g.ale_echo_msg_error_str = 'E'
      vim.g.ale_echo_msg_warning_str = 'W'
      vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
      vim.g.ale_sign_error = ''
      vim.g.ale_sign_warning = ''
      vim.g.ale_sign_info = ''
      vim.g.ale_set_loclist = 1
      vim.g.ale_set_quickfix = 0
      vim.g.ale_open_list = 0
      vim.g.ale_keep_list_window_open = 0
      vim.api.nvim_set_keymap('n', ']a', '<Plug>(ale_next_wrap)', { silent = true })
      vim.api.nvim_set_keymap('n', '[a', '<Plug>(ale_previous_wrap)', { silent = true })
    end,
  }

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    requires = { 'ray-x/lsp_signature.nvim' },
    config = function()
      require('lsp')
    end,
  }
  use {
    'glepnir/lspsaga.nvim',
    config = function()
      require('lspsaga').init_lsp_saga{
        error_sign = '',
        warn_sign = '',
        hint_sign = '',
        infor_sign = '',
      }
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', 'gd', '<Cmd>Lspsaga lsp_finder<CR>', opts)
      vim.api.nvim_set_keymap('n', 'gr', '<Cmd>Lspsaga rename<CR>', opts)
      vim.api.nvim_set_keymap('n', 'gs', '<Cmd>Lspsaga signature_help<CR>', opts)
      vim.api.nvim_set_keymap('n', 'K', '<Cmd>Lspsaga hover_doc<CR>', opts)
      vim.api.nvim_set_keymap('n', '<C-f>', '<Cmd>lua require("lspsaga.action").smart_scroll_with_saga(1)<CR>', opts)
      vim.api.nvim_set_keymap('n', '<C-b>', '<Cmd>lua require("lspsaga.action").smart_scroll_with_saga(-1)<CR>', opts)
      vim.api.nvim_set_keymap('n', '<leader><leader>ca', '<Cmd>Lspsaga code_action<CR>', opts)
      vim.api.nvim_set_keymap('v', '<leader><leader>ca', ':<C-u>Lspsaga range_code_action<CR>', opts)
      vim.api.nvim_set_keymap('n', ']d', '<Cmd>Lspsaga diagnostic_jump_next<CR>', opts)
      vim.api.nvim_set_keymap('n', '[d', '<Cmd>Lspsaga diagnostic_jump_prev<CR>', opts)
      vim.api.nvim_set_keymap('n', '<A-t>', '<Cmd>Lspsaga open_floaterm<CR>', opts)
      vim.api.nvim_set_keymap('t', '<A-t>', '<C-\\><C-n><Cmd>Lspsaga close_floaterm<CR>', opts)
    end,
  }
  use {
    'hrsh7th/nvim-compe',
    config = function()
      vim.o.completeopt = 'menuone,noselect'
      require('compe').setup{
        source = {
          path = true,
          buffer = true,
          calc = true,
          nvim_lsp = true,
          nvim_lua = true,
          vsnip = false,
          emoji = false,
        },
      }
      local opts_expr = { noremap = true, silent = true, expr = true }
      vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', opts_expr)
      vim.api.nvim_set_keymap('i', '<CR>', 'compe#confirm({ "keys": "<Plug>delimitMateCR", "mode": "" })', opts_expr)
      vim.api.nvim_set_keymap('i', '<C-e>', 'compe#close("<C-e>")', opts_expr)
      vim.api.nvim_set_keymap('i', '<C-f>', 'compe#scroll({ "delta": +4 })', opts_expr)
      vim.api.nvim_set_keymap('i', '<C-b>', 'compe#scroll({ "delta": -4 })', opts_expr)
    end,
  }
  use {
    'onsails/lspkind-nvim',
    config = function()
      require('lspkind').init()
    end,
  }
  use {
    'folke/lsp-trouble.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function()
      require('trouble').setup{}
      vim.api.nvim_set_keymap('n', '<Leader>d', '<Cmd>LspTroubleToggle<CR>', { noremap = true, silent = true })
    end,
  }
  use {
    'folke/lsp-colors.nvim',
    config = function()
      require('lsp-colors').setup{}
    end,
  }
  use {
    'liuchengxu/vista.vim',
    cmd = { 'Vista' },
    setup = function()
      vim.g.vista_default_executive = 'nvim_lsp'
      vim.g.vista_icon_indent = { '╰─▸ ', '├─▸ ' }
      vim.api.nvim_set_keymap('n', '<C-]>', '<Cmd>Vista!!<Cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-\\>', '<Cmd>Vista finder<Cr>', { noremap = true, silent = true })
    end,
  }

  -- syntax highlight / language supports
  use 'sheerun/vim-polyglot'
  use 'jceb/vim-orgmode'
  use {
    'kovisoft/slimv',
    ft = { 'lisp' },
    setup = function()
      vim.g.slimv_swank_cmd = "!ros -e '(ql:quickload :swank) (swank:create-server)' wait > /dev/null 2> /dev/null &"
      vim.g.slimv_lisp = 'ros run'
      vim.g.slimv_impl = 'sbcl'
      vim.g.slimv_repl_split = 2
    end,
  }
end)