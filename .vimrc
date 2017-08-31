filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" " let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Chiel92/vim-autoformat'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'klen/python-mode'
Plugin 'dracula/vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'vimwiki/vimwiki'
Plugin 'Rykka/mathematic.vim'
Plugin 'vim-scripts/Conque-GDB'
Plugin 'rust-lang/rust.vim'
Plugin 'JamshedVesuna/vim-markdown-preview'

" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" leader mapping
let mapleader = "-"

" color scheme
syntax on
let g:molokai_orginal = 1
" color codeschool
" color dracula

" display settings
set encoding=utf-8 " encoding used for displaying file
set ruler " show the cursor position all the time
set showmatch " highlight matching braces
set showmode " show insert/replace/visual mode

" edit settings
set backspace=indent,eol,start " backspacing over everything in insert mode
set expandtab " fill tabs with spaces
set nojoinspaces " no extra space after '.' when joining lines
set shiftwidth=2 " set indentation depth to 2 columns
set tabstop=2 " set tabulator length to 2 columns
set textwidth=80 " wrap lines automatically at 80th column
set clipboard=unnamedplus "yank to clipboard

" numbering
set number

" enable mouse
set mouse=a

" search settings
set hlsearch " highlight search results
set ignorecase " do case insensitive search...
set incsearch " do incremental search
set smartcase " ...unless capital letters are used

" file type specific settings
filetype on " enable file type detection
filetype plugin on " load the plugins for specific file types
filetype indent on " automatically indent code

" syntax highlighting
syntax enable " enable syntax highlighting

" Conque-GDB 
let g:ConqueGdb_Leader = '.'

" python mode
let g:pymode_folding = 1
let g:pymode_run = 0
let g:pymode_run_bind = ''
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_completion_bind = ''

" nerdcommenter
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDAltDelims_java = 1 " Set a language to use its alternate delimiters by default
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } } " Add your own custom formats or override the defaults
let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting

" YouCompleteMe
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_key_list_select_completion = ['<Up>', '<Down>']
let g:ycm_global_ycm_extra_conf = '$HOME.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_key_invoke_completion = '<leader>.'
let g:ycm_use_ultisnips_completer = 1
let g:ycm_seed_identifiers_with_syntax = 1
nnoremap <leader>g :YcmCompleter GoTo<CR>
let g:ycm_goto_buffer_command = 'horizontal-split'
let g:ycm_rust_src_path = '$HOME/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'

" Ultisnip with YCM
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<tab-s>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "/home/niklasad1/Dropbox/configs/UltiSnips"]


" NEERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif " Toggle NEERDTree when only vim entered
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


" Vim Wiki
let wiki = {}
let wiki.path = '~/Dropbox/wiki'
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
let g:vimwiki_list = [wiki]
let g:vimwiki_dir_link = 'index'
let g:vimwiki_hl_headers = 1
let g:vimwiki_hl_cb_checked = 1
let g:vimwiki_folding = ''


" Vim Github Markdown Preview
let vim_markdown_preview_github=1
let vim_markdown_preview_browser='firefox'

" Compile and run by entering -r
nnoremap <leader>r :call CompileRunGcc()<CR>
" Autoformat, tabs etc
nnoremap <leader>a :Autoformat<CR>
" Toggle Folding
nnoremap <leader>f za<CR>
" Copy the entire file
nnoremap <leader>ac ggmqvG"+y'q

func! CompileRunGcc()
  exec "w"
  exec "!clear"
  if &filetype == 'c'
    exec "!gcc -g -Wall -pedantic -std=c99 % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'python'
    exec "!python3 %"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java -cp %:p:h %:t:r"
  elseif &filetype == 'sh'
    exec "!time bash %"
  elseif &filetype == 'html'
    exec "!firefox % &"
  elseif &filetype == 'go'
    exec "!go build %<"
    exec "!time go run %"
  elseif &filetype == 'mkd'
    exec "!~/.vim/markdown.pl % > %.html &"
    exec "!firefox %.html &"
  elseif &filetype == 'erlang'
    exec "!make debug"
    exec "!erl"
  elseif &filetype == 'rust'
    exec "!cargo run"
  endif
endfunc
