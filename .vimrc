autocmd!

" ### general settings (file)
" charset
scriptencoding utf-8
set enc=utf-8
set fenc=utf-8
set ambiwidth=double
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
" one character ahead of the end of the line
set virtualedit=onemore
" smart indent
set smartindent
" visual display of all beep sounds
set visualbell
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
set clipboard+=unnamed
" always show signcolumn
set signcolumn=yes
" delete backword
set whichwrap=b,s,h,l,<,>,[,],~
set backspace=indent,eol,start
" show break mark when word is wrapped
set showbreak=↪
" leave from insert mode by `jj`
inoremap <silent> jj <ESC>
" yank from current column to end of line
nnoremap <silent> Y y$

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
nmap <Leader>q [coc]
nnoremap [fzf] <Nop>
nmap <Leader>f [fzf]
nnoremap [ale] <Nop>
nmap <Leader>a [ale]
nnoremap [buf] <Nop>
nmap <Leader>b [buf]

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

  " icons
  call dein#add('ryanoasis/vim-devicons')

  " color schema
  call dein#add('joshdick/onedark.vim')
  call dein#add('arcticicestudio/nord-vim')

  " nerdtree
  call dein#add('scrooloose/nerdtree')

  " lightline
  call dein#add('itchyny/lightline.vim')
  call dein#add('maximbaz/lightline-ale')

  " buffer
  call dein#add('moll/vim-bbye')

  " indent
  call dein#add('Yggdroot/indentLine')

  " comment
  call dein#add('scrooloose/nerdcommenter')

  " fzf
  call dein#add('junegunn/fzf', { 'build': './install --bin', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })

  " formatter
  call dein#add('editorconfig/editorconfig-vim')

  " refactoring
  call dein#add('tpope/vim-surround')

  " git
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')

  " syntaxcheck
  call dein#add('w0rp/ale')

  " completion (lsp)
  call dein#add('neoclide/coc.nvim', { 'build': './install.sh nightly' })

  " markdown
  call dein#add('godlygeek/tabular')
  call dein#add('plasticboy/vim-markdown')

  " language pack
  call dein#add('sheerun/vim-polyglot')

  " javascript
  call dein#add('billyvg/tigris.nvim', { 'build': './install.sh' })

  " haskell
  call dein#add('dag/vim2hs')

  " golang
  call dein#add('fatih/vim-go')

  " rust
  call dein#add('rust-lang/rust.vim')

  call dein#end()
  call dein#save_state()
endif
" End dein Scripts-------------------------

filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

if (empty($TMUX))
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  if (has("termguicolors"))
    set termguicolors
  endif
endif

syntax on
" colorscheme onedark
colorscheme nord

if !has('gui_running')
  augroup TransparentBG
    autocmd!
    autocmd VimEnter,ColorScheme * highlight Normal ctermbg=none
    autocmd VimEnter,ColorScheme * highlight NonText ctermbg=none
    autocmd VimEnter,ColorScheme * highlight LineNr ctermbg=none
    autocmd VimEnter,Colorscheme * highlight Folded ctermbg=none
    autocmd VimEnter,Colorscheme * highlight EndOfBuffer ctermbg=none 
    autocmd VimEnter,ColorScheme * highlight SignColumn ctermbg=none
    autocmd VimEnter,ColorScheme * highlight VertSplit ctermbg=none
  augroup END
endif

" ### Packages
" lightline
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"
set laststatus=2
if !has('gui_running')
  set t_Co=256
endif
let g:lightline = {
  \ 'colorscheme': 'nord',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
  \   'right': [ [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
  \              [ 'lineinfo'],
  \              [ 'percent' ],
  \              [ 'fileformat', 'fileencoding', 'filetype', 'charvaluehex' ] ]
  \ },
  \ 'component': {
  \   'charvaluehex': '0x%B'
  \ },
  \ 'component_function': {
  \   'gitbranch': 'fugitive#head'
  \ },
  \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
  \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
  \ }
let g:lightline.component_expand = {
  \  'linter_checking': 'lightline#ale#checking',
  \  'linter_warnings': 'lightline#ale#warnings',
  \  'linter_errors': 'lightline#ale#errors',
  \  'linter_ok': 'lightline#ale#ok',
  \ }
