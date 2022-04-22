" Hello and welcome!

let mapleader =","

if ! filereadable(expand('~/.config/nvim/autoload/plug.vim'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ~/.config/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ~/.config/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')

    Plug 'machakann/vim-sandwich'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'mcchrish/nnn.vim' "File Manager.

    Plug 'junegunn/goyo.vim'
    Plug 'junegunn/limelight.vim'

    Plug 'kovetskiy/sxhkd-vim' " detects sxhkd filetype
    Plug 'frazrepo/vim-rainbow'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'norcalli/nvim-colorizer.lua'
    " Plug 'ap/vim-css-color', { 'for': [ 'css', 'scss' ] }
    " Plug 'psf/black', { 'branch': 'stable' }

    " theming
    syntax on
    set redrawtime=10000
    if (has("termguicolors"))
        set termguicolors
    endif
    colorscheme selenized_bw
    set background=dark
    " make background transparent
    hi NonText ctermbg=none
    hi Normal guibg=NONE ctermbg=NONE

    Plug 'bling/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme='transparent'

call plug#end()

" path to python
    let g:python3_host_prog = '/usr/bin/python3'
    let g:python_host_prog = '/usr/bin/python2'

    " lua require'colorizer'.setup()    " adds colors to all filetypes

" Some basics:
    set go=a
    set mouse=a                         " automatically enable mouse usage
    set completeopt+=preview

    " search
    set incsearch                       " find as you type
    set hlsearch                        " highlight search terms
    set ignorecase                      " case insensitive search
    set smartcase                       " case sensitive when upper case present
    " clear current search highlighting with //
    nmap <silent> // :nohlsearch<CR>

    " indentation and tabbing
    filetype indent on
    set autoindent
    set tabstop
    set expandtab
    set softtabstop=4
    set shiftwidth=4

    set clipboard+=unnamedplus
    set updatetime=300
    set nocompatible
    set encoding=utf-8
    set number relativenumber
    autocmd CursorHold * update
    set nofoldenable
    set noswapfile
    filetype plugin on
    set foldmethod=syntax

    nnoremap <leader>sv :source $MYVIMRC<cr>

" Enable autocompletion:
    set wildmode=longest,list,full

" Move up and down in autocomplete with <c-j> and <c-k>
    inoremap <expr> <C-j> ("\<C-n>")
    inoremap <expr> <C-k> ("\<C-p>")

    autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Disables automatic commenting on newline:
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" vim rainbow settings
    let g:rainbow_active = 1

" nnn
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }
let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }
nnoremap <leader>n :NnnPicker %:p:h<CR>
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

" Alt-hjkl to resize splits
    noremap <A-h> :vertical resize -5<CR>
    noremap <A-l> :vertical resize +5<CR>
    noremap <A-j> :resize -5<CR>
    noremap <A-k> :resize +5<CR>

" Ctrl maps for buffers
    map <C-b> :buffers<CR>
    map <C-Up> :bnext<CR>
    map <C-n> :bnext<CR>
    map <C-Down> :bprevious<CR>

" run Black with F9
    " nnoremap <F9> :Black<CR>

" spell-check set to <leader>o, 'o' for 'orthography':
    map <leader>o :setlocal spell! spelllang=en_us<CR>

" check file in shellcheck:
    map <leader>s :!clear && shellcheck %<CR>

" replace all is aliased to S.
    nnoremap S :%s//g<Left><Left>

" make it so
    map <leader>c :w! \| !compiler <c-r>%<CR>

" open corresponding .pdf/.html or preview
    map <leader>p :!opout <c-r>%<CR><CR>

    autocmd BufRead,BufNewFile /tmp/calcurse* set filetype=markdown
    autocmd BufRead,BufNewFile *.ms,*.me,*.mom,*.man set filetype=groff
    autocmd BufRead,BufNewFile *.tex set filetype=tex

" Goyo plugin makes text more readable when writing prose:
    map <leader>g :Goyo \| set linebreak<CR>

" enable Goyo by default for mutt writting
	" Goyo's width will be the line limit in mutt.
    autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
    autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo

