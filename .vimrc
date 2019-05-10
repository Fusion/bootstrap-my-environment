
" ---------------------------------------------------------------------------
" Global Configuration
" ---------------------------------------------------------------------------
"
" SETUP:
" Lua is required for neocomplete ( OS X: brew install --with-python3 " --with-lua )
" vim-plug is required ( Linux: curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim )
" Run :PlugInstall
"
" GOOD TO KNOW:
" indent using 2 spaces
" leader key: ,
" show invisible characters
" folding enabled
" aligning enabled :vip<Enter>ga or gaip
" filename autocomplete
" code autocompletion using neocomplete
" resume edit position
" tagbar enabled :TagbarToggle
" enable native file explorer
" distraction-free using :Goyo and :LimeLight
" enable OS X keypad
" tmux integration enabled
"
" IDE mode: using file explorer + tagbar + b <TAB> (wildmode) + :F + ctags
"
" CHEAT SHEET:
" comment out code: `gcc` or `<selection>gc`
" add a gfx-type comment: `:r !toilet -f pagga " My comment "`
" editing a remote file: `{vi|:e} scp://host//path/[file.txt]` or use sshfs
"
" SHORTCUTS:
" ┌─────────────────┬────────────────────────┬────────────┐
" │     Action      │        Shortcut        │ Doom Emacs │
" ├─────────────────┼────────────────────────┼────────────┤
" │ load buffer     │ :e {file}|<tab>        │ SPC .      │
" │ list buffers    │ :ls                    │ SPC ,      │
" │ delete buffer   │ :bd or :bd!            │            │
" │ wipe buffer     │ :bw                    │            │
" │ edit in new tab │ :tabe {file}|<tab>     │            │
" │ split window    │ <ctrl>w s or <ctrl>w v │            │
" │ new window      │ :new or :vnew          │            │
" │                 │ :sp or :vs             │            │
" │ navigate        │ <ctrl>w h/j/k/l        │            │
" │                 │ :bn/:bo                │            │
" │                 │ :b {name}|{number}     │            │
" └─────────────────┴────────────────────────┴────────────┘

set nocompatible               " be iMproved
filetype off                   " required!
set laststatus=2
set encoding=utf-8
set t_Co=256
let &t_ut=''
set title
set history=10000
let g:Powerline_symbols = 'fancy'
syntax on

" Full g:UPPERCASE variables will be persisted
set viminfo+=!

" Visible cursor
    let &t_ti.="\e[1 q"
    let &t_SI.="\e[5 q"
    let &t_EI.="\e[1 q"
    let &t_te.="\e[0 q"

" Indents
    set tabstop=4 " Set the default tabstop
    set softtabstop=4
    set shiftwidth=4 " Set the default shift width for indents
    set shiftround " Use multiples of shiftwidth when indenting
    set expandtab " Make tabs into spaces (set by tabstop)
    set smarttab " Smarter tab levels
    set autoindent " auto indent
    set copyindent " and preserve on next line
    set pastetoggle=<F2> " toggle indents when pasting in vim! " Alternatively: <C-r>+
    set list " show invisible characters enumerated below
    set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Wrapping
    set nowrap " do not wrap lines
    set sidescroll=15 " ?
    set backspace=indent,eol,start " backspace over everything
    set linebreak " Do not wrap words. Caution! May be confusing!

" Folding
    set foldlevel=0
    set foldnestmax=15
    set foldmethod=manual
" Saves manual folds
    "au BufWinLeave ?* mkview 1
    "au BufWinEnter ?* silent loadview 1

" Search
    set showmatch " show matching character
    set ignorecase " for searching
    set smartcase " but only if lower case entered
    set hlsearch " show what is being searched
    set incsearch " real time incremental search

" Various sizing settings
    set hidden " hide buffers instead of closing them...keep undo, changes etc
    set history=1000
    set undolevels=1000 " a proper stack
    set nobackup " do not create bak files
    set noswapfile " no more ridiculous recovery