let g:lightline.component_type = {
  \     'linter_checking': 'left',
  \     'linter_warnings': 'warning',
  \     'linter_errors': 'error',
  \     'linter_ok': 'left',
  \ }

" buffer
nnoremap <silent> [buf]d :Bdelete<CR>
nnoremap <silent> [buf]D :bufdo :Bdelete<CR>
nnoremap <silent> [buf]p :bprevious<CR>
nnoremap <silent> [buf]n :bnext<CR>

" indentLine
let g:indentLine_enabled=1

" nerdcommenter
let g:NERDSpaceDelims=1
let g:NERDDefaultAlign='left'

" vim-devicons
let g:WebDevIconsUnicodeDecorateFolderNodes=1

" nerdtree
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" fzf
let g:fzf_layout={ 'down': '80%' }
let g:fzf_buffers_jump=1
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(),
  \   <bang>0)
nnoremap <silent> <C-s> :BLines<CR>
nnoremap <silent> [fzf]b :Buffers<CR>
nnoremap <silent> [fzf]w :Windows<CR>
nnoremap <silent> [fzf]f :FZF<CR>
nnoremap <silent> [fzf]rg :Rg<CR>
nnoremap <silent> [fzf]r :History<CR>
nnoremap <silent> [fzf]s :Snippets<CR>

" ale
let g:ale_linters={
  \ 'javascript': ['eslint'],
  \ 'javascript.jsx': ['eslint'],
  \ 'go': ['golangci-lint'],
  \ 'rust': ['rls', 'cargo', 'rustc'],
  \ 'haskell': ['hlint'],
  \ 'python': ['flake8']
  \ }
let g:ale_fixers={
  \ 'javascript': ['eslint'],
  \ 'javascript.jsx': ['eslint'],
  \ 'go': ['goimports'],
  \ 'rust': ['rustfmt'],
  \ 'haskell': ['stylish-haskell'],
  \ 'python': ['black', 'isort']
  \ }
let g:ale_linters_explicit=1
let g:ale_sign_column_always=1
let g:ale_fix_on_save=1
let g:ale_completion_enabled=1
let g:ale_echo_msg_error_str='E'
let g:ale_echo_msg_warning_str='W'
let g:ale_echo_msg_format='[%linter%] %s [%severity%]'
let g:ale_set_loclist=1
let g:ale_set_quickfix=0
let g:ale_open_list=0
let g:ale_keep_list_window_open=0
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> [ale]f <Plug>(ale_fix)

" coc
set nowritebackup
set cmdheight=2
set updatetime=300

" Use <c-space> to trigger completion.
imap <Nul> <C-Space>
inoremap <silent><expr> <C-Space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

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

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

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
nmap [coc]qf  <Plug>(coc-fix-current)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> [coc]a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> [coc]e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> [coc]c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> [coc]o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> [coc]s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> [coc]j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> [coc]k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> [coc]p  :<C-u>CocListResume<CR>

" ### Markdown
" vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_toc_autofit=1
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1
let g:vim_markdown_toml_frontmatter=1
let g:vim_markdown_json_frontmatter=1

" ### Golang
au BufNewFile,BufRead *.go setl sw=4 ts=4 sts=4 noet
" vim-go
let g:go_auto_type_info=1
let g:go_highlight_types=1
let g:go_highlight_fields=1
let g:go_highlight_functions=1
let g:go_highlight_function_calls=1
let g:go_highlight_operators=1
let g:go_highlight_extra_types=1
let g:go_highlight_build_constraints=1
let g:go_metalinter_autosave=0
let g:go_gocode_propose_builtins=0
let g:go_def_mapping_enabled=0
let g:go_doc_keywordprg_enabled=0

" ### Rust
" ale
let g:ale_rust_cargo_use_clippy = executable('cargo-clippy')
" rust.vim
let g:rustfmt_autosave=1 

" ### Javascript
" tigris.nvim
let g:tigris#enabled=1
let g:tigris#on_the_fly_enabled=1
let g:tigris#delay=300

