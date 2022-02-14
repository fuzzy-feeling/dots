" Install vimplug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


"====== create undo dir ======"

if !isdirectory($HOME . "/.vim/undo")
    call mkdir($HOME . "/.vim/undo", "p", 0700)
endif

"====== plugins ======"

call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'connorholyday/vim-snazzy'
Plug 'vimwiki/vimwiki'
Plug 'chrisbra/Colorizer'
call plug#end()


"========= general =========

set ruler
set numberwidth=3
set number relativenumber
set t_Co=256
set termguicolors
set background=dark
colorscheme snazzy
let g:lightline = { 'colorscheme': 'snazzy', }
set laststatus=2
set clipboard=unnamedplus
set smartindent  
set tabstop=4  
set shiftwidth=4  
set expandtab  
set softtabstop=4  
set undofile
set undodir=/home/moe/.vim/undo/

"====== keybindings ======"

let mapleader=","
nmap <silent> <leader>t :NERDTreeTabsToggle<CR>
nmap <silent> <leader>b :TagbarToggle<CR>
nmap <silent> <leader>c :ColorToggle<CR>
nmap <silent> <leader>f :Files<CR>
nmap <silent> <leader>b :Buffer<CR>
nmap <silent> <leader>m :MarkdownPreviewToggle<CR>

"let s:color_highlight_state="-1"
"move current line
nnoremap [e  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]e  :<c-u>execute 'move +'. v:count1<cr>
"add empty line
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>'[
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>


"===== wiki =====
let g:vimwiki_list = [{'path': '~/zort/wiki/', 'path_html': '~/zort/wiki/html/', 'syntax': 'markdown', 'ext': '.md', "auto_export": 1}]


"========== cursor change ==========

let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"


"====== nerdtree ======"


let g:nerdtree_tabs_open_on_console_startup = 0
let g:nerdtree_tabs_open_on_gui_startup = 0
let NERDTreeShowHidden=1


