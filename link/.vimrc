syntax on

call plug#begin('~/.vim/plugged')

"""""""""""""""""""""""""""""""""
" VIM:
"""""""""""""""""""""""""""""""""
" wrap gitcommit file types at the appropriate length
filetype indent plugin on

" encoding
set encoding=utf-8
set fileencoding=utf-8

" no cowbells
set noerrorbells 
" don't make it look like there are line breaks where there aren't:
set nowrap

"number of command lines to remember
set history=1000

" Turn off backups, etc.
set nobackup
set noswapfile
set nowb

" jsdoc
nmap <silent> <C-l> <Plug>(jsdoc)
let g:jsdoc_allow_input_prompt = 1
let g:jsdoc_input_description = 1
let g:jsdoc_enable_es6 = 1
let g:javascript_plugin_jsdoc = 1

let g:javascript_conceal_function       = "ƒ"
let g:javascript_conceal_null           = "ø"
let g:javascript_conceal_this           = "@"
let g:javascript_conceal_return         = "⇚"
let g:javascript_conceal_undefined      = "¿"
let g:javascript_conceal_NaN            = "ℕ"
let g:javascript_conceal_prototype      = "¶"
let g:javascript_conceal_static         = "•"
let g:javascript_conceal_super          = "Ω"
let g:javascript_conceal_arrow_function = "⇒"

" Resize windows
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>= :vertical resize +5<CR>

" enable omnicomplete
set omnifunc=syntaxcomplete#Complete

" fix shitty mouse and nerdtree focus issue: thanks old Brad
"if has("mouse_sgr")
  "set ttymouse=sgr else set ttymouse=xterm2
"end

" better windows navigating
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Always show line numbers.
set number

" use spaces for all indentation
set expandtab
set shiftwidth=2
set softtabstop=2

" Sudo saving (w!!)
cmap w!! w !sudo tee % >/dev/null

set ignorecase " Ignore case when searching
set smartcase " When searching try to be smart about cases
set hlsearch " Highlight search resultsh
set incsearch " be like search in modern browsers

" Sometimes it is helpful if your working directory is 
" always the same as the file you are editing.
" http://vim.wikia.com/wiki/Set_working_directory_to_the_current_file
"set autochdir

" Map space to / (search)
map <space> /
map <silent> <leader><cr> :noh<cr>

" Enable mouse (if terminal has support for it)
if has('mouse')
  set mouse=a
endif

"hide when characters are typed
set mousehide

" Spellcheck en_CA
nnoremap <C-w>s :setlocal spell spelllang=en_ca<CR>
nnoremap <C-w>S :setlocal nospell<CR>

"sync with OS clipboard
set clipboard=unnamed

" Need +virtualedit to paste in insert mode.
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']
imap <S-Insert> <C-V>
vmap <S-Insert> <C-V>

"auto reload if file saved externally
set autoread

"add mac to auto-detection of file format line endings
set fileformats+=mac

" different cursors for insert vs normal mode
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" formatting shortcuts
vmap <leader>s :sort<cr>

" remap arrow keys
"nnoremap <down> :tabprev<CR>
"nnoremap <left> :bprev<CR>
"nnoremap <right> :bnext<CR>
"nnoremap <up> :tabnext<CR>

" smash escape
inoremap jk <esc>
inoremap kj <esc>

" change cursor position in insert mode
inoremap <C-h> <left>
inoremap <C-l> <right>

 " reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

"""""""""""""""""""""""""""""""""
" GIST:
"""""""""""""""""""""""""""""""""
" gist-vim
let g:gist_detect_filetype = 1
let g:gist_post_private = 1

"""""""""""""""""""""""""""""""""
" JSBeautify:
"""""""""""""""""""""""""""""""""
".vimrc
map <c-f> :call JsBeautify()<cr>
" or
autocmd FileType javascript noremap <buffer>  <c-f> :call JsBeautify()<cr>
" for json
autocmd FileType json noremap <buffer> <c-f> :call JsonBeautify()<cr>
" for jsx
autocmd FileType jsx noremap <buffer> <c-f> :call JsxBeautify()<cr>
" for html
autocmd FileType html noremap <buffer> <c-f> :call HtmlBeautify()<cr>
" for css or scss
autocmd FileType css noremap <buffer> <c-f> :call CSSBeautify()<cr>

"""""""""""""""""""""""""""""""""
" NERDTree:
"""""""""""""""""""""""""""""""""
" open when vim opens
autocmd vimenter * NERDTree

" open when C-j
map <C-n> :NERDTreeToggle<CR>

let g:loaded_netrw       = 1
let g:loaded_netrwPlugin = 1

" change arrows
let g:NERDTreeDirArrowExpandable = '৩'
let g:NERDTreeDirArrowCollapsible = '২'


"""""""""""""""""""""""""""""""""
" Airline:
"""""""""""""""""""""""""""""""""
" tabline enabled
let g:airline#extensions#tabline#enabled = 0

" use powerline fonts
let g:airline_powerline_fonts = 1

" show status line all the time
set laststatus=2


"""""""""""""""""""""""""""""""""
" ESlint:
"""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = 'ȩ'
let g:syntastic_style_error_symbol = 'ȿȩ'
let g:syntastic_warning_symbol = 'Ŵ'
let g:syntastic_style_warning_symbol = 'ȿŴ'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn

"""""""""""""""""""""""""""""""""
" YUNO:
"""""""""""""""""""""""""""""""""
" show dude when 10 modifications
let g:YUNOcommit_after = 10

"""""""""""""""""""""""""""""""""
" PLUG:
"""""""""""""""""""""""""""""""""
" Ternjs: run `npm install` the first time
" .dotfiles/vim.symlink/plugged/tern_for_vim

"Plug 'benmills/vimux' 
"Plug 'geekjuice/vim-mocha'
Plug 'Raimondi/delimitMate'
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/csv.vim'
Plug 'chriskempson/base16-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'elzr/vim-json'
Plug 'ervandew/supertab'
Plug 'esneider/YUNOcommit.vim'
Plug 'guns/vim-clojure-static'
Plug 'heavenshell/vim-jsdoc'
Plug 'ivalkeen/vim-ctrlp-tjump'
Plug 'jasoncodes/ctrlp-modified.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'jlanzarotta/bufexplorer'
Plug 'kchmck/vim-coffee-script'
Plug 'kien/rainbow_parentheses.vim'
Plug 'leafgarland/typescript-vim'
Plug 'maksimr/vim-jsbeautify'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
Plug 'mileszs/ack.vim'
Plug 'moll/vim-node'
Plug 'othree/yajs.vim'
Plug 'pangloss/vim-javascript'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'sgur/ctrlp-extensions.vim'
Plug 'sirver/ultisnips'
Plug 'sjl/gundo.vim'
Plug 'suan/vim-instant-markdown'
Plug 'takac/vim-spotifysearch'
Plug 'ternjs/tern_for_vim'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-scripts/winresizer.vim'
Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'

" Add plugins to &runtimepath
call plug#end()

"""""""""""""""""""""""""""""""""
" Colorscheme
"""""""""""""""""""""""""""""""""
"set background=dark
" Access colors present in 256 colorspace
let base16colorspace=256  
colorscheme base16-default-dark
" base16-helper updates theme automagically
if filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
endif
