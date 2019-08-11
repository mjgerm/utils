" Colors
set background=dark
syntax enable

" Line Numbers
set number

" Tabs
set noexpandtab
set tabstop=3
set softtabstop=3
set shiftwidth=3
set autoindent

" Searching
set ignorecase
set smartcase
set incsearch
set hlsearch

" Tab Completion
set wildmode=longest,list,full

" Commands
set showcmd

" Specialized Tweaks
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab
