if !1 | finish | endif

augroup vimrc
  autocmd!
augroup END

if &compatible
  set nocompatible
endif

set runtimepath^=~/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/dein'))

call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/unite-outline')
call dein#add('Shougo/vimproc.vim', { 'build': { 'mac': 'make' } })
call dein#add('Shougo/unite.vim')

" Utility plugins here:
call dein#add('bronson/vim-trailing-whitespace')
call dein#add('junegunn/vim-easy-align')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('Townk/vim-autoclose')
call dein#add('scrooloose/nerdtree')

" Markdown
call dein#add('plasticboy/vim-markdown')
call dein#add('kannokanno/previm')
call dein#add('tyru/open-browser.vim')

" C++
call dein#add('octol/vim-cpp-enhanced-highlight')

" Haskell bundlers here
call dein#add('scrooloose/syntastic')
call dein#add('yogsototh/haskell-vim')
call dein#add('eagletmt/neco-ghc')
call dein#add('eagletmt/ghcmod-vim')
call dein#add('Twinside/vim-hoogle')
call dein#add('pbrisbin/html-template-syntax')

" Ruby bundlers here
call dein#add('todesking/ruby_hl_lvar.vim')
call dein#add('kana/vim-textobj-user')
call dein#add('rhysd/vim-textobj-ruby')
call dein#add('vim-ruby/vim-ruby')

" Javascript bundlers here
call dein#add('isRuslan/vim-es6')
call dein#add('scrooloose/syntastic')
call dein#add('mattn/jscomplete-vim')

" NodeJS bundlers here
call dein#add('thinca/vim-quickrun')
call dein#add('myhere/vim-nodejs-complete')
call dein#add('moll/vim-node')

" JSON bundlers here
call dein#add('elzr/vim-json')

" TypeScript bundlers here
call dein#add('leafgarland/typescript-vim')
call dein#add('Quramy/tsuquyomi')

" JSX bundlers here
call dein#add('mxw/vim-jsx')

" HTML bundlers here
call dein#add('othree/html5.vim')

call dein#add('Shougo/vimshell', { 'rev': '3787e5' })
call dein#end()

filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

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

"let mapleader="-"
"let g:mapleader="-"
"set tm=2000
"nmap <silent> <leader>ht :GhcModType<CR>
"nmap <silent> <leader>hh :GhcModTypeClear<CR>
"nmap <silent> <leader>hT :GhcModTypeInsert<CR>
"nmap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>:lopen<CR>
"let g:syntastic_mode_map={'mode' : 'active', 'passive_filetypes' : ['haskell']}
"let g:syntastic_always_populate_loc_list = 1
"nmap <silent> <leader>hl :SyntasticCheck hlint<CR>:lopen<CR>

"" Auto-checking on writing
"autocmd BufWritePost *.hs,*.lhs GhcModCheckAndLintAsync

""  neocomplcache (advanced completion)
"autocmd BufEnter *.hs,*.lhs let g:neocomplcache_enable_at_startup = 1
"function! SetToCabalBuild()
"    if glob("*.cabal") != ''
"        set makeprg=cabal\ build
"    endif
"endfunction
"autocmd BufEnter *.hs,*.lhs :call SetToCabalBuild()

"" -- neco-ghc
"let $PATH=$PATH.':'.expand("~/.cabal/bin")


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
