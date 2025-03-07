# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

export TERM=xterm-256color
export color_prompt=yes
export force_color_prompt=yes

# 不记录以空格开头的命令和重复的命令
# 将历史命令追加到.bash_history文件，而不是覆盖它
# 内存中保留的命令数
# 磁盘文件中保存的命令数
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# 每次运行命令后检查窗口大小，以便$LINES和$COLUMNS自动调整
# $LINES 和 $COLUMNS 是 Bash Shell 中的环境变量，它们表示终端的行数和列数，即当前终端窗口的大小
shopt -s checkwinsize

#  less 查看压缩文件的内容
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# chroot环境检测  
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# 根据终端类型,决定是否启用彩色的命令行提示符
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# $force_color_prompt 是一个用于强制启用彩色提示符的环境变量
# 检查 /usr/bin/tput 是否存在且可执行。tput 是一个用于设置终端属性的工具
# tput setaf 1,设置前景色为红色（颜色代码 1）。 >&/dev/null 抑制输出
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # 如果上面的条件都符合那么将 color_prompt 设置为 yes，表示启用彩色提示符
    color_prompt=yes
    else
    color_prompt=
    fi  
fi

# 设置 Bash 提示符（PS1）的格式
# ${debian_chroot:+($debian_chroot)} 通常用于显示系统是否处于 chroot 环境中
# \[\033[01;32m\] 把接下来的文本（用户名部分）设置为绿色并加亮
# \033 是转义字符（也叫 ESC 字符），表示后续字符是控制代码
# 01 表示高亮（亮色）。 32 表示绿色（前景色代码 32）
# \u 会被替换为当前用户的用户名
# @用于分隔用户名和主机名
# \h会被替换为当前主机名
# \[\033[00m\] 表示恢复默认颜色,使后续文本恢复为默认的终端颜色
# :用于分隔主机名和当前工作目录
# \[\033[01;34m\]表示将后续文本设置为蓝色并加亮,34 是蓝色的前景色代码
# \w会被替换为当前工作目录的路径
# \[\033[00m\] 表示恢复默认颜色,使后续文本恢复为默认的终端颜色
# \$  显示提示符的最后一部分。
# 如果当前用户是普通用户，$ 会显示；
# 如果当前用户是 root，# 会显示
# 清除 color_prompt 和 force_color_prompt 变量，这样它们就不会在后续的脚本或命令中影响其他设置
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt




# 根据终端类型设置终端标题，把用户名、主机名和当前工作目录显示在终端的标题栏 
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# 为ls, grep, fgrep, egrep 等命令启用颜色高亮显示，以便在终端中更清晰地区分文件类型、匹配结果等
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# 起别名ll = ls -alF   la = ls -A  l = ls -CF
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# 加载 Bash 命令的自动补全功能，按Tab 键时，Bash 可以智能地补全命令、文件名和选项
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Ctrl + 左箭头 光标移到当前行的开头
# Ctrl + 右箭头 光标移至行尾
bind '"\e[1;5D": beginning-of-line'
bind '"\e[1;5C": end-of-line'
