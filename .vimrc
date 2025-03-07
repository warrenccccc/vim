"常用设置"
"禁用Vi,启用Vim的增强功能"
"启动语法高亮"
"显示行号"
"光标位置,编辑器窗口的右下角显示光标的位置（行号和列号）"
"insert模式下F2进入粘贴模式，再按F2退出粘贴模式"
"设置折叠方式,za切换折叠状态，zo打开光标所在处的折叠,zR打开当前文件中的所有折叠"
"历史记录"
"禁止生成交换文件（.swp/.swo）
"禁止生成备份文件（file~）
set nocompatible
syntax on
set number
set ruler
set pastetoggle=<F2>
set foldmethod=manual
set history=1000
set noswapfile
set nobackup

"高亮搜索,配合/和？搜索"
"启用增量搜索,实时更新并显示匹配的第一个结果，而不必等到整个搜索模式输入完成"
set hlsearch
set incsearch


"在新行自动应用前一行的缩进"
"设置自动缩进的字符数为4个空格
"Tab键占用的字符数"
"智能缩进，根据代码结构比如{}自动调整缩进"
set autoindent
set shiftwidth=4
set tabstop=4
set smartindent


"vim映射，首先定义leader键为,"
"insert模式下,w等同于 ESC + :w + enter"
"normal模式下,w等同于 ESC + :w + enter"
"将 Ctrl + k 绑定为向上翻页
"将 Ctrl + j 绑定为向下翻页
"将 Ctrl + 左箭头 绑定为移动到光标行末尾
"将 Ctrl + 右箭头 绑定为移动到光标行开头
let mapleader=','
noremap <leader>w <ESC>:w<cr>
inoremap <leader>w <Esc>:w<cr>
nnoremap <C-k> <C-u>
nnoremap <C-j> <C-f>
nnoremap <C-Right> $
nnoremap <C-Left> 0


"符号自动补全"
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap < <><Esc>i
inoremap ' ''<Esc>i
inoremap " ""<Esc>i
inoremap { <Esc>o{<CR>}<Esc>O

"自定义一个命令FormatJSON，用于格式化JSON数据",如何使用？:FormatJson
com! FormatJSON %!python3 -m json.tool

"无法直接保存一个只读文件（例如用 vim /etc/hosts 编辑系统文件时）
"输入 :w!!，这条命令会：
"使用 sudo 权限 调用 tee 命令将文件内容写入原文件。
"tee 通过 > 覆盖写入文件（等价于 echo "内容" > 文件名）。
">/dev/null 避免将文件内容输出到屏幕。
cnoremap w!! w !sudo tee % >/dev/null


call plug#begin('~/.vim/plugged')
"美化插件
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'

"文件目录
Plug 'preservim/nerdtree'

"代码目录
Plug 'majutsushi/tagbar'


"文件名搜索和代码搜索
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

"搜索关键字
Plug 'easymotion/vim-easymotion'

"代码成对增加、删除、修改
Plug 'tpope/vim-surround'

"批量替换
Plug 'brooth/far.vim'

"自动补全"
"使用coc的发布分支"
"从源代码构建"
Plug 'neoclide/coc.nvim', {'branch': 'release'}                                                                                               
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}      

"代码格式化"
Plug 'sbdchd/neoformat'

"静态检查"
Plug 'dense-analysis/ale'

"快速注释"
Plug 'tpope/vim-commentary'

"vim和git"
Plug 'tpope/vim-fugitive'


"结束插件管理器"
call plug#end()





