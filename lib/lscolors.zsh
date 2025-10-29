#!/usr/bin/env zsh
# Enhanced LS Colors configuration with comprehensive file type support
# and platform-specific optimizations
#
# Online editor: https://geoff.greer.fm/lscolors/
# LS_COLORS Generator: https://github.com/trapd00r/LS_COLORS

_is_gnu_ls() {
    ls --version 2>/dev/null | grep -q "GNU"
}

_supports_truecolor() {
    [[ "${COLORTERM:-}" == "truecolor" ]] || [[ "${COLORTERM:-}" == "24bit" ]]
}

# Enhanced LS_COLORS with comprehensive file type support
# GNU LS_COLORS format - much more comprehensive
export LS_COLORS='
# Base file types
no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:mi=00;05;37;41:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=00;32:

# Archives and compressed files
*.tar=00;31:*.tgz=00;31:*.arc=00;31:*.arj=00;31:*.taz=00;31:*.lha=00;31:*.lz4=00;31:*.lzh=00;31:*.lzma=00;31:*.tlz=00;31:*.txz=00;31:*.tzo=00;31:*.t7z=00;31:*.zip=00;31:*.z=00;31:*.dz=00;31:*.gz=00;31:*.lrz=00;31:*.lz=00;31:*.lzo=00;31:*.xz=00;31:*.zst=00;31:*.tzst=00;31:*.bz2=00;31:*.bz=00;31:*.tbz=00;31:*.tbz2=00;31:*.tz=00;31:*.deb=00;31:*.rpm=00;31:*.jar=00;31:*.war=00;31:*.ear=00;31:*.sar=00;31:*.rar=00;31:*.alz=00;31:*.ace=00;31:*.zoo=00;31:*.cpio=00;31:*.7z=00;31:*.rz=00;31:*.cab=00;31:*.wim=00;31:*.swm=00;31:*.dwm=00;31:*.esd=00;31:

# Image files
*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.webp=01;35:*.avif=01;35:*.ico=01;35:*.psd=01;35:*.ai=01;35:*.eps=01;35:*.cr2=01;35:*.nef=01;35:*.raw=01;35:*.dng=01;35:*.heic=01;35:*.heif=01;35:

# Video files
*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.3gp=01;35:*.3g2=01;35:*.ts=01;35:*.m2ts=01;35:*.mts=01;35:*.f4v=01;35:*.f4p=01;35:*.f4a=01;35:*.f4b=01;35:

# Audio files
*.aac=00;32:*.au=00;32:*.flac=00;32:*.m4a=00;32:*.mid=00;32:*.midi=00;32:*.mka=00;32:*.mp3=00;32:*.mpc=00;32:*.ogg=00;32:*.ra=00;32:*.wav=00;32:*.oga=00;32:*.opus=00;32:*.spx=00;32:*.xspf=00;32:*.wma=00;32:*.m4p=00;32:*.m4r=00;32:*.aiff=00;32:*.aif=00;32:*.aifc=00;32:*.ape=00;32:*.wv=00;32:*.cue=00;32:*.ac3=00;32:*.dts=00;32:*.amr=00;32:*.awb=00;32:

# Document files
*.pdf=00;33:*.ps=00;33:*.txt=00;33:*.patch=00;33:*.diff=00;33:*.log=00;33:*.tex=00;33:*.doc=00;33:*.docx=00;33:*.rtf=00;33:*.odt=00;33:*.ods=00;33:*.odp=00;33:*.odg=00;33:*.ppt=00;33:*.pptx=00;33:*.xls=00;33:*.xlsx=00;33:*.csv=00;33:*.epub=00;33:*.mobi=00;33:*.azw=00;33:*.azw3=00;33:*.djvu=00;33:*.fb2=00;33:*.lit=00;33:*.lrf=00;33:*.pdb=00;33:*.pml=00;33:*.rb=00;33:*.snb=00;33:*.tcr=00;33:*.tk3=00;33:

