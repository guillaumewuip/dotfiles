"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
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

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" Smaller updatetime
set updatetime=100

" don't give |ins-completion-menu| messages.
set shortmess+=c

" don't wait to long for terminal key code
set timeout timeoutlen=1000 ttimeoutlen=50

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" hide buffer instead of unloading it
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
set scrolloff=7

" H
set sidescrolloff=15
set sidescroll=1

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

"Add 80 caracter column
set colorcolumn=80
set textwidth=80 "line width

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
" Transliterate files in UTF-8
set fileencoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

colorscheme desert
set background=dark

highlight CursorLine cterm=NONE ctermbg=236

highlight Search cterm=NONE ctermfg=15 ctermbg=172
highlight CocHighlightText ctermfg=15 ctermbg=136
highlight CocHighlightRead ctermfg=15 ctermbg=136
highlight CocHighlightWrite ctermfg=15 ctermbg=136

highlight Pmenu       cterm=NONE ctermfg=255 ctermbg=236
highlight PmenuSel    cterm=NONE ctermfg=15 ctermbg=240
highlight CocFloating cterm=NONE ctermfg=255 ctermbg=236

highlight TabLine                     cterm=NONE ctermfg=255 ctermbg=236
highlight TabLineCell                 cterm=NONE ctermfg=255 ctermbg=236
highlight TabLineCellSelected         cterm=NONE ctermfg=15 ctermbg=172
highlight TabLineCellModified         cterm=NONE ctermfg=255 ctermbg=244
highlight TabLineCellSelectedModified cterm=NONE ctermfg=15 ctermbg=160
highlight FloatermBorder              ctermfg=black

highlight clear SignColumn

Plug 'junegunn/rainbow_parentheses.vim'
let g:rainbow#blacklist = [0, 239]
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'ianks/vim-tsx'

Plug 'guns/vim-clojure-highlight', {'for': 'clojure'}
Plug 'guns/vim-clojure-static', {'for': 'clojure'}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" No swap files
set noswapfile

" protect against crash-during-write
set writebackup

" but do not persist backup after successful write
set nobackup

" use rename-and-write-new method whenever safe
set backupcopy=yes
" consolidate the writebackups -- not a big
" deal either way, since they usually get deleted
set backupdir^=~/.vim/backup/

" persist the undo tree for each file
set undofile
set undodir^=~/.vim/undo/

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

set foldmethod=syntax
set foldlevelstart=99
set foldcolumn=0

"decrement number
nnoremap <C-z> <C-x>

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
set switchbuf=useopen

" Show tabline when more than 2 tabs
set stal=2

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Open file under cursor in new tab
nnoremap t <c-w>gf

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

map <ScrollWheelUp> k
map <ScrollWheelDown> j

" After a :cope :
"
" To go to the next search result do:
"   <leader>n
" To go to the previous search results do:
"   <leader>p
map <leader>n :cn<cr>
map <leader>p :cp<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
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

vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => statusline / tabline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set laststatus=2 " so we always get airline displaying / always show status

function! StatusLine()
  let cocinfo = get(b:, 'coc_diagnostic_info', {})

  let msgs = []

  if get(cocinfo, 'error', 0)
    call add(msgs, '%#ErrorMsg#' . cocinfo['error'] . ' errors')
  endif

  if get(cocinfo, 'warning', 0)
    call add(msgs, '%#Search#' . cocinfo['warning'] . ' warnings')
  endif


  let base = '%#PmenuSel#%f%#ErrorMsg#%r%#Pmenu#%=%y %#PmenuSel# %p%% %l:%c'

  return base . '%#Pmenu# ' . join(msgs, '%#Pmenu# ')
endfunction

set statusline=%!StatusLine()

let s:tab_hi_modified = '%#TabLineCellModified#'
let s:tab_hi_selected_modified = '%#TabLineCellSelectedModified#'
let s:tab_hi_selected = '%#TabLineCellSelected#'
let s:tab_hi_non_selected = '%#TabLineCell#'
let s:tab_hi_cwd = '%#TabLine#'

function! s:GetFormattedBuffer(buf) abort
  let buf_name = pathshorten(fnamemodify(bufname(a:buf), ':.'))

  if empty(buf_name)
    let buf_name = '[No Name]'
  endif

  let modified = getbufvar(a:buf, '&modified')

  let selected = a:buf is# bufnr('%')

  if modified
    let buf_name = buf_name . '+'
  endif

  if modified && selected
    return printf('%s %s', s:tab_hi_selected_modified, buf_name)
  elseif modified
    return printf('%s %s', s:tab_hi_modified, buf_name)
  elseif selected
    return printf('%s %s', s:tab_hi_selected, buf_name)
  else
    return printf('%s %s', s:tab_hi_non_selected, buf_name)
  endif
endfunction

