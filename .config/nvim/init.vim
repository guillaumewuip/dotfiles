lua require('settings')

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin()

let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/opt/homebrew/bin/python3'

Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'ianks/vim-tsx'
Plug 'GutenYe/json5.vim'

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
let g:fzf_preview_filelist_command = 'rg --files --hidden --follow --no-messages'
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

"Browse github
nmap <Leader>b :CocCommand git.browserOpen<CR>

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

Plug 'cespare/vim-toml', { 'branch': 'main' }
Plug 'jxnblk/vim-mdx-js'

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
autocmd FileType typescript,json setl formatexpr=CocActionAsync('formatSelected')
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