" Leave goyo with a single :wq, rather than two (two is intended behavior
" but it's annoying, especially when composing emails)
    function! s:goyo_enter()
      let b:quitting = 0
      let b:quitting_bang = 0
      autocmd QuitPre <buffer> let b:quitting = 1
      cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
    endfunction

    function! s:goyo_leave()
      if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
        if b:quitting_bang
          qa!
        else
          qa
        endif
      endif
    endfunction

    autocmd! User GoyoEnter call <SID>goyo_enter()
    autocmd! User GoyoLeave call <SID>goyo_leave()

" Goyo and Limelight activate and deactivated together
    autocmd! User GoyoEnter Limelight
    autocmd! User GoyoLeave Limelight!

" Color name (:help cterm-colors) or ANSI code
    let g:limelight_conceal_ctermfg = 'gray'
    let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
    let g:limelight_conceal_guifg = 'DarkGray'
    let g:limelight_conceal_guifg = '#777777'

" Automatically deletes all trailing whitespace on save.
    autocmd BufWritePre * %s/\s\+$//e

" When shortcut files are updated:
    autocmd BufWritePost ~/.config/bmdirs,~/.config/bmfiles !shortcuts

" Update binds when sxhkdrc is updated.
    autocmd BufWritePost *sxhkdrc !pkill -USR1 sxhkd

" Run xrdb whenever Xdefaults or Xresources are updated.
    autocmd BufWritePost *Xresources,*Xdefaults !xrdb %

" Alias write and quit to Q
    nnoremap Q :wq<CR>

" Navigating with guides
    inoremap ;g <++>
    inoremap <leader><leader> <Esc>/<++><Enter>"_c4l
    vnoremap <leader><leader> <Esc>/<++><Enter>"_c4l
    map <leader><leader> <Esc>/<++><Enter>"_c4l

" Save file as sudo on files that require root permission
    cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" add date to bottom of file
    map <A-d> Go<ESC>o<ESC>0i last updated: <C-r>=strftime('%F')<CR>

" markdown
    autocmd Filetype markdown,rmd inoremap ,d last updated: <C-r>=strftime('%F')<CR>
    autocmd Filetype markdown,rmd map <leader>w yiWi[<esc>Ea](<esc>pa)
    autocmd Filetype markdown,rmd inoremap ,n ---<Enter><Enter>
    autocmd Filetype markdown,rmd inoremap ,b ****<++><Esc>F*hi
    autocmd Filetype markdown,rmd inoremap ,s ~~~~<++><Esc>F~hi
    autocmd Filetype markdown,rmd inoremap ,e **<++><Esc>F*i
    autocmd Filetype markdown,rmd inoremap ,h ====<Space><++><Esc>F=hi
    autocmd Filetype markdown,rmd inoremap ,i ![](<++>)<++><Esc>F[a
    autocmd Filetype markdown,rmd inoremap ,a [](<++>)<++><Esc>F[a
    autocmd Filetype markdown,rmd inoremap ,1 #<Space><Enter><++><Esc>kA
    autocmd Filetype markdown,rmd inoremap ,2 ##<Space><Enter><++><Esc>kA
    autocmd Filetype markdown,rmd inoremap ,3 ###<Space><Enter><++><Esc>kA
    autocmd Filetype markdown,rmd inoremap ,l --------<Enter>
    autocmd Filetype rmd inoremap ,r ```{r}<CR>```<CR><CR><esc>2kO
    autocmd Filetype rmd inoremap ,p ```{python}<CR>```<CR><CR><esc>2kO
    autocmd Filetype rmd inoremap ,c ```<cr>```<cr><cr><esc>2kO

" markdown preview
    let g:mkdp_auto_start = 0
    let g:mkdp_auto_close = 1
    let g:mkdp_refresh_slow = 0 " 0 == autorefresh
    let g:mkdp_page_title = '「${name}」'

" citations
    " map <leader>b :vsp<space>$BIB<CR>
    " map <leader>r :vsp<space>$REFER<CR>
    " let g:citation_vim_bibtex_file="repos/life/dox/acad.bib"
    let g:citation_vim_mode="bibtex"
    let g:citation_vim_cache_path='~/.config/nvim/cache'
    " let g:citation_vim_description_format = "{} ┃ {} ┃ {} ┃ {} ┃ {}"
    " let g:citation_vim_description_fields = ["key","author","publication","journal","doi"]

    " coc
source $HOME/.config/nvim/plugins/coc.vim
