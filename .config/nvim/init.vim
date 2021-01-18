autocmd!

" ### general settings (file)
" charset
scriptencoding utf-8
set enc=utf-8
set fenc=utf-8
set ambiwidth=single
" don't make backupfile
set nobackup
" don't make swapfile
set noswapfile
" autoreload file
set autoread
" enable open file While editing the current buffer
set hidden
" show entering command
set showcmd

" ### general settings (editor)
" don't show splash
set shortmess+=I
" don't show menubar & toolbar & scrollbar
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b
" show line numbers
set number
" show cursorline
set cursorline
" cursorshape
let &t_SI .= "\e[5 q"
let &t_EI .= "\e[1 q"
let &t_SR .= "\e[3 q"
" one character ahead of the end of the line
set virtualedit=onemore
" smart indent
set smartindent
" don't flash screen
set visualbell t_vb=
" move to corresponding parenthesis
set showmatch
set matchtime=1
" expand %
source $VIMRUNTIME/macros/matchit.vim
" show to the end
set display=lastline
" always display
set laststatus=2
" TAB completion (listing matches, complement the common longest part)
set wildmode=list:longest
set wildmenu
" indent
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
set smartindent
" display completion candidates for 10 lines
set pumheight=10
" share with clipboard
set clipboard&
set clipboard^=unnamed,unnamedplus
" always show signcolumn
set signcolumn=yes
" delete backword
set whichwrap=b,s,h,l,<,>,[,],~
set backspace=indent,eol,start
" no wrap word
set nowrap
" hidden mode info
set noshowmode
" leave from insert mode by `jj`
inoremap <silent> jj <ESC>
" yank from current column to end of line
nnoremap <silent> Y y$
" window
set splitbelow
set splitright
" conceal
let g:tex_conceal=""
" move
nnoremap <silent> <A-h> <C-w>h
nnoremap <silent> <A-j> <C-w>j
nnoremap <silent> <A-k> <C-w>k
nnoremap <silent> <A-l> <C-w>l

" ### general settings (search)
" ignore uppercase and lowercase
set ignorecase
" consider uppercase and lowercase, when capital letters are included
set smartcase
" use incremental search
set incsearch
" circular search
set wrapscan
" highlight search word
set hlsearch
" clear highlight
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" ### general settings (keys)
let mapleader="\<Space>"
nnoremap [coc] <Nop>
nmap <Leader>i [coc]
nnoremap [finder] <Nop>
nmap <Leader>f [finder]
nnoremap [ale] <Nop>
nmap <Leader>a [ale]
nnoremap [buf] <Nop>
nmap <Leader>b [buf]
nnoremap [term] <Nop>
nmap <Leader>t [term]

" ### diff
set diffopt=internal,vertical,filler,algorithm:histogram,indent-heuristic
autocmd WinEnter * if(winnr('$') == 1) && (getbufvar(winbufnr(0), '&diff')) == 1 | diffoff | endif
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

" ### nvim clients
let g:python_host_prog='/usr/bin/python2'
let g:python3_host_prog='/usr/bin/python3'
let g:ruby_host_prog='/usr/bin/neovim-ruby-host'
let g:node_host_prog='/usr/bin/neovim-node-host'

" ### Language Pack
" polyglot
let g:polyglot_disabled=['lisp']

" ### packages
" dein Scripts-----------------------------
if &compatible
  set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  " setup
  call dein#begin('~/.cache/dein')
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " ime
  call dein#add('fuenor/im_control.vim')

  " color schema
  call dein#add('joshdick/onedark.vim')

  " terminal
  call dein#add('vimlab/split-term.vim')

  " explorer
  call dein#add('kyazdani42/nvim-tree.lua')

  " ranger
  call dein#add('kevinhwang91/rnvimr', { 'do': 'make sync' })

  " status line
  call dein#add('glepnir/galaxyline.nvim')

  " rainbow
  call dein#add('luochen1990/rainbow')

  " quickfix/location-list
  call dein#add('Valloric/ListToggle')

  " easy-motion
  call dein#add('easymotion/vim-easymotion')

  " buffer
  call dein#add('romgrk/barbar.nvim')

  " indent
  call dein#add('Yggdroot/indentLine')

  " comment
  call dein#add('scrooloose/nerdcommenter')

  " finder
  call dein#add('junegunn/fzf', { 'build': './install --bin', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('nvim-lua/popup.nvim')
  call dein#add('nvim-lua/plenary.nvim')
  call dein#add('nvim-telescope/telescope.nvim')
  call dein#add('nvim-telescope/telescope-symbols.nvim')

  " zen
  call dein#add('junegunn/goyo.vim')

  " formatter
  call dein#add('editorconfig/editorconfig-vim')
  call dein#add('tpope/vim-surround')

  " match
  call dein#add('andymass/vim-matchup')

  " git
  call dein#add('tpope/vim-fugitive')
  call dein#add('mhinz/vim-signify')

  " snippet
  call dein#add('honza/vim-snippets')

  " syntaxcheck
  call dein#add('w0rp/ale')

  " completion (lsp)
  call dein#add('neoclide/coc.nvim', { 'merged':0, 'rev': 'release' })
  call dein#add('liuchengxu/vista.vim')

  " tree sitter
  call dein#add('nvim-treesitter/nvim-treesitter')
  call dein#add('romgrk/nvim-treesitter-context')

  " language pack
  call dein#add('sheerun/vim-polyglot')

  " org-mode
  call dein#add('jceb/vim-orgmode')

  " markdown
  call dein#add('godlygeek/tabular')
  call dein#add('plasticboy/vim-markdown')

  " svelte
  call dein#add('evanleck/vim-svelte')

  " elm
  call dein#add('andys8/vim-elm-syntax')

  " haskell
  call dein#add('dag/vim2hs')

  " nim
  call dein#add('zah/nim.vim')

  " lisp
  call dein#add('kovisoft/slimv')
  
  " fish
  call dein#add('dag/vim-fish')

  " icons
  call dein#add('kyazdani42/nvim-web-devicons')

  call dein#end()
  call dein#save_state()
