使用步骤:
    0.vim版本要8.0以上，实测vim7.4会有报错，升级8.1后正常,(升级vim搜索源码升级,参考一下备注)
    0.git clone https://github.com/robin2014/vimrc.git && cd vimrc
    1. cp ./.vimrc ~/.vimrc
    2.安装Vundle,git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    3.复制脚本generateCscopeAndCtags.sh到相应目录,修改脚本中相应参数，文件位置，生成tags文件
    4.修改~/.vimrc,修改ctags,cscope相关目录
    5. :PluginInstall     - 安装插件,追加 `!` 用以更新或使用 :PluginUpdate

备注:
    1.Vundle插件使用介绍
        注意:
        插件有三种类型:
            1. Github上vim-scripts仓库的插件
            2. Github上非vim-scripts仓库的插件
            3. 不在Github上的插件
            对于不同的插件，vundle自动管理和下载插件的时候，有不同的地址填写方法，有如下三类：
            1. 在Github上vim-scripts用户下的仓库,只需要写出repos（仓库）名称
            2. 在Github其他用户下的repos, 需要写出”用户名/repos名”
            3. 不在Github上的插件，需要写出git全路径
        2.vim ~/.vimrc
        添加:
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
            Plugin 'tpope/vim-fugitive'
            " 来自 http://vim-scripts.org/vim/scripts.html 的插件
            " Plugin '插件名称' 实际上是 Plugin 'vim-scripts/插件仓库名' 只是此处的用户名可以省略
            Plugin 'L9'
            " 由Git支持但不再github上的插件仓库 Plugin 'git clone 后面的地址'
            Plugin 'git://git.wincent.com/command-t.git'
            " 本地的Git仓库(例如自己的插件) Plugin 'file:///+本地插件仓库绝对路径'
            Plugin 'file:///home/gmarik/path/to/plugin'
            " 插件在仓库的子目录中.
            " 正确指定路径用以设置runtimepath. 以下范例插件在sparkup/vim目录下
            Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
            " 安装L9，如果已经安装过这个插件，可利用以下格式避免命名冲突
            Plugin 'ascenator/L9', {'name': 'newL9'}
            
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
            " 将你自己对非插件片段放在这行之后
        3.安装插件
            根据示例添加插件再安装:
                1.打开vim 再:PlugInstall
                2.vim +PluginInstall +qall
        4.移除不需要的插件
            编辑.vimrc文件移除的你要移除的插件所对应的plugin那一行。
            保存退出当前的vim
            重新打开vim，输入命令BundleClean。
        5.其他常用命令
            更新插件BundleUpdate
            列出所有插件BundleList
            查找插件BundleSearch

    3.源码升级vim
    1.安装相关库
		sudo yum install -y ruby ruby-devel lua lua-devel luajit \
			luajit-devel ctags git python python-devel \
			python3 python3-devel tcl-devel \
			perl perl-devel perl-ExtUtils-ParseXS \
			perl-ExtUtils-XSpp perl-ExtUtils-CBuilder \
			perl-ExtUtils-Embed
		2.Remove vim if you have it already.(可以不删除，安装时./configure  --prefix=/usr/local指定不一样的目录 用户自己的目录)
		sudo yum -y remove vim vim-runtime gvim
		3.clone vim源码，configure
		cd ~
		git clone https://github.com/vim/vim.git
		cd vim
		./configure --with-features=huge \
					--enable-multibyte \
					--enable-rubyinterp=yes \
					--enable-pythoninterp=yes \
					--with-python-config-dir=/usr/lib/python2.7/config \(替换成本机真实的pythonconfig地址，2和3 有哪个填哪个)
					--enable-python3interp=yes \
					--with-python3-config-dir=/usr/lib/python3.5/config \
					--enable-perlinterp=yes \
					--enable-luainterp=yes \
					--enable-gui=gtk2 \
					--enable-cscope \
					--prefix=/usr/local 指定将要安装到的路径(自行创建)
		make VIMRUNTIMEDIR=/usr/local/share/vim/vim80
		example:
		./configure --with-features=huge \
					--enable-multibyte \
					--enable-rubyinterp=yes \
					--enable-pythoninterp=yes \
					--with-python-config-dir=/usr/lib/python2.7/site-packages/config \
					--enable-perlinterp=yes \
					--enable-luainterp=yes \
					--enable-gui=gtk2 \
					--enable-cscope \
					--prefix=/home/zhangyun/usr/local
		configure错误，可能提示 checking for tgetent()... configure: error: NOT FOUND!
				  You need to install a terminal library; for example ncurses   
		安装库:     
		yum  install  ncurses-devel
		编译:
		make VIMRUNTIMEDIR=/usr/local/share/vim/vim80(只对自己生效,安装/home/zhangyun/usr/local)
		4.安装.
		cd ~/vim
		sudo make install
		如果只对自己生效，一下可以省略，添加只对自己生效的bin/到PATH路径
		5.Set vim as your default editor with update-alternatives.(是否可以不设置?,这里vim路径为前面prefix指定的)
		sudo update-alternatives --install /usr/bin/editor editor /usr/local/bin/vim 1
		sudo update-alternatives --set editor /usr/local/bin/vim
		sudo update-alternatives --install /usr/bin/vi vi /usr/local/bin/vim 1
		sudo update-alternatives --set vi /usr/local/bin/vim
		6.也可以不管之前
			关于vim的安装路径
			默认新的vim是安在/usr/bin/local/中的，但是PATH中会首先找到/usr/bin/中旧的vim，所以不介意的话把旧的vim删了也可以，也可以输入下面的命令来使命令行中的vim指令指向 /usr/local/bin/vim 的程序
			alias vim='/usr/local/bin/vim'    

    2.自动补全插件安装使用介绍,(已经包含在安装插件中):https://github.com/jayli/vim-easycomplete

