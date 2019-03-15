" https://segmentfault.com/a/1190000002662054 参考网址
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

if exists('$ITERM_PROFILE')
  if exists('$TMUX')
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
end

"********************************************************
"                   一般性配置                          *
"********************************************************
"关闭vim一致性原则
set nocompatible
"显示行号
set number
"设置在编辑过程中右下角显示光标的行列信息
set ruler
"在状态栏显示正在输入的命令
set showcmd
"设置历史记录条数
set history=1000
"设置取消备份 禁止临时文件的生成
set nobackup
set noswapfile
"设置匹配模式
set showmatch
"设置C/C++方式自动对齐
set autoindent
set cindent
"开启语法高亮功能
syntax enable
syntax on
"指定配色方案为256色
set t_Co=256
"设置搜索时忽略大小写
set ignorecase
"配置backspace的工作方式
set backspace=indent,eol,start
"选中高亮
set hls 
"高亮光标所在行
"set cul "cursorline 
"set cuc
"set go=             " 不要图形按钮  
"color desert     " 设置背景主题  
color ron     " 设置背景主题  
"color torte     " 设置背景主题  
set guifont=Courier_New:h10:cANSI   " 设置字体  
"autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
"autocmd InsertEnter * se cul    " 用浅色高亮当前行  
"set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)  
" 光标移动到buffer的顶部和底部时保持3行距离  
set scrolloff=3
" 总是显示状态行
set cmdheight=1
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)  
set foldenable      " 允许折叠  
"set foldmethod=manual   " 手动折叠  
"set magic                   " 设置魔术
"set guioptions-=T           " 隐藏工具栏
"set guioptions-=m           " 隐藏菜单栏
let g:indentLine_char = '┊'
"启动时不显示帮助乌干达儿童提示
set shortmess=atI 
"设置在vim中可以使用鼠标
set mouse=v
"设置tab宽度
set tabstop=4
"设置自动对齐空格数
set shiftwidth=4
"设置退格键时可以删除4个空格
set smarttab
set softtabstop=4
"将tab键自动转换为空格
set expandtab
"设置编码方式
set encoding=utf-8
"自动判断编码时 依次尝试以下编码
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
"检测文件类型
filetype on
"针对不同的文件采取不同的缩进方式
filetype indent on
"允许插件
filetype plugin on
"简化+寄存器操作
set clipboard=unnamedplus
"启动智能补全
filetype plugin indent on
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"VUNDLE CONFIG　BEGIN----------------------------------------------------------------------
set nocompatible              " 去除VI一致性,必须要添加
filetype off                  " 必须要添加

" 设置包括vundle和初始化相关的runtime path
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" 另一种选择, 指定一个vundle安装插件的路径
"call vundle#begin('~/some/path/here')

" 让vundle管理插件版本,必须
Plugin 'VundleVim/Vundle.vim'
" 以下范例用来支持不同格式的插件安装.
" 请将安装插件的命令放在vundle#begin和vundle#end之间.
" Github上的插件
" 格式为 Plugin '用户名/插件仓库名'
"Plugin 'tpope/vim-fugitive'
" 来自 http://vim-scripts.org/vim/scripts.html 的插件
" Plugin '插件名称' 实际上是 Plugin 'vim-scripts/插件仓库名' 只是此处的用户名可以省略
"Plugin 'L9'
" 由Git支持但不再github上的插件仓库 Plugin 'git clone 后面的地址'
"Plugin 'git://git.wincent.com/command-t.git'
" 本地的Git仓库(例如自己的插件) Plugin 'file:///+本地插件仓库绝对路径'
"Plugin 'file:///home/gmarik/path/to/plugin'
" 插件在仓库的子目录中.
" 正确指定路径用以设置runtimepath. 以下范例插件在sparkup/vim目录下
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" 安装L9，如果已经安装过这个插件，可利用以下格式避免命名冲突
"Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'scrooloose/nerdcommenter' "多行注释，leader键+cc生成, leader+cu删除注释
Plugin 'scrooloose/nerdtree'  "文件浏览
Plugin 'Xuyuanp/nerdtree-git-plugin' "待配置
Plugin 'vim-scripts/taglist.vim'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
"SnipMate 携带的四个插件
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
"EasyComplete 插件和 Dictionary 词表
Plugin 'jayli/vim-easycomplete'
Plugin 'jayli/vim-dictionary'

" 待研究安装
"Bundle 'SuperTab'
"Bundle 'Vim-JavaScript'
"Bundle 'a.vim'
"Bundle 'c.vim'
"Bundle 'Align'
"Bundle 'L9'
"Bundle 'vim-javacompleteex'
"Bundle 'tpope/vim-fugitive'
"Bundle 'Lokaltog/vim-easymotion'
"Bundle 'Yggdroot/indentLine'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'ctags.vim'
"Bundle 'The-NERD-tree'
"Bundle 'Syntastic'
"Bundle 'std_c.zip'
"Bundle 'FuzzyFinder'
"Bundle 'tpope/vim-commentary'
"Bundle 'tpope/vim-surround'
"Bundle 'Lokaltog/vim-powerline'
"Bundle 'Valloric/MatchTagAlways'
" 你的所有插件需要在下面这行之前
call vundle#end()            " 必须

filetype plugin indent on    " 必须 加载vim自带和插件相应的语法和文件类型相关脚本
" 忽视插件改变缩进,可以使用以下替代:
"filetype plugin on
"
" 常用的命令
" :PluginList       - 列出所有已配置的插件
" :PluginInstall     - 安装插件,追加 `!` 用以更新或使用 :PluginUpdate
" :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
" :PluginClean      - 清除未使用插件,需要确认; 追加 `!` 自动批准移除未使用插件
"
" 查阅 :h vundle 获取更多细节和wiki以及FAQ
" 将你自己对非插件片段放在这行之后:
"VUNDLE CONFIG　END----------------------------------------------------------------------

