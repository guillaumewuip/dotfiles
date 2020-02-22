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

set mouse=n
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
set cmdheight=2

" always show signcolumns
set signcolumn=yes

" if hidden not set, TextEdit might fail.
set hidden

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

" Not highlight the screen line of the cursor
set nocursorline
set nocursorcolumn
" Highlight the screen line of the cursor with H
nnoremap H :set cursorline! <CR>

" Always show 5 lines around cursor
set scrolloff=5

"Add 80 caracter column
set colorcolumn=80
set textwidth=80 "line width

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

highlight Search cterm=NONE ctermfg=15 ctermbg=172
highlight CocHighlightText ctermfg=15 ctermbg=136
highlight CocHighlightRead ctermfg=15 ctermbg=136
highlight CocHighlightWrite ctermfg=15 ctermbg=136

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
" Transliterate files in UTF-8
set fileencoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Protect changes between writes. Default values of
" updatecount (200 keystrokes) and updatetime
" (4 seconds) are fineset swapfile
" set swapfile
" set directory^=~/.vim/swap//

" protect against crash-during-write
set writebackup

" but do not persist backup after successful write
set nobackup

" use rename-and-write-new method whenever safe
set backupcopy=auto
" consolidate the writebackups -- not a big
" deal either way, since they usually get deleted
set backupdir^=~/.vim/backup//

" persist the undo tree for each file
set undofile
set undodir^=~/.vim/undo//

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

" Linebreak on 120 characters
set lbr
set tw=120

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" move among buffers with CTRL
map <C-L> :bnext<CR>
map <C-H> :bprev<CR>
" close buffer with CTRL
map <C-X> :bd<CR>

" Specify the behavior when switching between buffers
set switchbuf=useopen,usetab,newtab
set stal=2

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
" After a :cope :
"
" To go to the next search result do:
"   <leader>n
" To go to the previous search results do:
"   <leader>p
map <leader>n :cn<cr>
map <leader>p :cp<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Diff
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &diff
  nnoremap - [c
  nnoremap + ]c
endif

map <Leader>1 :diffget LOCAL<CR>
map <Leader>2 :diffget BASE<CR>
map <Leader>3 :diffget REMOTE<CR>

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
" => Plugins config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"vim-markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

"Vim airline
set laststatus=2 " so we always get airline displaying / always show status
let g:airline_theme='minimalist'
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_symbols = {}
"No git info
let g:airline_section_b = ''
"Files percentage, lines, line
let g:airline_section_z = '%3p%%%#__accent_bold#%4l%#__restore__#%#__accent_bold#/%L%#__restore__#%3v'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#buffer_nr_show = 1

"GitGutter
highlight clear SignColumn

"indentLine
let g:indentLine_char = '┆'
let g:indentLine_enabled = 1

"vim-better-whitespace
let strip_whitespace_on_save = 1

"FZF
let g:fzf_command_prefix = 'F'
set rtp+=/usr/local/opt/fzf

let g:fzf_buffers_jump = 1

let g:fzf_preview_use_floating_window = 1
let g:fzf_preview_command = 'bat --color=always --style=grid {-1}'
let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --no-messages -g \!"* *"' " Installed ripgrep


":FRag search_term /path/to/dir
command! -bang -nargs=+ -complete=dir FRag call fzf#vim#ag_raw('--path-to-ignore ~/.home/.ignore ' .<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

"Search files in project
nmap <silent> <C-F> :FzfPreviewProjectFiles<CR>

"Search and grep  in project
nmap <silent> <C-G> :FzfPreviewProjectGrep<CR>

"Search buffers
nmap <silent> <C-B> :FzfPreviewAllBuffers<CR>

"Search git status
nmap <silent> <C-S> :FzfPreviewGitStatus<CR>

"Search work under cursor with FRag
map <Leader>f :FRag <C-R><C-W> ./

"Open buffers
map <Leader>b :Buffers

"Nerdcommenter
let NERDSpaceDelims=1

"vim-jsx
let g:jsx_ext_required = 0

"UltiSnips
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
let g:UltiSnipsEditSplit = 'tabdo'
let g:UltiSnipsJumpForwardTrigger = '<leader>sn'
let g:UltiSnipsJumpBackwardTrigger = '<leader>sp'

" NERDTree
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeHighlightCursorline = 0
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
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeShowHidden=1
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeWinSize=40

nnoremap <Leader>d :NERDTreeToggle<cr>
nnoremap <Leader>p :NERDTreeFind<CR>

autocmd VimEnter * if !argc() | NERDTree | endif
autocmd VimEnter * if !argc() | wincmd w | endif

autocmd BufEnter * if bufname('#') =~# "^NERD_tree_" && winnr('$') > 1 | b# | endif
" autocmd BufWinEnter * NERDTreeFind | wincmd w

autocmd filetype nerdtree set colorcolumn&
autocmd filetype nerdtree autocmd BufLeave <buffer> set colorcolumn=80

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => COC.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Typescript

" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" navigate diagnostics
nmap <silent> <leader>ap <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>an <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use D for show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> D :call <SID>show_documentation()<CR>

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
vmap = <Plug>(coc-format-selected)
nmap <leader>fo  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>

" Autocomplete config
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

let g:coc_snippet_next = '<tab>'

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => On vim start
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set sidescrolloff=15
set sidescroll=1

:command Lint set mp=yarn\ run\ lint:js\ --format\ unix | make | copen

set foldmethod=syntax
set foldlevelstart=99

set ttyfast
set lazyredraw

highlight Pmenu     cterm=NONE ctermfg=255 ctermbg=236
highlight PmenuSel  cterm=NONE ctermfg=15 ctermbg=240
