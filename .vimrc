""------------------------------------------------------------------------------
"" This is the personal .vimrc file of gvim or vim
"" Author: chenyao
"" Email:  cheny@meizu.com
""------------------------------------------------------------------------------

"" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif

"" Use Vim settings, rather than Vi settings (much better!).
"  This must be first, because it changes other options as a side effect.
set nocompatible

""------------------------------------------------------------------------------
"" Identify platform and gui
""------------------------------------------------------------------------------
silent function! OSX()
    return has('macunix')
endfunction
silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
    return  (has('win32') || has('win64'))
endfunction
silent function! GUI()
    return has('gui_running')
endfunction

""------------------------------------------------------------------------------
"" runtime path 
""------------------------------------------------------------------------------
if WINDOWS()
    set runtimepath+=$HOME/.vim,$HOME/.vim/after
endif

""------------------------------------------------------------------------------
"" vimrc bundle
""------------------------------------------------------------------------------
if filereadable(expand("$HOME/.vimrc.bundle"))
    source $HOME/.vimrc.bundle
endif

filetype plugin indent on    " required

""------------------------------------------------------------------------------
"" Window gvim environment
""------------------------------------------------------------------------------
if WINDOWS()
    "source $VIMRUNTIME/mswin.vim
    behave mswin "  设置鼠标和选择的行为 mswin / xterm

    set diffexpr=MyDiff()
    function! MyDiff()
        let opt = '-a --binary '
        if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
        if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
        let arg1 = v:fname_in
        if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
        let arg2 = v:fname_new
        if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
        let arg3 = v:fname_out
        if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
        let eq = ''
        if $VIMRUNTIME =~ ' '
            if &sh =~ "\<cmd"
                let cmd = '""' . $VIMRUNTIME . '\diff"'
                let eq = '"'
            else
                let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
            endif
        else
            let cmd = $VIMRUNTIME . '\diff'
        endif
        silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
    endfunction
endif

""------------------------------------------------------------------------------
"" Linux gvim / vim environment
""------------------------------------------------------------------------------
if !WINDOWS()
    set shell=/bin/bash
endif


""------------------------------------------------------------------------------
"" autocmd
""------------------------------------------------------------------------------
" Only do this part when compiled with support for autocommands.
if has("autocmd")
    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif

    augroup END
endif " has("autocmd")


""------------------------------------------------------------------------------
"" User definition
"" 
""------------------------------------------------------------------------------

""------------------------------------------------------------------------------
"" general
""------------------------------------------------------------------------------
set shortmess =atI    " 启动时不显示援助提示
set history   =100    " Sets how many lines of history VIM has to remember
set hlsearch          " Highlight search results 
set incsearch         " Makes search act like search in modern browsers
set nowrapscan        " 禁止搜索到文件两端时重新搜索
set ignorecase        " Ignore case when searching
set smartcase         " When searching try to be smart about cases  
set magic
set lazyredraw        " Don't redraw while executing macros (good performance config)
set nobackup          " Turn off backup
set hidden            " A buffer becomes hidden when it is abandoned
set autoread          " Set to auto read when a file is changed from the outside
set autowrite         " 自动把内容写回文件: 如果文件被修改过

set backspace =indent,eol,start  " Backspace for dummies

"" With a map leader it's possible to do extra key combinations
"   like <leader>w saves the current file
let mapleader =","

"" No annoying sound on errors
set noerrorbells
set visualbell         t_vb=
autocmd GuiEnter * set t_vb=

