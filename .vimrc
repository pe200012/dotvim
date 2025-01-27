"=====================================================================================
"                                  My Vimrc Configuration File
"=====================================================================================

"---------------------------
"        VIM Setup
"---------------------------

"~~~~~~~~~~~~~~~~~~~~~~~~~~~
"        Basic Setup
"~~~~~~~~~~~~~~~~~~~~~~~~~~~
set nocp
set nowrap
set hlsearch
set incsearch
set smartcase
set t_Co=256
set cmdheight=2
set laststatus=2
syntax enable
set autoindent
set cindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set number
set ruler
set showmatch
set nocursorline
set hidden
set magic
set scrolloff=3
set foldenable
set foldmethod=indent
set foldcolumn=2
set autoread
filetype on
filetype indent on
filetype plugin on
set backspace=2
set matchtime=1
let autosave=1
set visualbell
set noerrorbells

if exists('g:gui_oni')
    filetype off
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd
    set mouse=a
endif

"~~~~~~~~~~~~~~~~~~~~~~~~~~~
"        Extra Setup
"~~~~~~~~~~~~~~~~~~~~~~~~~~~
"进入文件目录
au BufRead,BufNewFile,BufEnter * cd %:p:h

"打开上次文件
set viminfo='10,\"100,:20,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"~~~~~~~~~~~~~~~~~~~~~~~~~~~
"        Key Binding
"~~~~~~~~~~~~~~~~~~~~~~~~~~~
"设置切换Buffer快捷键"
nnoremap <C-b> :bd<CR>
nnoremap <C-Right> :bn<CR>
nnoremap <C-Left> :bp<CR>

"展开/折叠
nnoremap <Space> za

"光标始终居中
nnoremap j <DOWN>zz
nnoremap k <UP>zz

"恢复上次光标位置
if has("autocmd")
au BufReadPost * if line("`\"") > 1 && line("`\"") <= line("$") | exe "normal! g`\"" | endif
" for simplicity, "  au BufReadPost * exe "normal! g`\"", is Okay.
endif

"取消搜索高亮
nnoremap <esc><esc> :noh<return>

"---------------------------
"   Third-party Packages
"---------------------------
call plug#begin('~/.vim/plugged')

"--------input method------
Plug 'lilydjwg/fcitx.vim', {'branch': 'fcitx5'}
"--------language-----------
Plug 'leafo/moonscript-vim'
Plug 'cstrahan/vim-capnp'
"-------status bar ---------
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"-------fuzzy search -------
"Plug 'ctrlpvim/ctrlp.vim'
"Plug 'tacahiroy/ctrlp-funky'

"-------indent tools -------
Plug 'nathanaelkane/vim-indent-guides'

"------github corperation---
Plug 'tpope/vim-fugitive'

"------Auto completion------
Plug 'prabirshrestha/async.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'Shougo/deoplete.nvim'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'rust-lang/rust.vim'
"Plug 'gu-fan/riv.vim'
"Plug 'gu-fan/InstantRst'

"---------snippets----------
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

"---------theme-------------
Plug 'altercation/vim-colors-solarized'
Plug 'sickill/vim-monokai'
Plug 'joshdick/onedark.vim', {'branch': 'main'}

"----project management-----
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-rhubarb'

"-------------UML-----------
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'aklt/plantuml-syntax'
Plug 'tyru/open-browser.vim'

"------------Utils----------
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

call plug#end()

"~~~~~~~~~~~~~~~~~~~~~~~~~~~
"   Package Configuration
"~~~~~~~~~~~~~~~~~~~~~~~~~~~
"###########################
"         ALE
"###########################
let g:ale_sign_error                  = '✘'
let g:ale_sign_warning                = '⚠'
"highlight ALEErrorSign ctermbg        =NONE ctermfg=red
"highlight ALEWarningSign ctermbg      =NONE ctermfg=yellow
let g:ale_linters_explicit            = 1
"let g:ale_lint_on_text_changed        = 'never'
let g:ale_lint_on_enter               = 1
let g:ale_lint_on_save                = 1
let g:ale_fix_on_save                 = 1

let g:ale_linters = {
\   'ocaml':      ['merlin'],
\}

let g:ale_fixers = {
\   'ocaml':      ['ocamlformat'],
\   '*':          ['remove_trailing_lines', 'trim_whitespace'],
\}
"###########################
"         coc.nvim
"###########################
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
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
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'edior.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>t

"###########################
"		  airline
"###########################
let g:airline_theme='onedark'
let g:airline_powerline_fonts = 1

"打开tabline功能,方便查看Buffer和切换"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

"关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'

"###########################
"         fcitx.vim
"###########################
let g:ttimeoutlen = 100
"###########################
"         vim-lsp
"###########################
if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

"###########################
"         deoplete
"###########################


"###########################
"      vim-solarized8
"###########################
" set background=dark
" colorscheme solarized

"###########################
"      vim-monokai
"###########################
colorscheme monokai

"###########################
"      onedark.vim
"###########################
colorscheme onedark
let g:onedark_terminal_italics=1

"###########################
"	       NERDTree
"###########################
"if !has('nvim')
"    "open a NERDTree automatically when vim starts up if no files were specified
"    "autocmd StdinReadPre * let s:std_in=1
"    "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"
"    "open NERDTree automatically when vim starts up on opening a directory
"    autocmd StdinReadPre * let s:std_in=1
"    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
"
"    "close vim if the only window left open is a NERDTree
"    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
"    " NERDTress File highlighting
"    function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
"        exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
"        exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
"    endfunction
"
"    call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
"    call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
"    call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
"    call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
"    call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
"    call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
"    call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
"    call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
"    call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
"    call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
"    call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
"    call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
"    call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
"
"    "mapping key to toggle
"    nnoremap <F4> :NERDTreeToggle<CR>
"endif

"###########################
"	  nerdtree-git-plugin
"###########################
let g:NERDTreeGitStatusShowIgnored = 1

"=====================================================================================
"                                          EOF
"=====================================================================================
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
" ## added by OPAM user-setup for vim / ocp-indent ## a10dd78dc39d77358268301532e82d07 ## you can edit, but keep this line
if count(s:opam_available_tools,"ocp-indent") == 0
  source "/home/pe200012/.opam/4.10.0+flambda/share/ocp-indent/vim/indent/ocaml.vim"
endif
" ## end of OPAM user-setup addition for vim / ocp-indent ## keep this line