"*****************************************************
""                   easycomplete配置                      *
"*****************************************************
imap <S-j>   <Plug>EasyCompTabTrigger
imap <S-k> <Plug>EasyCompShiftTabTrigger
let g:pmenu_scheme = 'dark'

"*****************************************************
""                   taglist配置                      *
"*****************************************************
 let Tlist_Ctags_Cmd = '/usr/bin/ctags'
""不显示"press F1 to display help"
let Tlist_Compact_Format=1
"窗口在左侧显示
let Tlist_Use_Right_Window=1
""只显示当前文件的tags
let Tlist_Show_One_File=1  
"高亮显示
let Tlist_Auto_Highlight_tag=1
""随文件自动更新
let Tlist_Auto_Update=1
"设置宽度
let Tlist_WinWidth=50       
""taglist窗口是最后一个窗口，则退出vim
let Tlist_Exit_OnlyWindow=1 
"单击跳转
"let Tlist_Use_SingClick=1
""打开关闭快捷键
nnoremap <silent> <F3> :TlistToggle<CR>"

"*****************************************************
""                 ctags,cscope 
"*****************************************************
set tags=tags
set tags+=/home/robin/csctags/tags
set autochdir

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("/home/robin/csctags/cscope.out")
      cs add /home/robin/csctags/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif
nmap <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>f :cs find f <C-R>=expand("<cword>")<CR><CR>
nmap <C-@>i :cs find i ^<C-R>=expand("<cword>")<CR>$<CR>
nmap <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"********************************************************
"                      NERD_Tree 配置                   *
"********************************************************
"显示增强
let NERDChristmasTree=1
"自动调整焦点
let NERDTreeAutoCenter=1
"鼠标模式:目录单击,文件双击
let NERDTreeMouseMode=2
"打开文件后自动关闭
let NERDTreeQuitOnOpen=0
"显示文件
let NERDTreeShowFiles=1
"显示隐藏文件
let NERDTreeShowHidden=0
"高亮显示当前文件或目录
let NERDTreeHightCursorline=1
"显示行号
let NERDTreeShowLineNumbers=1
"窗口位置
let NERDTreeWinPos='left'
"窗口宽度
let NERDTreeWinSize=31
"不显示'Bookmarks' label 'Press ? for help'
let NERDTreeMinimalUI=1
"快捷键
nnoremap <silent> <F2> :NERDTreeToggle<CR>
"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
"只剩 NERDTree时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" 设置当文件被改动时自动载入
" set autoread


"********************************************************
"                      NERD_Tree git 配置                   *
"********************************************************
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

"" 跳转?
""*****************************************************
""           YouCompleteMe配置                        *
""*****************************************************
""重启 :YcmRestartServer
"" 自动选择补全Tab键,set paste后tab键盘失效
"set pastetoggle=<F5> 
"set completeopt=longest,menu    "让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
"let mapleader = ","  "leader映射为逗号“，”
"let g:ycm_server_python_interpreter='/usr/bin/python'
"let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py' "配置默认的ycm_extra_conf.py
"let g:ycm_seed_identifiers_with_syntax=1    " 语法关键字补全
"let g:ycm_complete_in_comments = 1  "在注释输入中也能补全
"let g:ycm_complete_in_strings = 1   "在字符串输入中也能补全
"let g:ycm_use_ultisnips_completer = 1 "提示UltiSnips
"let g:ycm_collect_identifiers_from_comments_and_strings = 1   "注释和字符串中的文字也会被收入补全
"let g:ycm_collect_identifiers_from_tag_files = 1 "使用ctags生成的tags文件
"let g:ycm_confirm_extra_conf=0  " 打开vim时不再询问是否加载ycm_extra_conf.py配置
"let g:ycm_key_invoke_completion='<C-a>' " ctrl + a 触发补全
"let g:ycm_goto_buffer_command = 'horizontal-split' " 跳转到定义处, 分屏打开
"let g:ycm_min_num_of_chars_for_completion = 1
"let g:ycm_autoclose_preview_window_after_completion=1
"nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
""nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>
"nnoremap <leader>gd :YcmCompleter GoToDefinition<CR>
"" nnoremap <silent> gb :YcmCompleter GoToDefinitionElseDeclaration<CR>   "按gb 会跳转到定义
"map <F4> : YcmDiags<CR>
"
""*****************************************************
""           Syntastic配置                            *
""*****************************************************
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_cpp_include_dirs = ['/usr/include/','/usr/local/include/','/usr/local/mfw/include','/usr/local/mfw/3party-include/','/usr/include/sys', '/home/robin/Server/build/GameServer/SdpData']
"let g:syntastic_cpp_remove_include_errors = 1
"let g:syntastic_cpp_check_header = 1
""let g:syntastic_cpp_compiler = 'clang++'
""let g:syntastic_cpp_compiler_options = '-std=c++11 -stdlib=libstdc++'
""set error or warning signs
"let g:syntastic_error_symbol = '✗'
"let g:syntastic_warning_symbol = '⚠'
""whether to show balloons
"let g:syntastic_enable_balloons = 1
"
""*****************************************************
""           Ultisnips配置                            *
""*****************************************************
"let g:UltiSnipsExpandTrigger="<c-j>"
"let g:UltiSnipsJumpForwardTrigger="<c-f>"
"let g:UltiSnipsJumpBackwardTrigger="<c-b>"
""let g:UltiSnipsListSnippets="<c-e>"
"" let g:UltiSnipsEditSplit="vertical" " If you want :UltiSnipsEdit to split your window.
