" Install Plug using the following command:
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Then run ':PlugInstall' to install all packages

set clipboard=unnamed
set number
set path+=**
set backspace=indent,eol,start
set tabstop=4 shiftwidth=4 expandtab

nnoremap <SPACE> <Nop>
let mapleader=" "

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


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

    " other
    Plug 'ambv/black'
    Plug 'easymotion/vim-easymotion'
    Plug 'ryanoasis/vim-devicons'
    Plug 'airblade/vim-gitgutter'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    if has('nvim')
        Plug 'neovim/nvim-lspconfig'
        Plug 'hrsh7th/nvim-compe'
    endif

call plug#end()
