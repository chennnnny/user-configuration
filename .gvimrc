""------------------------------------------------------------------------------
"" This is the personal .gvimrc file of gvim
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
"" general
""------------------------------------------------------------------------------


""------------------------------------------------------------------------------
"" ui
""------------------------------------------------------------------------------
set background =dark " dark / light  

try
    colorscheme desert     " gvim 配色方案 torte / desert
catch
endtry

set guioptions -=m " Toggle menu
set guioptions -=T " Toggle toolbar
set guioptions -=r " 滚动条
set guioptions -=L " 

winpos 10 10              " 指定窗口出现的位置，坐标原点在屏幕左上角
set lines=40 columns=90   " 指定窗口大小，lines为高度，columns为宽度
set cursorline            " Highlight current line
set guicursor  =a:block-blinkon0
set t_Co       =256

if LINUX()
    set guifont=Andale\ Mono\ Regular\ 12,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
elseif OSX()
    set guifont=Andale\ Mono\ Regular:h12,Consolas\ Regular:h12,Courier\ New\ Regular:h14
elseif WINDOWS()
    set guifont=Microsoft_YaHei_Mono:h12,Consolas:h12,Courier_New:h12
endif


""------------------------------------------------------------------------------
"" map keyboard
""------------------------------------------------------------------------------
"" Alt-Space is System menu
noremap <M-Space> :simalt ~<CR>
inoremap <M-Space> <C-O>:simalt ~<CR>
cnoremap <M-Space> <C-C>:simalt ~<CR>


""------------------------------------------------------------------------------
"" gui gvimrc local
""------------------------------------------------------------------------------
if filereadable(expand("$HOME/.gvimrc.local"))
    source $HOME/.gvimrc.local
endif
