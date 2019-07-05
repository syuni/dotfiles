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
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
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
let mapleader="\<Space>"

" change buffer
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
" change tab
nnoremap <silent> [t :tprevious<CR>
nnoremap <silent> ]t :tnext<CR>

" ### coc
set nowritebackup
set cmdheight=2
set updatetime=300
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

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
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

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
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

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
colorscheme onedark

" ### Packages
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
nnoremap <silent> <C-x><C-b> :Buffers<CR>
nnoremap <silent> <C-x><C-w> :Windows<CR>
nnoremap <silent> <C-x><C-f> :FZF<CR>
nnoremap <silent> <C-x><C-g> :Rg<CR>
nnoremap <silent> <C-x><C-]> :BTags<CR>
nnoremap <silent> <C-x><C-s> :Snippets<CR>

" ale
let g:ale_linters={
  \ 'javascript': ['eslint'],
  \ 'javascript.jsx': ['eslint'],
  \ 'go': ['golangci-lint'],
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
  \ 'python': ['black', 'isort']
  \ }
let g:ale_linters_explicit=1
let g:ale_sign_column_always=1
let g:ale_fix_on_save=1
let g:ale_completion_enabled=1
let g:ale_echo_msg_error_str='E'
let g:ale_echo_msg_warning_str='W'
let g:ale_echo_msg_format='[%linter%] %s [%severity%]'
let g:ale_set_loclist=0
let g:ale_set_quickfix=0
let g:ale_open_list=0
let g:ale_keep_list_window_open=0
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

" ### Markdown
" vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_toc_autofit=1
let g:vim_markdown_math=1
let g:vim_markdown_frontmatter=1
let g:vim_markdown_toml_frontmatter=1
let g:vim_markdown_json_frontmatter=1

" ### Golang
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
" rust.vim
let g:rustfmt_autosave=1 

" ### Javascript
" tigris.nvim
let g:tigris#enabled=1
let g:tigris#on_the_fly_enabled=1
let g:tigris#delay=300

