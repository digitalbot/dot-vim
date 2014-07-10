"==============================
"" Basic
"==============================

set encoding=utf-8

"vi互換なし
set nocompatible
filetype off

"スクロール時余白
set scrolloff=5

"無自動折り返し
set textwidth=0

"auto-revert
set autoread

"swapとbackup
set noswapfile
set backupskip=/tmp/*,/private/tmp/*
set nobackup

"編集中でも他のファイルを開けるようにする
set hidden

"バックスペースでなんでも消せる
set backspace=indent,eol,start

"テキスト整形オプション，マルチバイト系を追加
set formatoptions=lmoq

"カーソルを行頭、行末で止まらないようにする
"set whichwrap=b,s,h,l,<,>,[,]

"OSのクリップボード
set clipboard+=unnamed

"ターミナルでマウスを使用できるようにする
set mouse=a
set guioptions+=a
set ttymouse=xterm2

"自動でインデント
set autoindent

"新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set smartindent

set cindent
set tabstop=4
set softtabstop=4
set expandtab
set shiftwidth=4
set vb t_vb=

augroup vimrc
    autocmd! FileType perl setlocal shiftwidth=4 tabstop=4 softtabstop=4
augroup END


" 見た目系
"-------------------

"コマンドをステータス行に表示
set showcmd

"現在のモードを表示
set showmode

"モードラインは無効
set modelines=0

"タイトル
set title

"常にステータスラインを表示
set laststatus=2

"カーソルが何行目の何列目に置かれているか
set ruler

"括弧の対応をハイライト
set showmatch

"行番号表示
set number

"不可視文字表示
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<

"印字不可能文字を16進数で表示
set display=uhex

"カーソル行をハイライト
set cursorline

"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
    autocmd!
    autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
    autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

"カレントウィンドウにのみ罫線を引く
augroup cch
    autocmd! cch
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
augroup END

set incsearch
set hlsearch

"Esc二回押しでハイライト除去
nmap <ESC><ESC> :nohlsearch<CR><ESC>

colorscheme slate

"==============================
"" Plugin
"==============================

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#rc(expand('~/.vim/bundle'))
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \    'windows' : 'make -f make_mingw32.mak',
    \    'cygwin'  : 'make -f make_cygwin.mak',
    \    'mac'     : 'make -f make_mac.mak',
    \    'unix'    : 'make -f make_unix.mak',
    \    },
    \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'itchyny/lightline.vim'

function! s:meet_neocomplete_requirements()
    return has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
endfunction

if s:meet_neocomplete_requirements()
    NeoBundle 'Shougo/neocomplete.vim'
    NeoBundleFetch 'Shougo/neocomplcache.vim'
else
    NeoBundleFetch 'Shougo/neocomplete.vim'
    NeoBundle 'Shougo/neocomplcache.vim'
endif

filetype plugin indent on
filetype indent on
syntax on


"==============================
"" Unite
"==============================

let g:vinarise_enable_auto_detect = 1
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1

nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite file_mru buffer<CR>

"==============================
"" Completion
"==============================

if s:meet_neocomplete_requirements()
    "NEOCOMPLETE
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_auto_select = 1
    let g:neocomplete#enable_fuzzy_completion = 1

    let g:neocomplete#sources#dictionary#dictionaries = {
        \ 'default' : ''
        \ }

    inoremap <expr><C-g> neocomplete#undo_completion()
    inoremap <expr><C-l> neocomplete#complete_common_string()
    inoremap <expr><CR> neocomplete#smart_close_popup() . "\<CR>"
    inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
    inoremap <expr><C-h> neocomplete#smart_close_popup() . "\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup() . "\<C-h>"
    inoremap <expr><C-y> neocomplete#close_popup()
    inoremap <expr><C-e> neocomplete#cancel_popup()

    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    set completeopt=menuone
else
    "NEOCOMPLCACHE
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_underbar_completion = 1
    let g:neocomplcache_enable_camel_case_completion = 1

    let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default' : ''
        \ }

    inoremap <expr><C-g> neocomplcache#undo_completion()
    inoremap <expr><C-l> neocomplcache#complete_common_string()
    inoremap <expr><CR> neocomplcache#smart_close_popup() . "\<CR>"
    inoremap <expr><TAB> pumvisible() ? "\<Down>" : "\<TAB>"
    inoremap <expr><S-TAB> pumvisible() ? "\<Up>" : "\<S-TAB>"
    inoremap <expr><C-h> neocomplcache#smart_close_popup() . "\<C-h>"
    inoremap <expr><C-y> neocomplcache#close_popup()
    inoremap <expr><C-e> neocomplcache#cancel_popup()
    set completeopt=menuone
endif



"==============================
"" Lightline
"==============================

let g:lightline = {
    \ 'colorscheme': "jellybeans",
    \ }