" Moving around
    set virtualedit=block " move past end of line
    " Tell cursor to not move when joining lines (using z mark)
    nnoremap J mzJ`z
    " Always center after search/end of paragraph jump
    nnoremap n nzz
    nnoremap } }zz
    " Swap next row/next line commmands
    nnoremap j gj
    nnoremap k gk
    nnoremap gj j
    nnoremap gk k
    " Navigate tabs
    nnoremap <C-Left> :tabprevious<CR>
    nnoremap <C-Right> :tabnext<CR>
    nnoremap <esc>[5D :tabprevious<CR>
    nnoremap <esc>[5C :tabnext<CR>
    nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
    nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
    nnoremap <silent> <esc>b :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
    nnoremap <silent> <esc>f :execute 'silent! tabmove ' . (tabpagenr()+1)<CR>
    " Window resize, additionally to default <C-w>+
    nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
    nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>

    set splitbelow
    set splitright

" Files
    set wildmenu
    set wildmode=longest:full,full
    " try file dir, current dir, subdirs
    set path=.,,**

augroup vimrcEx
    autocmd!
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END

" :Explore
    let g:netrw_banner = 0
    let g:netrw_liststyle = 3
    let g:netrw_browse_split = 4
    let g:netrw_altv = 1
    let g:netrw_winsize = 25
    " Ensure buffer is deleted when hidden
    autocmd FileType netrw setl bufhidden=delete
" No, not by default!
"augroup ProjectDrawer
"    autocmd!
"    autocmd VimEnter * :Vexplore
"augroup END

" ---------------------------------------------------------------------------
" Keyboard, Leader key, etc.
" ---------------------------------------------------------------------------
"
    set shortmess=atI

" Leader Key
    let mapleader = ","
    let g:mapleader = ","

    map <Leader>vp :VimuxPromptCommand<CR>
    map <Leader>vq :VimuxCloseRunner<CR>
    map <Leader>vi :VimuxInspectRunner<CR>
    map <Leader>vs :VimuxInterruptRunner<CR>
" Run the current file with rspec
    map <Leader>vb :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
" rerun
    map <Leader>vl :VimuxRunLastCommand<CR>

    map <Leader>vyc :python run_tmux_python_chunk()<CR>
    map <Leader>vyb :python run_tmux_python_cell(False)<CR>
    map <Leader>vyg :python run_tmux_python_cell(True)<CR>

" make external keypad work in terminal vim OSX!
    map <Esc>Oq 1
    map <Esc>Or 2
    map <Esc>Os 3
    map <Esc>Ot 4
    map <Esc>Ou 5
    map <Esc>Ov 6
    map <Esc>Ow 7
    map <Esc>Ox 8
    map <Esc>Oy 9
    map <Esc>Op 0
    map <Esc>On .
    map <Esc>OQ /
    map <Esc>OR *
    map <kPlus> +
    map <Esc>OS -
    map <Esc>OM <CR>
    map! <Esc>Oq 1
    map! <Esc>Or 2
    map! <Esc>Os 3
    map! <Esc>Ot 4
    map! <Esc>Ou 5
    map! <Esc>Ov 6
    map! <Esc>Ow 7
    map! <Esc>Ox 8
    map! <Esc>Oy 9
    map! <Esc>Op 0
    map! <Esc>On .
    map! <Esc>OQ /
    map! <Esc>OR *
    map! <kPlus> +
    map! <Esc>OS -
    map! <Esc>OM <CR>

" Date insert
    :nnoremap <F4> "=strftime("%Y.%m.%d-%R")<CR>P
    :inoremap <F4> <C-R>=strftime("%Y.%m.%d-%R")<CR>

" Folding
    nnoremap <silent> <Space> @=(foldlevel('.')?'za':'l')<CR>
    vnoremap <Space> zf

" Switch visual buffers
map <Tab> <C-W>w

function! LoadVimPluginScript ()
    try
        call plug#begin('~/.vim/plugged')
        " Disabled for now as :b <TAB> fills same function
        " Plug 'fholgado/minibufexpl.vim'
        " Plug 'altercation/vim-colors-solarized'
        Plug 'bronson/vim-trailing-whitespace'
        Plug 'Shougo/vimproc.vim'
        Plug 'Shougo/neocomplete.vim'
        " A shell entirely in vim
        " :VimShell
        Plug 'Shougo/vimshell.vim'
        " Display git change status in gutter
        Plug 'airblade/vim-gitgutter'
        " Git integration
        " not working at this point
        Plug 'tpope/vim-fugitive'
        " Better parentheses
        " ADD COMMAND :RainbowToggle
        Plug 'luochen1990/rainbow'
        " Fancy status bar
        Plug 'itchyny/lightline.vim'
        " Vim and Tmux
        " Alt+arrow keys etc
        Plug 'christoomey/vim-tmux-navigator'
        " BD to close file but keep buffer open
        Plug 'qpkorr/vim-bufkill'
        " Fuzzy search/open
        " UPDATE COMMAND: :Files
        " FZF FZF ~ FZF --no-sort -m /tmp FZF! <Ctrl>-t <Ctrl>-x <Ctrl>-v
        Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
        Plug 'junegunn/fzf.vim'
        " Gray out what is not currently being edited
        " ADD COMMAND :LimeLight
        " ADD COMMAND :LimeLight!
        Plug 'junegunn/limelight.vim'
        " Distraction free mode
        " ADD COMMAND :Goyo and Goyo!
        Plug 'junegunn/goyo.vim'
        " Surround with characters
        " replace surrounding " with ': cs"'
        " delete surround ": ds"
        " surround word with []: ysiw]
        Plug 'tpope/vim-surround'
        " [ and ] cmds such as ]b switch buffers
        Plug 'tpope/vim-unimpaired'
        " Auto comments
        Plug 'tpope/vim-commentary'
        " Align code, json, etc.
        " vip<Enter>= or gaip= (align around '=')
        Plug 'junegunn/vim-easy-align'
        " Markup preview
        " :Xmark> :Xmark< :Xmark+ :Xmark- :Xmark!
        Plug 'junegunn/vim-xmark'
        " Tags
        Plug 'xolox/vim-misc'
        " ADD COMMAND :UpdateTags
        Plug 'xolox/vim-easytags'
        Plug 'majutsushi/tagbar'
        " SCSS
        "Plug 'cakebaker/scss-syntax.vim'
        " Go Lang
        "Plug 'fatih/vim-go'
        " Elixir
        "Plug 'elixir-editors/vim-elixir'
        "Plug 'slashmili/alchemist.vim'
        " Nim
        "Plug 'baabelfish/nvim-nim'
        " ReasonML
        "Plug 'roxma/vim-hug-neovim-rpc'
        "Plug 'roxma/nvim-yarp'
        "Plug 'reasonml-editor/vim-reason-plus'
        Plug 'jordwalke/vim-reasonml'
        "  Complete everything!
        Plug 'zxqfl/tabnine-vim'
        " Databases Management
        Plug 'tpope/vim-db'
        Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
        " Open in browser
        Plug 'tyru/open-browser.vim'
        Plug 'kannokanno/previm'
        " Color Schemes, if any
        Plug 'fenetikm/falcon'
        Plug 'prognostic/plasticine'
        Plug 'cormacrelf/vim-colors-github'

        " Neovim TMUX bindinds
        "Plug 'hkupty/nvimux'
        "
        call plug#end()
    catch
        " sigh
    endtry
endfunction

augroup loadVimPlugins
    autocmd!
    autocmd VimEnter * call LoadVimPluginScript()
augroup END

augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

" ---------------------------------------------------------------------------
" Plugin interdependencies
" ---------------------------------------------------------------------------
"
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

filetype plugin indent on     " required!

" ---------------------------------------------------------------------------
" Everything below depends on external binaries
" ---------------------------------------------------------------------------

" Add fzf to vim's plugin search
set rtp+=~/.fzf

" ---------------------------------------------------------------------------
" Everything below depends on plugins
" ---------------------------------------------------------------------------

" -- color personal conf
set termguicolors
set background=dark
try
    colorscheme falcon
catch
endtry

" -- limelight visibility
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" -- easy align mapping
" ADD COMMAND vip<Enter>ga
" ADD COMMAND gaip
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" now try vip<Enter>= or gaip= (align around '=')

" -- 80th columns
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

" -- Auto completion
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" -- Align
vnoremap <silent> <Enter> :EasyAlign<cr>

" -- TagBar
" ADD COMMAND :TagbarToggle
nmap <F2> :TagbarToggle<CR>
let g:tagbar_vertical = 1

" ---------------------------------------------------------------------------
" Rainbow Parens
" ---------------------------------------------------------------------------
"
let g:rainbow_active = 1

" ---------------------------------------------------------------------------
" Lightline
" ---------------------------------------------------------------------------
"
let g:lightline = {
    \ 'colorscheme': 'landscape',
    \ }
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename', 'modified', 'cfrhelp', 'charvaluehex' ] ]
    \ },
    \ 'component': {
    \   'cfrhelp': 'Ide<Tab>',
    \   'charvaluehex': '0x%B'
    \ },
    \ }

" ---------------------------------------------------------------------------
" TMUX Integration
" ---------------------------------------------------------------------------
"
if $TMUX != ''
  " integrate movement between tmux/vim panes/windows

  fun! TmuxMove(direction)
    " Check if we are currently focusing on a edge window.
    " To achieve that,  move to/from the requested window and
    " see if the window number changed
    let oldw = winnr()
    silent! exe 'wincmd ' . a:direction
    let neww = winnr()
    silent! exe oldw . 'wincmd'
    if oldw == neww
      " The focused window is at an edge, so ask tmux to switch panes
      if a:direction == 'j'
        call system("tmux select-pane -D")
      elseif a:direction == 'k'
        call system("tmux select-pane -U")
      elseif a:direction == 'h'
        call system("tmux select-pane -L")
      elseif a:direction == 'l'
        call system("tmux select-pane -R")
      endif
    else
      exe 'wincmd ' . a:direction
    end
  endfun

  function! TmuxSharedYank()
    " Send the contents of the 't' register to a temporary file, invoke
    " copy to tmux using load-buffer, and then to xclip
    " FIXME for some reason, the 'tmux load-buffer -' form will hang
    " when used with 'system()' which takes a second argument as stdin.
    let tmpfile = tempname()
    call writefile(split(@t, '\n'), tmpfile, 'b')
    call system('tmux load-buffer '.shellescape(tmpfile).';tmux show-buffer | xclip -i -selection clipboard')
    call delete(tmpfile)
  endfunction

  function! TmuxSharedPaste()
    " put tmux copy buffer into the t register, the mapping will handle
    " pasting into the buffer
    let @t = system('xclip -o -selection clipboard | tmux load-buffer -;tmux show-buffer')
  endfunction


  nnoremap <silent> <c-w>j :silent call TmuxMove('j')<cr>
  nnoremap <silent> <c-w>k :silent call TmuxMove('k')<cr>
  nnoremap <silent> <c-w>h :silent call TmuxMove('h')<cr>
  nnoremap <silent> <c-w>l :silent call TmuxMove('l')<cr>
  nnoremap <silent> <c-w><down> :silent call TmuxMove('j')<cr>
  nnoremap <silent> <c-w><up> :silent call TmuxMove('k')<cr>
  nnoremap <silent> <c-w><left> :silent call TmuxMove('h')<cr>
  nnoremap <silent> <c-w><right> :silent call TmuxMove('l')<cr>

  vnoremap <silent> <esc>y "ty:call TmuxSharedYank()<cr>
  vnoremap <silent> <esc>d "td:call TmuxSharedYank()<cr>
  nnoremap <silent> <esc>p :call TmuxSharedPaste()<cr>"tp
  vnoremap <silent> <esc>p d:call TmuxSharedPaste()<cr>h"tp  
  set clipboard= " Use this or vim will automatically put deleted text into x11 selection('*' register) which breaks the above map

  " Quickly send text to a pane using f6
  nnoremap <silent> <f6> :SlimuxREPLSendLine<cr>  
  inoremap <silent> <f6> <esc>:SlimuxREPLSendLine<cr>i " Doesn't break out of insert
  vnoremap <silent> <f6> :SlimuxREPLSendSelection<cr>

  " Quickly restart your debugger/console/webserver. Eg: if you are developing a node.js web app
  " in the 'serve.js' file you can quickly restart the server with this mapping:
  nnoremap <silent> <f5> :call SlimuxSendKeys('C-C " node serve.js" Enter')<cr>
  " pay attention to the space before 'node', this is actually required as send-keys will eat the first key

endif

" ---------------------------------------------------------------------------
" Filetype specific options
" ---------------------------------------------------------------------------
"
" Map markdown to recognized extension
    autocmd! BufRead,BufNewFile *.markdown set filetype=markdown
    autocmd! BufRead,BufNewFile *.md       set filetype=markdown

" For all text files
    autocmd FileType text
                \ highlight Excess ctermbg=DarkGrey guibg=Black |
                \ match Excess /\%78v.*/ |
                \ set nowrap

" Vimrc
    autocmd BufEnter vimrc setlocal nospell

" Vim Outliner
    autocmd BufEnter,BufNewFile *.otl
                \ setlocal nonumber |
                \ setlocal spell |
                \ highlight Excess ctermbg=DarkGrey guibg=Black |
                \ match Excess /\%78v.*/ |
                \ set nowrap |
                \ imap <S-CR> <CR><C-t>|
                \ imap <C-S-CR> <CR><C-d><BS>

" Text files
    autocmd BufEnter,BufNewFile *.txt
                \ setlocal spell |
                \ setlocal wrap |
                \ highlight Excess ctermbg=DarkGrey guibg=Black |
                \ match Excess /\%78v.*/ |
                \ set nowrap

" Python Files
    autocmd FileType python
        \ highlight Excess ctermbg=DarkGrey guibg=Black |
        \ match Excess /\%78v.*/ |
        \ set nowrap

" Markdown
    autocmd FileType mkd
        \ setlocal autoindent |
        \ setlocal colorcolumn=0 |
        \ setlocal linebreak |
        \ setlocal nonumber |
        \ setlocal shiftwidth=2 |
        \ setlocal spell |
        \ setlocal tabstop=4 |
        \ setlocal wrap

" Lisp
    "let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\" to do script \"~/Applications/ccl/dx86cl64 --load ~/.vim/plugged/slimv/slime/start-swank.lisp\""'

" ReasonML
""autocmd BufReadPost *.re setlocal filetype=reason

" Language Client
""let g:LanguageClient_loggingLevel = 'DEBUG'

""let g:LanguageClient_serverCommands = {
""    \ 'reason': ['ocaml-language-server', '--stdio'],
""    \ 'ocaml': ['ocaml-language-server', '--stdio'],
""    \ }
""let g:LanguageClient_autoStart = 1

nnoremap <silent> gd :call LanguageClient_textDocument_definition()<cr>
nnoremap <silent> gf :call LanguageClient_textDocument_formatting()<cr>
nnoremap <silent> <cr> :call LanguageClient_textDocument_hover()<cr>

" fzf-rg
" ADD COMMAND: :F
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '
command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

" Faster default grep
set grepprg=rg\ --vimgrep
" Use K to search for word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" ---------------------------------------------------------------------------
" CFR Specific
" ---------------------------------------------------------------------------
"

" Switch to IDE mode
function! CfrIde()
    Vexplore
    TagbarOpen
    RainbowToggleOn
    resize 25
endfunction

command! Ide call CfrIde()

function! CfrIdeHelp()
    new
    call append("$", "To index entire project's tags:")
    call append("$", "    ctags -R .")
    call append("$", "")
    call append("$", "Quick buffer switch: :b <TAB>")
    call append("$", "")
    call append("$", "Command line window: q: or q?")
    call append("$", "")
    call append("$", "Shell buffer: Vimshell<Tab>")
    call append("$", "")
    call append("$", "Avoid sessions whenever possible. They suck.")
    call append("$", "")
    call append("$", "Please close this buffer using:")
    call append("$", "    :q!")
endfunction

command! Idehelp call CfrIdeHelp()

function! CfrIdeInit()
    " Nothing here, for now.
endfunction

augroup ProjectDrawer
    autocmd!
    autocmd VimEnter * call CfrIdeInit()
augroup END

" -- Local settings, if any
try
    source ~/.vimrc.local
catch
endtry
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
