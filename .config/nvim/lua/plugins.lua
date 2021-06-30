vim.cmd [[packadd packer.nvim]]

require('packer').startup(function()

  -- package manager
  use 'wbthomason/packer.nvim'

  -- color schema
  use {
    'Mofiqul/dracula.nvim',
    config = function()
      vim.cmd [[colorscheme dracula]]
      vim.cmd [[highlight StatusLine guibg=#202328]]
    end,
  }

  -- treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function()
      require('treesitter')
    end,
  }
  use 'p00f/nvim-ts-rainbow'

  -- explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      vim.g.nvim_tree_width = 40
      vim.g.nvim_tree_follow = 1
      vim.g.nvim_tree_indent_markers = 1
      vim.g.nvim_tree_hide_dotfiles = 0
      vim.g.nvim_tree_git_hl = 1
      vim.api.nvim_set_keymap('n', '<C-n>', '<Cmd>NvimTreeToggle<Cr>', { noremap = true, silent = true })
    end,
  }
  use {
    'kevinhwang91/rnvimr',
    cmd = { 'RnvimrToggle' },
    setup = function()
      vim.g.rnvimr_ex_enable = 1
      vim.api.nvim_set_keymap('n', '<Leader>r', '<Cmd>RnvimrToggle<Cr>', { noremap = true, silent = true })
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
      require('bufferline').setup{
        options = {
          offsets = {
            {filetype = 'NvimTree', text = 'Explorer', highlight = 'Directory', text_align = 'left'},
            {filetype = 'vista_kind', text = 'Outline', highlight = 'Directory', text_align = 'left'},
          },
        },
      }
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', '<Leader>bs', '<Cmd>BufferLinePick<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>bp', '<Cmd>BufferLineCyclePrev<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>bn', '<Cmd>BufferLineCycleNext<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<A-,>', '<Cmd>BufferLineCyclePrev<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<A-.>', '<Cmd>BufferLineCycleNext<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<A-<>', '<Cmd>BufferLineMovePrev<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<A->>', '<Cmd>BufferLineMoveNext<Cr>', opts)
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
    config = function()
      local opts = { noremap = true, silent = true }
      -- common finders
      vim.api.nvim_set_keymap('n', '<C-s>', '<Cmd>Telescope current_buffer_fuzzy_find theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>ff', '<Cmd>Telescope find_files find_command=rg,--files theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>fF', '<Cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>fg', '<Cmd>Telescope live_grep theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>fb', '<Cmd>Telescope buffers theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>fh', '<Cmd>Telescope help_tags theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>fs', '<Cmd>Telescope symbols theme=get_dropdown<Cr>', opts)
      -- git actions
      vim.api.nvim_set_keymap('n', '<Leader>gc', '<Cmd>Telescope git_commits theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>gC', '<Cmd>Telescope git_bcommits theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>gb', '<Cmd>Telescope git_branches theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>gs', '<Cmd>Telescope git_status theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>gS', '<Cmd>Telescope git_stash theme=get_dropdown<Cr>', opts)
      -- tree sitter
      vim.api.nvim_set_keymap('n', '<Leader>ts', '<Cmd>Telescope treesitter theme=get_dropdown<Cr>', opts)
      -- lsp
      vim.api.nvim_set_keymap('n', 'gd', '<Cmd>Telescope lsp_definitions theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', 'gr', '<Cmd>Telescope lsp_references theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', 'gi', '<Cmd>Telescope lsp_implementations theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>ls', '<Cmd>Telescope lsp_document_symbols theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>lS', '<Cmd>Telescope lsp_workspace_symbols theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>la', '<Cmd>Telescope lsp_code_actions theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>lA', '<Cmd>Telescope lsp_range_code_actions theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>ld', '<Cmd>Telescope lsp_document_diagnostics theme=get_dropdown<Cr>', opts)
      vim.api.nvim_set_keymap('n', '<Leader>lD', '<Cmd>Telescope lsp_workspace_diagnostics theme=get_dropdown<Cr>', opts)
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
  use {
    'folke/todo-comments.nvim',
    requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('todo-comments').setup{}
      vim.api.nvim_set_keymap('n', '<Leader>ft', '<Cmd>TodoTelescope<Cr>', { noremap = true, silent = true })
    end,
  }
  use 'Raimondi/delimitMate'
  use 'editorconfig/editorconfig-vim'
  use 'tpope/vim-surround'
  use 'andymass/vim-matchup'

  -- snippets
  use {
    'SirVer/ultisnips',
    config = function()
      vim.g.UltiSnipsExpandTrigger = '<Tab>'
      vim.g.UltiSnipsJumpForwardTrigger = '<C-f>'
      vim.g.UltiSnipsJumpBackwardTrigger = '<C-b>'
      vim.g.UltiSnipsEditSplit = 'vertical'
    end,
  }
  use 'honza/vim-snippets'

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
      vim.api.nvim_set_keymap('n', ']a', '<Plug>(ale_next_wrap)', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '[a', '<Plug>(ale_previous_wrap)', { noremap = true, silent = true })
    end,
  }

  use {
    'akinsho/nvim-toggleterm.lua',
    config = function()
      require('toggleterm').setup{
        size = 20,
        open_mapping = [[<C-\>]],
        hide_numbers = true,
        direction = 'horizontal',
      }
    end,
  }

  -- lsp
  use {
    'neovim/nvim-lspconfig',
    requires = { 'ray-x/lsp_signature.nvim' },
    config = function()
      require('lsp')
      local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
      for type, icon in pairs(signs) do
        local hl = "LspDiagnosticsSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
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
          ultisnips = true,
          emoji = false,
        },
      }
      local opts = { noremap = true, silent = true, expr = true }
      vim.api.nvim_set_keymap('i', '<C-Space>', 'compe#complete()', opts)
      vim.api.nvim_set_keymap('i', '<Cr>', 'compe#confirm({ "keys": "<Plug>delimitMateCR", "mode": "" })', opts)
      vim.api.nvim_set_keymap('i', '<C-e>', 'compe#close("<C-e>")', opts)
      vim.api.nvim_set_keymap('i', '<C-f>', 'compe#scroll({ "delta": +4 })', opts)
      vim.api.nvim_set_keymap('i', '<C-b>', 'compe#scroll({ "delta": -4 })', opts)
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
      vim.api.nvim_set_keymap('n', '<Leader>d', '<Cmd>LspTroubleToggle<Cr>', { noremap = true, silent = true })
    end,
  }
  use {
    'liuchengxu/vista.vim',
    cmd = { 'Vista' },
    setup = function()
      vim.g.vista_default_executive = 'nvim_lsp'
      vim.g.vista_icon_indent = { '╰─▸ ', '├─▸ ' }
      vim.api.nvim_set_keymap('n', '<Leader>vv', '<Cmd>Vista!!<Cr>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>vf', '<Cmd>Vista finder<Cr>', { noremap = true, silent = true })
    end,
  }

  -- syntax highlight / language supports
  use {
    'sheerun/vim-polyglot',
    config = function()
      -- markdown
      vim.g.vim_markdown_conceal = 0
      vim.g.vim_markdown_conceal_code_blocks = 0
    end,
  }
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