endif
" End dein Scripts-------------------------

filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

syntax on

if !has('gui_running')
  set t_Co=256
endif
if has('termguicolors')
  set termguicolors
endif

colorscheme onedark

" ### Packages
" terminal (& split-term.vim)
autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
nnoremap <silent> [term]s :Term<CR>
nnoremap <silent> [term]v :VTerm<CR>

" ime
let IM_CtrlMode = 1
inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
function! IMCtrl(cmd)
  let cmd = a:cmd
  if cmd == 'On'
    let res = system('fcitx-remote -o')
  elseif cmd == 'Off'
    let res = system('fcitx-remote -c')
  endif
  return ''
endfunction

" rainbow
let g:rainbow_active=1

" nvimtree
let g:lua_tree_side='left'
let g:lua_tree_width=40
let g:lua_tree_quit_on_open=0 
let g:lua_tree_follow=1
let g:lua_tree_indent_markers=1
let g:lua_tree_hide_dotfiles=0
let g:lua_tree_git_hl=1
let g:lua_tree_allow_resize=1
let g:lua_tree_icons = {
  \ 'default': '',
  \ 'symlink': '',
  \ 'git': {
  \   'unstaged': "✗",
  \   'staged': "✓",
  \   'unmerged': "",
  \   'renamed': "➜",
  \   'untracked': "★"
  \   },
  \ 'folder': {
  \   'default': "",
  \   'open': ""
  \   }
  \ }
nnoremap <C-n> :NvimTreeToggle<CR>

" vista
nnoremap <silent> <C-]> :Vista!!<CR>
nnoremap <silent> <C-\> :Vista finder<CR>
let g:vista_default_executive='coc'
let g:vista_icon_indent=['╰─▸ ', '├─▸ ']
let g:vista#renderer#enable_icon=1

" easy-motion
let g:EasyMotion_do_mapping=0
let g:EasyMotion_smartcase=1
nmap s <Plug>(easymotion-bd-f2)
nmap S <Plug>(easymotion-overwin-f2)
nmap <Leader><Leader>f <Plug>(easymotion-bd-f)
nmap <Leader><Leader>F <Plug>(easymotion-overwin-f)
nmap <Leader><Leader>w <Plug>(easymotion-bd-w)
nmap <Leader><Leader>W <Plug>(easymotion-overwin-w)

" barbar.nvim
nnoremap <silent> [buf]s :BufferPick<CR>
nnoremap <silent> <A-,> :BufferPrevious<CR>
nnoremap <silent> <A-.> :BufferNext<CR>
nnoremap <silent> <A-<> :BufferMovePrevious<CR>
nnoremap <silent> <A->> :BufferMoveNext<CR>
nnoremap <silent> [buf]d :BufferClose<CR>
nnoremap <silent> [buf]ad :bufdo :BufferClose<CR>
nnoremap <silent> [buf]D :bd<CR>
nnoremap <silent> [buf]aD :bufdo :bd<CR>
nnoremap <silent> [buf]od :BufferOrderByDirectory<CR>
nnoremap <silent> [buf]ol :BufferOrderByLanguage<CR>

" indentLine
set list lcs=tab:\|\ 
let g:indentLine_enabled=1

" nerdcommenter
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'

" rnvimr
let g:rnvimr_ex_enable = 1
nmap <space>r :RnvimrToggle<CR>

" telescope
nnoremap <C-s> :Telescope current_buffer_fuzzy_find<CR>
nnoremap [finder]f :Telescope find_files<CR>
nnoremap [finder]g :Telescope live_grep<CR>
nnoremap [finder]b :Telescope buffers<CR>
nnoremap [finder]h :Telescope help_tags<CR>
nnoremap [finder]s :Telescope symbols<CR>

" ale
let g:ale_linters={
  \ 'javascript': ['eslint'],
  \ 'javascriptreact': ['eslint'],
  \ 'typescript': ['eslint'],
  \ 'typescriptreact': ['eslint'],
  \ 'vue': ['eslint'],
  \ 'svelte': ['eslint'],
  \ 'dart': ['dartanalyzer'],
  \ 'go': ['golangci-lint'],
  \ 'rust': ['rls'],
  \ 'haskell': ['hlint'],
  \ 'python': ['flake8', 'mypy'],
  \ 'ocaml': ['ols'],
  \ 'elm': ['elm_ls'],
  \ 'terraform': ['terraform']
  \ }
