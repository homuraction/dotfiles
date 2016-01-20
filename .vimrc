if !1 | finish | endif

if has('vim_starting')
        set nocompatible
        set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

augroup vimrc
  autocmd!
augroup END


"-----------
" neobundle
"-----------

call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

" Shougo bundlers here
NeoBundle 'Shougo/neocomplete.vim'
" NeoBundle 'Shougo/neosnippet'
" NeoBundle 'Shougo/neosnippet-snippets'
" NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/vimproc.vim', {
\ 'build' : {
\     'windows' : 'tools\\update-dll-mingw',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'linux' : 'make',
\     'unix' : 'gmake',
\    },
\ }

" utility bundlers here
NeoBundle 'bronson/vim-trailing-whitespace'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'scrooloose/nerdtree'

" Markdown
NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

" C++
NeoBundle 'octol/vim-cpp-enhanced-highlight'

" Haskell bundlers here
NeoBundle 'scrooloose/syntastic'
NeoBundle 'yogsototh/haskell-vim'
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'eagletmt/ghcmod-vim'
NeoBundle 'Twinside/vim-hoogle'
NeoBundle 'pbrisbin/html-template-syntax'

" Ruby bundlers here
NeoBundle 'todesking/ruby_hl_lvar.vim'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'rhysd/vim-textobj-ruby'
NeoBundle 'vim-ruby/vim-ruby'

" Scala bundlers here
NeoBundle 'derekwyatt/vim-scala'

" Jade bundlers here
NeoBundle 'digitaltoad/vim-jade'

" Javascript bundlers here
NeoBundle 'isRuslan/vim-es6'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'mattn/jscomplete-vim'

" NodeJS bundlers here
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'myhere/vim-nodejs-complete'
NeoBundle 'moll/vim-node'

" JSON bundlers here
NeoBundle 'elzr/vim-json'

" TypeScript bundlers here
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'Quramy/tsuquyomi'

" JSX bundlers here
NeoBundle 'mxw/vim-jsx'

" HTML bundlers here
NeoBundle 'othree/html5.vim'

call neobundle#end()

NeoBundleCheck


filetype plugin indent on
syntax enable

"--------
" Ruby
"--------
autocmd FileType ruby setl iskeyword+=?

"-------------
" NeoComplete
"-------------
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
let g:neocomplete#sources#dictionary#dictionaries = {
      \   'ruby': $HOME . '/dicts/ruby.dict',
      \ }

"----------
" Markdown
"----------

au BufRead,BufNewFile *.md set filetype=markdown

"---------
" Haskell
"---------

let mapleader="-"
let g:mapleader="-"
set tm=2000
nmap <silent> <leader>ht :GhcModType<CR>
nmap <silent> <leader>hh :GhcModTypeClear<CR>
nmap <silent> <leader>hT :GhcModTypeInsert<CR>
nmap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>:lopen<CR>
let g:syntastic_mode_map={'mode' : 'active', 'passive_filetypes' : ['haskell']}
let g:syntastic_always_populate_loc_list = 1
nmap <silent> <leader>hl :SyntasticCheck hlint<CR>:lopen<CR>

" Auto-checking on writing
autocmd BufWritePost *.hs,*.lhs GhcModCheckAndLintAsync

"  neocomplcache (advanced completion)
autocmd BufEnter *.hs,*.lhs let g:neocomplcache_enable_at_startup = 1
function! SetToCabalBuild()
    if glob("*.cabal") != ''
        set makeprg=cabal\ build
    endif
endfunction
autocmd BufEnter *.hs,*.lhs :call SetToCabalBuild()

" -- neco-ghc
let $PATH=$PATH.':'.expand("~/.cabal/bin")


"-----------
" c, cpp, h
"-----------

au BufNewFile,BufRead *.c    set nowrap tabstop=8 shiftwidth=8
au BufNewFile,BufRead *.cpp  set nowrap tabstop=8 shiftwidth=8
au BufNewFile,BufRead *.cc  set nowrap tabstop=8 shiftwidth=8
au BufNewFile,BufRead *.h    set nowrap tabstop=8 shiftwidth=8
" tag jamp to vsp, split
nnoremap <Space>h :vsp<CR>:exe("tjump ".expand("<cword>"))<CR>
nnoremap <Space>k :split<CR>:exe("tjump ".expand("<cword>"))<CR>
" A workaround errors in octol/vim-cpp-enhanced-highlight
let c_no_curly_error=1
let g:cpp_class_scope_highlight = 1
let g:cpp_experimental_template_highlight = 1

"------------
" Javascript
"------------
let g:jsx_ext_required = 0
let g:syntastic_javascript_checkers = ['eslint'] "ESLintを使う

"--------
" NodeJS
"--------

let g:quickrun_config={'*': {'split': ''}}
let g:quickrun_config['babel'] = {
  \ 'exec': "node_modules/babel-cli/bin/babel.js %o %s | node"
  \ }
" auto complete
autocmd FileType javascript setlocal omnifunc=nodejscomplete#CompleteJS
if !exists('g:neocomplcache_omni_functions')
  let g:neocomplcache_omni_functions = {}
endif
let g:neocomplcache_omni_functions.javascript = 'nodejscomplete#CompleteJS'
let g:node_usejscomplete = 1
imap <C-f> <C-x><C-o>

"------
" Json
"------
autocmd FileType json setl conceallevel=0

"-----------
" configure
"-----------

set nocompatible
set clipboard=unnamed
set number
set hidden
set incsearch
set shiftwidth=2
set tabstop=2
set expandtab
set smarttab
set autoindent
set smartindent
set list
set listchars=tab:>\ ,extends:<
set showmatch
set smartcase
set nowrapscan

" Easy align interactive
vnoremap <silent> <Enter> :EasyAlign<CR>

" Highlight at 80 columns.
if (exists('+colorcolumn'))
  set colorcolumn=80
  highlight ColorColumn ctermbg=8
endif

" Define color scheme.
set background=dark
try
  colorscheme molokai
catch
endtry
let g:molokai_original = 1
let g:rehash256 = 1

if has('gui_running')
    set background=light
else
    set background=dark
endif