function! TabLine() abort
    let bl = []
    let current_nr = bufnr('%')

    let bufs = filter(range(1, bufnr('$')), 'buflisted(v:val)')
    let bufs_count = len(bufs)

    " Show 3 buffers maximum when the joined buffer's list string is bigger
    " than the window's width.
    if strlen(join(map(copy(bufs), 'pathshorten(fnamemodify(bufname(v:val), ":."))'))) ># &columns
        let bl += [s:tab_hi_cwd, '[' . bufs_count . ']']
        let current_i = index(bufs, current_nr)
        let prev_nr = current_i - 1 >=# 0 ? bufs[current_i - 1] : bufs[0]
        let next_nr = current_i + 1 <# len(bufs) - 1
                    \ ? bufs[current_i + 1]
                    \ : bufs[-1]
        let current = s:tab_hi_selected . s:GetFormattedBuffer(current_nr)
        let prev = prev_nr isnot# current_nr
                    \ ? s:GetFormattedBuffer(prev_nr)
                    \ : ''
        let next = next_nr isnot# current_nr
                    \ ? s:GetFormattedBuffer(next_nr)
                    \ : ''
        let bl += [prev, current, next]
    else
        for b in bufs
            call add(bl, s:GetFormattedBuffer(b))
        endfor
    endif

    let bl += [s:tab_hi_cwd]

    return join(bl)
endfunction

set showtabline=2
set tabline=%!TabLine()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"indentLine
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '┆'
let g:indentLine_enabled = 1
let g:indentLine_concealcursor = 'nc'
let g:indentLine_conceallevel = 2

"vim-better-whitespace
Plug 'ntpeters/vim-better-whitespace'
let strip_whitespace_on_save = 1

"FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'"
let g:fzf_command_prefix = 'F'
set rtp+=/usr/local/opt/fzf

let g:fzf_buffers_jump = 1

let g:fzf_preview_use_floating_window = 1
let g:fzf_preview_command = 'bat --color=always --style=grid {-1}'
let g:fzf_preview_lines_command = 'bat --color=always --plain --number'
let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --no-messages -g \!".git/*|*node_mdules*"'
let g:fzf_preview_use_dev_icons = 0
let g:fzf_preview_fzf_preview_window_option = 'down:50%'

let $FZF_PREVIEW_PREVIEW_BAT_THEME = 'desert'

":FRag search_term /path/to/dir
command! -bang -nargs=+ -complete=dir FRag call fzf#vim#ag_raw('--path-to-ignore ~/.home/.ignore ' .<q-args>, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)

"Search buffers
nmap <silent> ) :CocCommand fzf-preview.AllBuffers<CR>
nmap <silent> ( :CocCommand fzf-preview.BufferTags<CR>
nmap <silent> @ :CocCommand fzf-preview.Jumps<CR>

"Git
nmap <silent> ! :CocCommand fzf-preview.Changes<CR>
nmap <silent> # :CocCommand fzf-preview.CocCurrentDiagnostics<CR>

"Search files in project
nmap <silent> + :CocCommand fzf-preview.FromResources project git directory<CR>
nmap <silent> = :CocCommand fzf-preview.DirectoryFiles <C-R>=expand('%:h')<CR><CR>

"Search and grep in project
nmap <Leader>g :CocCommand fzf-preview.ProjectGrep .<CR>
"Search work under cursor
xnoremap <Leader>f "sy:FRag <Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"

"Nerdcommenter
Plug 'preservim/nerdcommenter'
let NERDSpaceDelims=1

"UltiSnips
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
let g:UltiSnipsEditSplit = 'tabdo'
let g:UltiSnipsJumpForwardTrigger = '<leader>sn'
let g:UltiSnipsJumpBackwardTrigger = '<leader>sp'

"multi-cursor
Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_select_all_word_key = '<C-y>'

"floaterm
Plug 'voldikss/vim-floaterm'

let g:netrw_liststyle = 3
let g:netrw_banner = 0

let g:floaterm_opener = 'tabe'
let g:floaterm_wintitle = v:false
let g:floaterm_height = 0.8
let g:floaterm_width = 0.8
let g:floaterm_width = 0.8

nmap - :FloatermNew ranger<CR>

Plug 'guns/vim-sexp', {'for': 'clojure'}
Plug 'tpope/vim-sexp-mappings-for-regular-people', {'for': 'clojure'}

Plug 'liquidz/vim-iced', {'for': 'clojure'}
let g:iced_enable_default_key_mappings = v:true

Plug 'liquidz/vim-iced-coc-source', {'for': 'clojure'}

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => COC.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'neoclide/coc.nvim', {'branch': 'release'}

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
    call CocActionAsync('doHover')
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

" Setup formatexpr specified filetype(s).
autocmd FileType typescript,json setl formatexpr=CocActionAsync'formatSelected')
" Update signature help on jump placeholder
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Remap for do codeAction of selected region
" function! s:cocActionsOpenFromSelected(type) abort
"   execute 'CocCommand actions.open ' . a:type
" endfunction
" xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
" nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

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

autocmd BufWritePre *.{js,jsx,ts,tsx} if exists(":CocAction") | :call CocAction('runCommand', 'eslint.executeAutofix') | sleep 100m | endif

call plug#end()