let g:ale_fixers={
  \ 'javascript': ['prettier', 'eslint'],
  \ 'javascriptreact': ['prettier', 'eslint'],
  \ 'typescript': ['prettier', 'eslint'],
  \ 'typescriptreact': ['prettier', 'eslint'],
  \ 'vue': ['eslint'],
  \ 'svelte': ['eslint'],
  \ 'dart': ['dartfmt'],
  \ 'go': ['goimports'],
  \ 'rust': ['rustfmt'],
  \ 'haskell': ['stylish-haskell'],
  \ 'python': ['black', 'isort'],
  \ 'ocaml': ['ocamlformat', 'ocp-indent'],
  \ 'elm': ['elm-format'],
  \ 'terraform': ['terraform']
  \ }
let g:ale_linters_explicit=1
let g:ale_sign_column_always=1
let g:ale_fix_on_save=1
let g:ale_completion_enabled=0
let g:ale_echo_msg_error_str='E'
let g:ale_echo_msg_warning_str='W'
let g:ale_echo_msg_format='[%linter%] %s [%severity%]'
let g:ale_sign_error='✘'
let g:ale_sign_warning='⚠'
let g:ale_sign_info='✔'
let g:ale_set_loclist=1
let g:ale_set_quickfix=0
let g:ale_open_list=0
let g:ale_keep_list_window_open=0
let g:ale_rust_cargo_use_clippy=executable('cargo-clippy')
let g:ale_ocaml_ocamlformat_options='--enable-outside-detected-project'
nmap <silent> <C-S-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-S-j> <Plug>(ale_next_wrap)
nmap <silent> [ale]f <Plug>(ale_fix)

" coc
let g:coc_global_extensions=['coc-marketplace', 'coc-highlight', 'coc-json', 'coc-pairs', 'coc-python', 'coc-rls', 'coc-rust-analyzer', 'coc-tsserver', 'coc-css', 'coc-html', 'coc-yaml', 'coc-vetur', 'coc-angular', 'coc-svelte', 'coc-flutter', 'coc-snippets', 'coc-xml', 'coc-svg', 'coc-vimlsp', 'coc-java', 'coc-fish']

set nowritebackup
set updatetime=100

" Use <c-space> to trigger completion.
imap <Nul> <C-Space>
inoremap <silent><expr> <C-Space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[a` and `]a` to navigate diagnostics
nmap <silent> [a <Plug>(coc-diagnostic-prev)
nmap <silent> ]a <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap [coc]rn <Plug>(coc-rename)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Fix autofix problem of current line
nmap [coc]qf <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> [coc]a :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> [coc]e :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> [coc]c :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> [coc]o :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> [coc]s :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> [coc]j :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> [coc]k :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> [coc]p :<C-u>CocListResume<CR>

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" ### Markdown
" vim-markdown
let g:vim_markdown_conceal=0
let g:vim_markdown_conceal_code_blocks=0
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_toc_autofit=1
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1
let g:vim_markdown_toml_frontmatter=1
let g:vim_markdown_json_frontmatter=1

" ### Golang
au BufNewFile,BufRead *.go setl sw=4 ts=4 sts=4 noet

" ### Javascript
autocmd BufReadPost,BufNewFile *_spec.js,*Spec.js set filetype=javascript syntax=javascript
let g:vue_pre_processors='detect_on_enter'

" ### Elm
au BufNewFile,BufRead *.elm setl sw=4 ts=4 sts=4

" ### Haskell
au BufNewFile,BufRead *.hs setl sw=4 ts=4 sts=4
" vim2hs
let g:haskell_conceal=0
let g:haskell_conceal_enumerations=0

" ### Lisp
" slimv
let g:slimv_swank_cmd="!ros -e '(ql:quickload :swank) (swank:create-server)' wait > /dev/null 2> /dev/null &"
let g:slimv_lisp='ros run'
let g:slimv_impl='sbcl'
let g:slimv_repl_split=2

" ### zen
" goyo.vim
let g:goyo_width=120
let g:goyo_height='85%'
let g:goyo_linenr=0

" ### Lua plugins
lua require('treesitter')
lua require('eviline')

" ### Load local .vimrc
function! s:openLocalConfig()
  let currentDir = getcwd()
  let fsRoorDir = fnamemodify($HOME, ":p:h:h:h")

  if currentDir == $HOME
    return
  endif

  while isdirectory(currentDir) && !(currentDir ==# $HOME) && !(currentDir ==# fsRoorDir)
    if isdirectory(currentDir.'/.vim') && filereadable(currentDir.'/.vim/vimrc')
      execute 'source '.currentDir.'/.vim/vimrc'
      return
    endif
    let currentDir = fnamemodify(currentDir, ':p:h:h')
  endwhile

endfunction
call s:openLocalConfig()