"启用 Dracula 颜色主题
set termguicolors
colorscheme dracula
"————————————————————————————————————————————————————————————————————————————————————"
"状态栏"
"如果当前文件被修改（未保存）状态栏会显示提示+符号"
"取消空白检测
"取消当前光标在文件中的百分比
"自定义右下角状态栏 百分比 行号
let g:airline_detect_modified=1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#percent#enabled = 0
let g:airline_section_z = '%p%% %l/%L'
"————————————————————————————————————————————————————————————————————————————————————"
"文件目录"
"Vim启动打开 NERDTree，显示当前文件在目录树中的位置，保持光标在编辑窗口
"当NERDTree 是最后一个窗口时退出 Vim
"当NERDTree 是当前 tab 中的唯一窗口时，关闭该标签页
"显示每个文件的行数
",c 打开或关闭目录树
",v 找到搜索文件在整个目录树的位置
autocmd VimEnter * NERDTree | execute "NERDTreeFind" | wincmd p 
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
let g:NERDTreeFileLines = 1
nnoremap <leader>c :NERDTreeToggle<cr>
nnoremap <leader>v :NERDTreeFind<cr>
"————————————————————————————————————————————————————————————————————————————————————"
"tagbar设置
",t浏览代码目录等同于:TagbarToggle 回车
nnoremap <leader>t :TagbarToggle<CR>
"————————————————————————————————————————————————————————————————————————————————————"
"文件内搜索代码 ss"
nmap ss <Plug>(easymotion-s2)
"————————————————————————————————————————————————————————————————————————————————————"
"tagbar设置"
"当NERDTreeTagBar autocmd(vim编辑窗口)同时存在时，如果此时在autocmd退出，先关闭NERDTree 再关闭Tagbar 最后关闭autocmd,否则会报错"
" 退出前自动执行 SafeQuit() 确保 NERDTree -> Tagbar -> autocmd 顺序退出
autocmd QuitPre * call s:SafeQuit()

function! s:SafeQuit()
    let num_windows = winnr('$')  " 获取当前窗口数
    let nerdtree_winnr = bufwinnr('NERD_tree_*')
    let tagbar_winnr = bufwinnr('Tagbar')

    " 仅当窗口数 ≥ 3 且同时存在 NERDTree 和 Tagbar 时，才执行顺序关闭
    if num_windows >= 3 && nerdtree_winnr != -1 && tagbar_winnr != -1
        " 先关闭 NERDTree
        if exists(':NERDTreeClose')
            silent! NERDTreeClose
        endif

        " 等待 NERDTree 关闭后，再关闭 Tagbar
        call timer_start(50, {-> s:CloseTagbar()})
    endif
endfunction

function! s:CloseTagbar()
    let nerdtree_winnr = bufwinnr('NERD_tree_*')

    " 确保 NERDTree 已关闭
    if nerdtree_winnr != -1
        " 如果 NERDTree 仍然存在，继续等待 50ms 后检查
        call timer_start(50, {-> s:CloseTagbar()})
        return
    endif

    " 关闭 Tagbar
    if exists(':TagbarClose')
        silent! TagbarClose
    endif

    " 等待 Tagbar 关闭后，再退出 Vim
    call timer_start(50, {-> s:QuitAutocmd()})
endfunction

function! s:QuitAutocmd()
    let tagbar_winnr = bufwinnr('Tagbar')

    " 确保 Tagbar 已关闭
    if tagbar_winnr != -1
        " 如果 Tagbar 仍然存在，继续等待 50ms 后检查
        call timer_start(50, {-> s:QuitAutocmd()})
        return
    endif

    " 现在可以安全退出 Vim
    quit
endfunction
"————————————————————————————————————————————————————————————————————————————————————"
"自动补全设置"
"避免干扰普通的回车行为"
"TAB选择下一个补全项,Shift + Tab选择上一个补全项"
"补全响应更快"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
set updatetime=300


"Neovim  <C-Space> 来手动触发补全"
"vim Ctrl + @ 来手动触发补全"
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"gd	跳转到变量、函数、类的定义（Go to Definition）
"gy	跳转到变量或函数的类型定义（Go to Type Definition）
"gi	跳转到接口或类的实现（Go to Implementation）
"gr	查找所有引用（Find All References）
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

"K（大写）用于显示文档，类似于 VSCode 的「悬停显示信息」"
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

"当光标停留在某个符号上时，自动高亮该符号及其所有引用，类似于 IDE 的「变量高亮」功能"
autocmd CursorHold * silent call CocActionAsync('highlight')

" 在 Vim/Neovim 的状态栏显示 CoC.nvim 状态
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"将 Vim/Neovim 的字符编码设置为 UTF-8"
set encoding=utf-8
"禁用 Vim 自动创建 .bak 备份文件"
"在写入文件时，不创建 .swp 或 .tmp 备份文件"
set nobackup
set nowritebackup
"始终显示 signcolumn（标志列），避免诊断信息（如错误、警告）出现或消失时导致文本左右移动"
set signcolumn=yes





