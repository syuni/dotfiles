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
" close preview when complete done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" always show signcolumn
set signcolumn=yes
" delete backword
set whichwrap=b,s,h,l,<,>,[,],~
set backspace=indent,eol,start

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
let mapleader='\<Space>'

" wrap move
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk

" change buffer
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
" change tab
nnoremap <silent> [t :tprevious<CR>
nnoremap <silent> ]t :tnext<CR>
" change quickfix
nnoremap <silent> [q :cprevious<CR>
nnoremap <silent> ]q :cnext<CR>
" change loclist
nnoremap <silent> [l :lprevious<CR>
nnoremap <silent> ]l :lnext<CR>

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

  " deoplete
  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  " icons
  call dein#add('ryanoasis/vim-devicons')

  " nerdtree
  call dein#add('scrooloose/nerdtree')

  " airline
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')

  " indent
  call dein#add('Yggdroot/indentLine')

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

  " markdown
  call dein#add('godlygeek/tabular')
  call dein#add('plasticboy/vim-markdown')

  " lsp-client
  call dein#add('autozimu/LanguageClient-neovim', {'build': 'bash install.sh'})

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

syntax on

" ### Packages
" deoplete.vim
let g:deoplete#enable_at_startup=1
let g:deoplete#auto_complete_delay=0
let g:deoplete#auto_complete_start_length=1
let g:deoplete#enable_smart_case=1

" powerline
set laststatus=2
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_idx_mode=1
let g:airline#extensions#whitespace#mixed_indent_algo=1

" vim-devicons
let g:WebDevIconsUnicodeDecorateFolderNodes=1

" nerdtree
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" fzf
let g:fzf_layout={ 'down': '40%' }
let g:fzf_buffers_jump=1
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(),
  \   <bang>0)
nnoremap <silent> <C-s> :BLines<CR>

" ale
let g:ale_linters={
  \ 'javascript': ['eslint'],
  \ 'javascript.jsx': ['eslint'],
  \ 'go': ['gometalinter'],
  \ 'rust': ['rustc'],
  \ 'haskell': ['hlint'],
  \ 'python': ['flake8']
  \ }
let g:ale_fixers={
  \ 'javascript': ['eslint'],
  \ 'javascript.jsx': ['eslint'],
  \ 'go': ['goimports'],
  \ 'rust': ['rustfmt'],
  \ 'haskell': ['stylish-haskell'],
  \ 'python': ['yapf']
  \ }
let g:ale_linters_explicit=1
let g:ale_sign_column_always=1
let g:ale_fix_on_save=1
let g:ale_completion_enabled=1
let g:ale_set_loclist=0
let g:ale_set_quickfix=1
let g:ale_echo_msg_error_str='E'
let g:ale_echo_msg_warning_str='W'
let g:ale_echo_msg_format='[%linter%] %s [%severity%]'

" languageclient-neovim
let g:LanguageClient_autoStart=1
let g:LanguageClient_serverCommands={
  \ 'rust': ['rls'],
  \ 'python': ['pyls'],
  \ 'javascript': ['javascript-typescript-stdio'],
  \ 'javascript.jsx': ['javascript-typescript-stdio'],
  \ 'go': ['go-langserver','-func-snippet-enabled=0','-gocodecompletion=1','-format-tool','goimports','-lint-tool','gometalinter','-diagnostics=1'],
  \ 'haskell': ['hie-wrapper']
  \ }
let g:LanguageClient_rootMarkers={
  \ 'haskell': ['*.cabal','stack.yaml']
  \ }
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" ### Markdown
" language-settings
autocmd BufNewFile,BufRead *.md setlocal tabstop=4 shiftwidth=4

" vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_toc_autofit=1
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1
let g:vim_markdown_toml_frontmatter=1
let g:vim_markdown_json_frontmatter=1

" ### Haskell
" language-settings
autocmd BufNewFile,BufRead *.hs setlocal tabstop=4 shiftwidth=4 omnifunc=LanguageClient#complete

" ### Golang
" language-settings
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 omnifunc=LanguageClient#complete

" vim-go
let g:go_auto_type_info=1
let g:go_highlight_types=1
let g:go_highlight_fields=1
let g:go_highlight_functions=1
let g:go_highlight_function_calls=1
let g:go_highlight_operators=1
let g:go_highlight_extra_types=1
let g:go_highlight_build_constraints=1
let g:go_fmt_command="goimports"
let g:go_metalinter_autosave=1
let g:go_gocode_propose_builtins=0

" ### Rust
" language-settings
autocmd BufNewFile,BufRead *.rs setlocal tabstop=4 shiftwidth=4 omnifunc=LanguageClient#complete

" rust.vim
let g:rustfmt_autosave=1 

" ### Javascript
" language-settings
autocmd BufNewFile,BufRead *.js,*.jsx setlocal tabstop=2 shiftwidth=2 omnifunc=LanguageClient#complete

" tigris.nvim
let g:tigris#enabled=1
let g:tigris#on_the_fly_enabled=1
let g:tigris#delay=300

