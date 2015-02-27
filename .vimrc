" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %


" Better copy & paste
" When you want to paste large blocks of code into vim, press F2 before you
" paste. At the bottom you should see ``-- INSERT (paste) --``.

set pastetoggle=<F2>
set clipboard=unnamed


" Rebind <Leader> key
" I like to have it here becuase it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = " "


" Bind nohl
" Removes highlight of your last search
" ``<C>`` stands for ``CTRL`` and therefore ``<C-n>`` stands for ``CTRL+n``
noremap <C-n> :nohl<CR>
vnoremap <C-n> :nohl<CR>
inoremap <C-n> :nohl<CR>


" Quicksave command
noremap <C-Z> :update<CR>
vnoremap <C-Z> <C-C>:update<CR>
inoremap <C-Z> <C-O>:update<CR>


" Quick quit command
nnoremap <leader>qq  :q!<cr>  " Force quite without saving
nnoremap <leader>qa  :qa<cr>  " Quit all windows
nnoremap <leader>qqa :qa!<cr> " Force quit all windows without saving
nnoremap <leader>ww  :wq<cr>  " Save and quit (the same az ZZ but compilant with the above ones)
nnoremap <leader>w   :w<cr>   " Save file (shorter than :w<cr>)


" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" map sort function to a key
vnoremap <Leader>s :sort<CR>


" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


" Show whitespace
" MUST be inserted BEFORE the colorscheme command
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" au InsertLeave * match ExtraWhitespace /\s\+$/


" Color scheme
" mkdir -p ~/.vim/colors && cd ~/.vim/colors
" wget -O wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
" set t_Co=256
" color wombat256mod


" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on


" Showing line numbers and length
set number  " show line numbers
set tw=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
" set colorcolumn=80
" highlight ColorColumn ctermbg=233

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Custom file types
autocmd BufRead,BufNewFile *.supervisord.conf setlocal filetype=dosini

" Settings for vim-powerline
" cd ~/.vim/bundle
" git clone git://github.com/Lokaltog/vim-powerline.git
set laststatus=2


" Settings for ctrlp
" cd ~/.vim/bundle
" git clone https://github.com/kien/ctrlp.vim.git
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*


" Settings for jedi-vim
" cd ~/.vim/bundle
" git clone git://github.com/davidhalter/jedi-vim.git
let g:jedi#usages_command = "<leader>u"
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
        if a:action == 'j'
            return "\<C-N>"
        elseif a:action == 'k'
            return "\<C-P>"
        endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>


" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
set nofoldenable

set showcmd
 

" Swap ctrl-r and r functions
nnoremap <C-r> r
nnoremap r <C-r>

" Replate unused B end E commands to Home (^) and End ($) respecively
noremap B ^
noremap E $

" Navigate commands using ctrl-j and ctrl-k keys instead of arrows
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>

nnoremap ; :

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python   let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" Required
Plugin 'gmarik/Vundle.vim'

Plugin 'davidhalter/jedi-vim'
Plugin 'kien/ctrlp.vim'
" Plugin 'klen/python-mode'

call vundle#end()
filetype plugin indent on

autocmd BufNew,BufRead SConstruct,SConscript setf python

" python-mode                                                                   
" " https://github.com/klen/python-mode                                           
let g:pymode_virtualenv=1 " Auto fix vim python paths if virtualenv enabled        
" let g:pymode_folding=1  " Enable python folding                                 
" let g:pymode_utils_whitespaces=0  " Do not autoremove unused whitespaces        
" map <Leader>rgd :call RopeGotoDefinition()<CR>                                  
" map <Leader>pl :PyLint<CR>                                                      
" let ropevim_enable_shortcuts=1                                                  
" let g:pymode_rope_goto_def_newwin="vnew"                                        
" let g:pymode_rope_extended_complete=1                                           
" let g:pymode_syntax=1                                                           
" let g:pymode_syntax_builtin_objs=0                                              
" let g:pymode_syntax_builtin_funcs=0                                             
" let g:pymode_lint_ignore = "C0110 Exported"  " ignore pep257 missing docstring warning
" let g:pymode_lint_minheight = 5   " Minimal height of pylint error window          
" let g:pymode_lint_maxheight = 15  " Maximal height of pylint error window          
" let g:pymode_lint_write = 0  " Disable pylint checking every save               
" let g:pymode_run_key = "<leader>run"  " default key conflicts with jedi-vim        
" let g:pymode_lint_mccabe_complexity = 10                                        
" let g:pymode_lint_checker="pyflakes,pep8,pep257,mccabe"                         
" let g:pymode_syntax_highlight_self=0  " do not highlight self                   
" let g:pymode_rope_vim_completion=0  " use jedi-vim for completion               
" let g:pymode_rope_guess_project=0                                               
" let g:pymode_doc_key="<leader>k"  " used jedi-vim for help 