# Code and configuration files
*.h=00;33:*.hpp=00;33:*.hxx=00;33:*.c=00;33:*.cpp=00;33:*.cxx=00;33:*.cc=00;33:*.objc=00;33:*.swift=00;33:*.go=00;33:*.rs=00;33:*.py=00;33:*.pyw=00;33:*.pyx=00;33:*.pxd=00;33:*.pxi=00;33:*.rb=00;33:*.gemspec=00;33:*.rake=00;33:*.php=00;33:*.pl=00;33:*.pm=00;33:*.t=00;33:*.pod=00;33:*.js=00;33:*.mjs=00;33:*.jsx=00;33:*.ts=00;33:*.tsx=00;33:*.vue=00;33:*.java=00;33:*.class=00;33:*.jar=00;33:*.scala=00;33:*.sc=00;33:*.clj=00;33:*.cljs=00;33:*.cljc=00;33:*.edn=00;33:*.hs=00;33:*.lhs=00;33:*.lua=00;33:*.vim=00;33:*.vimrc=00;33:*.el=00;33:*.elc=00;33:*.scm=00;33:*.ss=00;33:*.rkt=00;33:*.rktl=00;33:*.rktd=00;33:*.scrbl=00;33:*.elm=00;33:*.ml=00;33:*.mli=00;33:*.mll=00;33:*.mly=00;33:*.fs=00;33:*.fsi=00;33:*.fsx=00;33:*.fsscript=00;33:*.nim=00;33:*.nims=00;33:*.nimble=00;33:*.cr=00;33:*.zig=00;33:*.d=00;33:*.dart=00;33:*.kt=00;33:*.kts=00;33:*.groovy=00;33:*.gvy=00;33:*.gy=00;33:*.gsh=00;33:

# Shell and script files
*.sh=01;32:*.bash=01;32:*.zsh=01;32:*.fish=01;32:*.csh=01;32:*.tcsh=01;32:*.ksh=01;32:*.ash=01;32:*.dash=01;32:*.bat=01;32:*.cmd=01;32:*.btm=01;32:*.dll=01;32:*.exe=01;32:*.com=01;32:*.scr=01;32:*.msi=01;32:*.run=01;32:*.deb=01;32:*.rpm=01;32:*.pkg=01;32:*.dmg=01;32:*.app=01;32:

# Configuration files
*.conf=00;34:*.config=00;34:*.cfg=00;34:*.ini=00;34:*.toml=00;34:*.yaml=00;34:*.yml=00;34:*.json=00;34:*.xml=00;34:*.plist=00;34:*.desktop=00;34:*.service=00;34:*.target=00;34:*.mount=00;34:*.timer=00;34:*.socket=00;34:*.slice=00;34:*.scope=00;34:*.automount=00;34:*.swap=00;34:*.path=00;34:*.netdev=00;34:*.network=00;34:*.link=00;34:*.nspawn=00;34:

# Web files
*.html=00;35:*.htm=00;35:*.xhtml=00;35:*.shtml=00;35:*.css=00;35:*.scss=00;35:*.sass=00;35:*.less=00;35:*.styl=00;35:*.js=00;35:*.jsx=00;35:*.ts=00;35:*.tsx=00;35:*.vue=00;35:*.svelte=00;35:*.php=00;35:*.asp=00;35:*.aspx=00;35:*.jsp=00;35:*.erb=00;35:*.haml=00;35:*.slim=00;35:*.mustache=00;35:*.hbs=00;35:*.handlebars=00;35:*.twig=00;35:*.jinja=00;35:*.j2=00;35:

# Data files
*.sql=00;36:*.db=00;36:*.sqlite=00;36:*.sqlite3=00;36:*.dbf=00;36:*.mdb=00;36:*.accdb=00;36:*.frm=00;36:*.myf=00;36:*.myh=00;36:*.myi=00;36:*.myd=00;36:*.csvs=00;36:*.parquet=00;36:*.feather=00;36:*.arrow=00;36:*.orc=00;36:*.avro=00;36:

# Backup and temporary files
*~=00;90:*.bak=00;90:*.backup=00;90:*.old=00;90:*.orig=00;90:*.tmp=00;90:*.temp=00;90:*.swp=00;90:*.swo=00;90:*.autosave=00;90:*.recover=00;90:*.crashdump=00;90:*.stackdump=00;90:*.core=00;90:*.pid=00;90:*.part=00;90:*.incomplete=00;90:*.crdownload=00;90:*.download=00;90:

# Version control
*.git=00;90:*.gitignore=00;90:*.gitmodules=00;90:*.gitattributes=00;90:*.hg=00;90:*.hgignore=00;90:*.svn=00;90:*.bzr=00;90:*.bzrignore=00;90:

# Special files
*README=01;33:*README.md=01;33:*readme=01;33:*readme.md=01;33:*README.txt=01;33:*readme.txt=01;33:*INSTALL=01;33:*COPYING=01;33:*LICENSE=01;33:*AUTHORS=01;33:*CHANGELOG=01;33:*CHANGES=01;33:*NEWS=01;33:*TODO=01;33:*BUGS=01;33:*FAQ=01;33:*THANKS=01;33:*VERSION=01;33:*Makefile=01;33:*makefile=01;33:*Dockerfile=01;33:*dockerfile=01;33:*Vagrantfile=01;33:*Gemfile=01;33:*Rakefile=01;33:*gulpfile.js=01;33:*Gruntfile.js=01;33:*webpack.config.js=01;33:*package.json=01;33:*composer.json=01;33:*Cargo.toml=01;33:*pyproject.toml=01;33:*setup.py=01;33:*requirements.txt=01;33:*Pipfile=01;33:*poetry.lock=01;33:*.lock=01;33:

# Log files with different urgency levels
*.log=00;90:*.err=01;31:*.error=01;31:*.warning=01;33:*.warn=01;33:*.info=00;36:*.debug=00;35:'

    # Remove newlines and extra spaces
export LS_COLORS=$(echo "$LS_COLORS" | tr -d '\n' | sed 's/[[:space:]]*//g')

# Configure zsh completion colors to match ls colors
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Enhanced completion colors for different contexts
zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'

# Directory-specific colors
zstyle ':completion:*:*:cd:*:directory-stack' list-colors '=(#b) #([0-9]#)*( *)==95=38;5;12'

# Process completion colors
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# Host completion colors
zstyle ':completion:*:ssh:*' tag-order hosts users
zstyle ':completion:*:ssh:*:hosts' list-colors '=*=01;34'
zstyle ':completion:*:ssh:*:users' list-colors '=*=01;32'

# Git completion colors
zstyle ':completion:*:git-checkout:*' list-colors '=(#b)(*)=01;32'
zstyle ':completion:*:git-add:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:git-*:*' group-name ''

# Function to test and display colors
show_ls_colors() {
    echo "LS_COLORS Test Display:"
    echo "======================="

    # Create temporary test files if they don't exist
    local test_dir="/tmp/ls_colors_test_$$"
    mkdir -p "$test_dir"
    cd "$test_dir"

    # Create sample files
    touch README.md
    touch script.sh
    touch config.json
    touch image.png
    touch video.mp4
    touch audio.mp3
    touch archive.tar.gz
    touch document.pdf
    touch backup.bak~
    touch temporary.tmp
    mkdir directory
    ln -sf README.md symlink

    echo "File Type Examples:"
    ls -la --color=always

    echo -e "\nColor Categories:"
    echo -e "📁 \033[01;34mDirectories\033[0m"
    echo -e "🔗 \033[00;36mSymlinks\033[0m"
    echo -e "⚙️  \033[01;32mExecutables\033[0m"
    echo -e "📄 \033[00;33mDocuments\033[0m"
    echo -e "🖼️  \033[01;35mImages/Videos\033[0m"
    echo -e "🎵 \033[00;32mAudio\033[0m"
    echo -e "📦 \033[00;31mArchives\033[0m"
    echo -e "🔧 \033[00;34mConfigs\033[0m"
    echo -e "🗑️  \033[00;90mBackups/Temps\033[0m"

    # Cleanup
    cd - > /dev/null
    rm -rf "$test_dir"
}

# Function to export a minimal LS_COLORS for performance
minimal_ls_colors() {
    export LS_COLORS='di=01;34:ln=00;36:ex=00;32:*.tar=00;31:*.gz=00;31:*.zip=00;31:*.jpg=01;35:*.png=01;35:*.mp3=00;32:*.mp4=01;35:*.pdf=00;33:*.txt=00;33'
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    echo "Minimal LS_COLORS loaded for better performance"
}

# Function to reload full colors
full_ls_colors() {
    # Re-source this file to get full colors back
    source "${(%):-%x}"
    echo "Full LS_COLORS restored"
}

# Auto-detect and optimize based on terminal capabilities
if [[ "${TERM_PROGRAM:-}" == "vscode" ]] || [[ -n "${INSIDE_EMACS:-}" ]]; then
    # Use minimal colors in editors for better performance
    minimal_ls_colors
elif [[ "$TERM" == "linux" ]] || [[ "$TERM" == "screen"* ]] && [[ -z "${TMUX:-}" ]]; then
    # Use minimal colors in basic terminals
    minimal_ls_colors
fi

# Export color test function
alias ls-colors-test='show_ls_colors'
alias ls-colors-minimal='minimal_ls_colors'
alias ls-colors-full='full_ls_colors'

# Support for different tools
if command -v dircolors >/dev/null 2>&1; then
    # Use dircolors if available (GNU systems)
    alias ls-colors-reload='eval "$(dircolors -b)"'
fi

# Color support detection
if [[ -t 1 ]] && command -v tput >/dev/null 2>&1; then
    export LS_COLORS_TERM_COLORS=$(tput colors 2>/dev/null || echo 8)
else
    export LS_COLORS_TERM_COLORS=0
fi

# Note: Functions are automatically available in zsh
# No need to explicitly export them