"" Command-line completion operates in an enhanced mode 
set wildmenu         " 命令行补全以增强模式运行
set wildignore +=*.o,*~,*.pyc,*.obj,*.swp,tags   " Ignore compiled files
set wildignore +=*/release/*,*/debug/*,*/obj/*
set wildignore +=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store/*

set laststatus  =2     " 状态栏和命令行分成两行
set linespace   =0     " No extra spaces between rows
set linebreak          " 整词换行
set showmode           " Display the current mode
set ruler              " show the cursor position all the time
set showcmd            " display incomplete commands

set whichwrap   =b,s,<,>,[,]   " Backspace, space and cursor keys wrap too
set listchars   =tab:>-,trail:-     
set iskeyword  +=-     " 单词连接符


""------------------------------------------------------------------------------
"" Formatting
""------------------------------------------------------------------------------
set wrap               " 自动换行(当一行超过屏幕时)
set tabstop     =4     " 设置Tab的宽度为4
set softtabstop =4     " 在退格键时可以一次删掉4个空格
set shiftwidth  =4     " 设定<<和>>命令移动时的宽度为4
set scrolloff   =3     " 光标移动到buffer的顶部和底部时保持3行距离
set smarttab           " Be smart when using tabs ;)
set expandtab          " Use spaces instead of tabs
"set splitright        " Puts new vsplit windows to the right of the current
"set splitbelow        " Puts new split windows to the bottom of the current
set showmatch          " 括号匹配显示

set autoindent         " 沿用上一行的缩进
set smartindent        " 智能自动缩进
set cindent            " C/C++ 风格缩进

"" 代码折叠设置
set foldenable              " 便能折叠
set foldmethod     =syntax  " 设置语法折叠
set foldcolumn     =0       " 设置折叠区域的宽度
setlocal foldlevel =1       " 设置折叠层数为
set foldlevelstart =99      " 打开文件是默认不折叠代码
"" normal mode 下用 <space> 来开关光标行所在折叠
nnoremap <silent> <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

"" 可识别的文本编码格式
set fileencodings =ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,shift-jis 
set fileencoding  =utf-8    " 新建文件编码
set termencoding  =locale   " 终端显示编码
set fileformats   =unix,dos,mac


""------------------------------------------------------------------------------
"" ui
""------------------------------------------------------------------------------
syntax enable     " 允许使用语法高亮功能
syntax on         " 打开语法高亮

set background=dark    " dark / light  
set t_Co      =256

if !WINDOWS()
    try
        colorscheme desert     " vim 配色方案 torte / desert
    catch
    endtry
endif

if has('mouse')
    set mouse=a        " Automatically enable mouse usage
    set mousehide      " Hide the mouse cursor while typing
endif

if has('statusline')
    set laststatus  =2                   " 状态栏和命令行分成两行
    set statusline  =[%{mode()}]         " mode
    set statusline +=\ %f                " filename
    set statusline +=\ %w%h%m%r          " options
    set statusline +=\ [%{&ff}\|%Y]      " filetype
    set statusline +=\ [%<%{getcwd()}]   " current dir
    set statusline +=%=%-4.(%l%):%-4.(%c%V%) 
    set statusline +=\ %4.(%p%%%)        " 文件内容百分比
endif


""------------------------------------------------------------------------------
"" map keyboard
""------------------------------------------------------------------------------
map Q gq
map ' `

nmap <Leader>q  :q<CR>
nmap <Leader>w  :w<CR>
nmap <Leader>c  :close<CR>
nmap <Leader>cd :lcd %:h<CR>:pwd<CR>

" Disable highlight when <leader><cr> is pressed
map <silent> <Leader><CR> :noh<CR>

" Smart way to move between windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

nnoremap j  gj
nnoremap k  gk

nnoremap gj 5j
nnoremap gk 5k
nnoremap gh 5h
nnoremap gl 5l

inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>

"" change word to uppercase, I love this very much
imap <C-U> <Esc>gUiwea

"" next window. tab == ctrl-i
"nmap <silent> <Enter> :wincmd w<CR>

nmap <F2> :!start "c:\Program Files (x86)\Mozilla Firefox\firefox.exe" %<CR>


""------------------------------------------------------------------------------
"" Function 
"" Author: chenyao
""------------------------------------------------------------------------------
function! VimrcCreateAndLoadDB() 
    if filereadable("tags")
        let l:filedeleted = delete(getcwd() . "/" . "tags") 
        if 0 != l:filedeleted
            echohl WarningMsg | echo "Fail to delete the tags" | echohl None
            return
        endif
    endif
    
    if has('cscope')
        silent! execute "cs kill -1"
    endif

    if filereadable("cscope.out")
        let l:filedeleted = delete(getcwd() . "/" . "cscope.out")
        if 0 != l:filedeleted
            echohl WarningMsg | echo "Fail to delete the cscope.out" | echohl None
            return
        endif
    endif

    if filereadable("tags.files")
        let l:filedeleted = delete(getcwd() . "/"  . "tags.files")
        if 0 != l:filedeleted
            echohl WarningMsg | echo "Fail to delete the tags.files" | echohl None
            return
        endif
    endif

    if LINUX()
        silent! execute "!find $PWD -name '*.h' -o -name '*.c' -o -name '*.cpp' -o -name '*.java' -o -name '*.py' > tags.files"
    else
        silent! execute "!dir *.h *.c *.cpp *.java *.py /s /b /a-d > tags.files"
    endif

    if 1 == executable('ctags')
        silent! execute "!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q -L tags.files"
    endif

    if 1 == executable('cscope') && has("cscope")
        silent! execute "!cscope -b -i tags.files"
        if filereadable("cscope.out")
            silent! execute "cs add cscope.out"
        endif
    endif
    execute "redraw!"
    execute "normal :"
endfunction
nmap <silent> <F12> :call VimrcCreateAndLoadDB()<CR>
imap <silent> <F12> <Esc>:call VimrcCreateAndLoadDB()<CR>

""------------------------------------------------------------------------------
"" plugin
""------------------------------------------------------------------------------
if filereadable(expand("$HOME/.vimrc.plugin"))
    source $HOME/.vimrc.plugin
endif

""------------------------------------------------------------------------------
"" vimrc local
""------------------------------------------------------------------------------
if filereadable(expand("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif
