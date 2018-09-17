"=================================
" 显示相关
" ================================
set fileencodings=utf-8,ucs-bom,cp936,big5
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936	" 打开文件格式

set nocompatible  	" 去掉vi一致性模式
syntax on         	" 语法高亮
set novisualbell  	" 去掉闪烁
set go=			" 去掉边框
set showcmd  		" 输入命令显示
set cc=80		" 80字符分割线
set nu			" 显示行号
set cmdheight=1		" 命令行高度
set foldenable		" 允许折叠
set foldmethod=manual	" 手动折叠
set laststatus=1	" 启动显示状态行
set cursorline		" 设置下划线
set autoindent		" 设置自动缩进
set smartindent		" 新行智能自动缩进
set showmatch 		" 高亮显示匹配行号
set hlsearch		" 被搜索字符高亮
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  


"=================================
" 文件配置
"=================================
filetype plugin indent on 			" 开启插件
set ic						" 查询匹配忽略大小写

set scrolloff=4
set ofu=syntaxcomplete#Complete

" Auto add head info 文件头

function HeaderPython()
    call setline(1, "#!/usr/bin/env python")
    call append(1, "# -*- coding: utf-8 -*-")
    normal G
    normal o
endf
autocmd bufnewfile *.py call HeaderPython()

" python set
let python_highlight_all=1
au Filetype python set tabstop=4
au Filetype python set softtabstop=4
au Filetype python set shiftwidth=4
au Filetype python set textwidth=79
au Filetype python set expandtab
au Filetype python set autoindent
au Filetype python set fileformat=unix
autocmd Filetype python set foldmethod=indent
autocmd Filetype python set foldlevel=99


" python debug

func! CompileRunGcc()
        exec "w"
        if &filetype == 'c'
                exec "!g++ % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'cpp'
                exec "!g++ % -o %<"
                exec "!time ./%<"
        elseif &filetype == 'java'
                exec "!javac %"
                exec "!time java %<"
        elseif &filetype == 'sh'
                :!time bash %
        elseif &filetype == 'python'
                exec "!clear"
                exec "!time python3 %"
        elseif &filetype == 'html'
                exec "!firefox % &"
        elseif &filetype == 'go'
                " exec "!go build %<"
                exec "!time go run %"
        elseif &filetype == 'mkd'
                exec "!~/.vim/markdown.pl % > %.html &"
                exec "!firefox %.html &"
        endif
endfunc

"==============================================
"Vundle 设置
"==============================================
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'			" vundle管理插件
" Plugin 'Valloric/YouCompleteMe'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'Yggdroot/indentLine'
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'dyng/ctrlsf.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'vim-syntastic/syntastic'
"Plugin 'suan/vim-instant-markdown'
"Plugin 'rizzatti/dash.vim'

call vundle#end()
filetype plugin indent on 

" 常用命令
" :PluginList		- 列出配置插件
" :PluginInstall	- 安装插件，追加 '!' 
" :PluginUpdate		- 更新插件
" :PluginSearch foo 	- 搜索 foo, 追加 '|' 
" :PluginClean 		- 清除未使用插件
" Plugin nerdtree settings.
map <F1> :NERDTreeToggle<CR>
let NERDTreeChDirMode=1
let NERDTreeShowBookmarks=1
let NERDTreeWinSize=25
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$', '\.git$']

" Plugin tagbar settings.
map <F2> :TagbarToggle<CR> 

" Pluging ctrlp settings.
map <F3> :CtrlP<CR>

" Plugin ctrlsf settings.
map <F4> <Plug>CtrlSF

" Plugin indentLine settings.
let g:indentLine_char = "┆"
let g:indentLine_enabled = 1
let g:autopep8_disable_show_diff=1

"" Plugin airline settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme="luna"

" Plugin YCM settings.
set completeopt=longest,menu
let g:ycm_min_num_of_chars_for_completion=2
let g:ycm_cache_omnifunc=0
let g:ycm_seed_identifiers_with_syntax=1
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 0
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_remove_include_errors = 1

" molokai theme
" colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1

" Plugin vim-bookmarks settings.
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE

" Plugin syntastic settings.
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {'mode': 'passive', 'active_filetypes': [], 'passive_filetypes': []}
" Use pylint to check python files.
let g:syntastic_python_checkers = ['pylint']
map <F5> :SyntasticToggleMode<CR> :SyntasticCheck<CR>

" Ignore warnings about newlines trailing.
let g:syntastic_quiet_messages = { 'regex': ['trailing-newlines', 'invalid-name',
    \'too-many-lines', 'too-many-instance-attributes', 'too-many-public-methods',
    \'too-many-locals', 'too-many-branches'] }

" Switch buffer
nmap <C-b>n :bnext<CR>
nmap <C-b>p :bprev<CR>

