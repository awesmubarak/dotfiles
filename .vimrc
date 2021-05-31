" Install Plug using the following command:
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Then run ':PlugInstall' to install all packages

set clipboard=unnamed
set number
set mouse=a
set path+=**
set backspace=indent,eol,start
set tabstop=4 shiftwidth=4 expandtab
filetype plugin indent on
syntax on

nnoremap <SPACE> <Nop>
let mapleader=" "

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevel=99 " Open all folds


inoremap <F9> <C-O>za
nnoremap <F9> za
onoremap <F9> <C-C>za
vnoremap <F9> zf


call plug#begin('~/.vim/plugged')
    " vim-commentary
    "   <g-c>
    Plug 'tpope/vim-commentary'

    " fugitive
    "   :Git
     Plug 'tpope/vim-fugitive'

    " vim sandwich
    "     s
    Plug 'machakann/vim-sandwich'

    " vim-startify
    Plug 'mhinz/vim-startify'
    let g:startify_bookmarks = [ {'c': '~/.vimrc'}, '~/.zshrc' ]

    " airline: statusline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    let g:airline_powerline_fonts = 0
    let g:airline_theme='bubblegum'
    let g:airline#extensions#tabline#enabled = 1     " Show buffer list

    " Nerdtree
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    nnoremap <leader>n :NERDTreeToggle<CR>

        " Exit Vim if NERDTree is the only window left.
        autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ quit | endif

        " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
        autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
            \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

    set signcolumn=number

    " other
    Plug 'ambv/black'
    Plug 'easymotion/vim-easymotion'
    Plug 'ryanoasis/vim-devicons'
    Plug 'airblade/vim-gitgutter'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'Yggdroot/indentLine'
    Plug 'joshdick/onedark.vim', { 'as': 'onedark' }


    if has('nvim')
        Plug 'neovim/nvim-lspconfig'
        Plug 'hrsh7th/nvim-compe'
        Plug 'lukas-reineke/indent-blankline.nvim'
        Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
        Plug 'simrat39/symbols-outline.nvim'
        nnoremap <leader>s :SymbolsOutline<CR>

    endif

call plug#end()

color onedark
let g:onedark_termcolors=16
