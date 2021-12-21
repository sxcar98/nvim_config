"-------------------------------------------------Refresh UI------------------------------------------
" ChangeBackground changes the background mode based on macOS's `Appearance`"

function! RefreshUI()
    if system("defaults read -g AppleInterfaceStyle") =~ '^Dark'
        set background=dark
    else
        set background=light
    endif
endfunction

call RefreshUI()

"-----------------------------------------------Options----------------------------------------------------

syntax on                                                   " syntax highlight
set number                                                  " show line number
set wrap                                                    " autofold when window space is enough
set cursorline                                              " show the line draw under selected line
set wildmenu                                                " press Tab to show a wilder menu
set showcmd                                                 " show keys just pressed at bottom left
set vb t_vb=                                                " disable annoying beeping and flashing
set hlsearch                                                " highlight search result
set incsearch                                               " incremental search
set tabstop=4                                               " Tab length
set softtabstop=4                                           " press Backspace to delete 4 space
set shiftwidth=4                                            " indent length for autoindent
set expandtab                                               " set tab as constant blanks
set autoindent                                              " autoindent on
color gruvbox                                               " theme select

"-----------------------------------------------keymaps----------------------------------------------------

let mapleader=","
set pastetoggle=<f2>
inoremap jj <esc>
nnoremap <leader>w :w<cr>
nnoremap <leader>q :wq<cr>
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
nnoremap <leader>r :source $MYVIMRC<cr>
nnoremap <f4> :call RefreshUI()<cr>
