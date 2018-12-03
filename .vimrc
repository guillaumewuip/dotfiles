"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

"Allow vim clipboad <-> host clipboard to share data
set clipboard=unnamed

set mouse=a
if !has('nvim')
    if has("mouse_sgr")
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    end
end
map <ScrollWheelUp> k
map <ScrollWheelDown> j

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the WiLd menu
set wildmenu
set wildmode=list:longest:full

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Display relative line numbers and absolute line number for the current line
set number

" Hghlight the screen line of the cursor
set nocursorline
set nocursorcolumn
nnoremap H :set cursorline! <CR>
" Always show 5 lines around cursor
set scrolloff=5

"Add 80 caracter column
set colorcolumn=80
set textwidth=80 "line width
autocmd filetype nerdtree set colorcolumn&
autocmd filetype nerdtree autocmd BufLeave <buffer> set colorcolumn=80

"jump with % in if/elsif/else/end
runtime macros/matchit.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
if !exists("g:syntax_on")
    syntax enable
endif

colorscheme desert
set background=dark

highlight CursorLine cterm=NONE ctermbg=236

highlight Search cterm=NONE ctermfg=231 ctermbg=215

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
" Transliterate files in UTF-8
set fileencoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"Arduino, Processing
autocmd BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp
"Stylus
autocmd BufNewFile,BufReadPost *.styl set filetype=stylus

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab
set autoindent

" Be smart when using tabs ;)
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2
set softtabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows (alt+hjkl)
map Ï <C-W>j
map È <C-W>k
map ¬ <C-W>l
map Ì <C-W>h

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Open file under cursor in new tab
nnoremap t <c-w>gf

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using Ctrl+[jk]
" Normal mode
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi
" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" Open vimgrep and put the cursor in the right position
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" Vimgreps in the current file
map <leader><space> :vimgrep // <C-R>%<C-A>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" After a :cope :
"
" To go to the next search result do:
"   <leader>n
" To go to the previous search results do:
"   <leader>p
map <leader>n :cn<cr>
map <leader>p :cp<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Don't close window, when deleting a buffer
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
command! Bclose call <SID>BufcloseCloseIt()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"https://github.com/plasticboy/vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_conceal = 0

"Vim airline
set laststatus=2 " so we always get airline displaying / always show status
let g:airline#extensions#branch#enabled = 1
let g:airline_theme='atomic'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols = {}
let g:airline_symbols.linenr = '␊ '
let g:airline_symbols.linenr = '␤ '
let g:airline_symbols.linenr = '¶ '
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline#extensions#tabline#enabled = 0
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_airline_tabline = 1

"GitGutter
highlight clear SignColumn

"https://github.com/Yggdroot/indentLine
let g:indentLine_char = '┆'
let g:indentLine_enabled = 1

"vim-better-whitespace
let strip_whitespace_on_save = 1

"vim-multiple-cursors
let g:multi_cursor_exit_from_visual_mode = 1
let g:multi_cursor_exit_from_insert_mode = 0

"FZF
set rtp+=/usr/local/opt/fzf
let g:fzf_command_prefix = 'F'
":FRag search_term /path/to/dir
command! -bang -nargs=+ -complete=dir FRag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

"Nerdcommenter
let NERDSpaceDelims=1

let g:jsx_ext_required = 0

" deoplete
let g:deoplete#enable_at_startup = 1

" neosnippet
let g:neosnippet#snippets_directory='~/.vim/snippets'
let g:neosnippet#disable_runtime_snippets = {
\   '_' : 1,
\ }
" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <S-TAB>     <Plug>(neosnippet_expand_or_jump)
smap <S-TAB>     <Plug>(neosnippet_expand_or_jump)

" ALE
map <leader>an :ALENext<cr>
map <leader>ap :ALEPrevious<cr>
let g:airline#extensions#ale#enabled = 1

" Typescript
map <Leader>d :TSDoc<cr>

let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "~",
    \ "Staged"    : "+",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "x",
    \ 'Dirty'     : '~',
    \ 'Clean'     : '✔︎',
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => On vim start
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Open NERDTree on full screen if vim isn't open with a file
autocmd VimEnter * if !argc() | NERDTree | endif
autocmd VimEnter * if !argc() | wincmd p | endif
autocmd VimEnter * if !argc() | wincmd q | endif

