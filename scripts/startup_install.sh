#!/bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
NC='\033[0m'

command_exists() {
    command -v "$1" > /dev/null 2>&1
}

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

detect_os() {
    case "$OSTYPE" in
        darwin*)
            echo "macos"
            ;;
        linux*)
            if [ -f /etc/os-release ]; then
                . /etc/os-release
                case "$ID" in
                    ubuntu|debian|linuxmint)
                        echo "$ID"
                        ;;
                    fedora)
                        echo "fedora"
                        ;;
                    centos|rhel)
                        echo "centos"
                        ;;
                    arch|manjaro)
                        echo "arch"
                        ;;
                    *)
                        echo "linux"
                        ;;
                esac
            else
                echo "linux"
            fi
            ;;
        *)
            echo "unknown"
            ;;
    esac
}

show_banner() {
    clear
    echo -e "${BLUE}======================================"
    echo "  Setup Script"
    echo "  常用工具安装脚本"
    echo -e "======================================${NC}"
    echo ""
}

# 显示安装菜单
show_menu() {
    echo "请选择要安装的工具："
    echo ""
    echo -e "  ${YELLOW}1)${NC} ${CYAN}Homebrew${NC} (https://brew.sh/)"
    echo -e "  ${YELLOW}2)${NC} ${CYAN}Nerd Fonts${NC} (https://nerdfonts.com/)"
    echo -e "  ${YELLOW}3)${NC} ${CYAN}Zsh + Oh-My-Zsh${NC} (https://ohmyz.sh/)"
    echo -e "  ${YELLOW}4)${NC} ${CYAN}Starship${NC} (https://starship.rs/)"
    echo -e "  ${YELLOW}5)${NC} ${CYAN}安装所有${NC}"
    echo -e "  ${YELLOW}9)${NC} ${CYAN}退出${NC}"
    echo ""
}

# 安装Homebrew
install_homebrew() {
    echo -e "${GREEN}正在安装 Homebrew...${NC}"
    echo ""
    
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    local install_status=$?
    
    if [ $install_status -ne 0 ]; then
        echo ""
        echo -e "${RED}========================================"
        echo -e "  Homebrew 安装过程出错"
        echo -e "========================================${NC}"
        echo ""
        echo -e "${YELLOW}请手动安装: https://brew.sh${NC}"
        return 1
    fi
    
    local os_type=$(detect_os)
    if [ "$os_type" = "linux" ]; then
        echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    else
        echo >> ~/.zshrc
        echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> ~/.zshrc
        eval "$(/opt/homebrew/bin/brew shellenv zsh)"
        source ~/.zshrc
    fi
    
    if command -v brew &> /dev/null; then
        echo ""
        echo -e "${GREEN}========================================"
        echo -e "  Homebrew 安装成功!"
        echo -e "========================================${NC}"
        echo ""
        echo -e "${CYAN}Homebrew 环境变量已配置完成!${NC}"
        echo ""
        return 0
    else
        echo ""
        echo -e "${RED}========================================"
        echo -e "  Homebrew 安装失败"
        echo -e "========================================${NC}"
        echo ""
        echo -e "${YELLOW}请手动安装: https://brew.sh${NC}"
        return 1
    fi
}

# 安装Nerd Fonts
install_nerd_font() {
    while true; do
        clear
        echo -e "${BLUE}=== Nerd Font 选择 ===${NC}"
        echo ""
        echo "  1) Meslo"
        echo "  2) Hack"
        echo "  3) FiraCode"
        echo "  4) Source Code Pro"
        echo "  5) 返回主菜单"
        echo ""
        read -p "请选择字体 [1-5]: " font_choice
        
        case $font_choice in
            1) 
                font_name="Meslo"
                ;;
            2) 
                font_name="Hack"
                ;;
            3) 
                font_name="FiraCode"
                ;;
            4) 
                font_name="SourceCodePro"
                ;;
            5)
                return
                ;;
            *)
                echo -e "${RED}无效选项${NC}"
                sleep 1
                continue
                ;;
        esac
        
        echo -e "${GREEN}正在安装 ${font_name} Nerd Font...${NC}"
        
        nerd_font_dir="/tmp/nerd-fonts"
        if [ ! -d "$nerd_font_dir/.git" ]; then
            echo "正在克隆 Nerd Fonts 仓库..."
            rm -rf "$nerd_font_dir"
            git clone --depth 1 https://github.com/ryanoasis/nerd-fonts "$nerd_font_dir"
        fi
        
        cd "$nerd_font_dir"
        ./install.sh "$font_name"
        cd - > /dev/null
        
        echo -e "${GREEN}${font_name} Nerd Font 安装完成!${NC}"
        echo ""
        echo -e "${YELLOW}请在终端设置Nerd字体${NC}"
        read -p "按 Enter 键继续..."
    done
}

# 安装Zsh + Oh-My-Zsh
install_zsh_setup() {
    echo -e "${GREEN}正在安装 Zsh + Oh-My-Zsh...${NC}"
    
    local os_type=$(detect_os)
    log_info "检测到操作系统: $os_type"
    
    # 1. 安装zsh
    install_zsh "$os_type" || {
        log_error "zsh 安装失败，跳过后续安装"
        return 1
    }
    
    # 2. 安装Oh My Zsh
    install_ohmyzsh || {
        log_error "Oh My Zsh 安装失败，跳过后续安装"
        return 1
    }
    
    # 3. 安装zsh插件
    install_zsh_plugins || {
        log_error "zsh 插件安装失败"
        return 1
    }
    
    # 4. 配置.zshrc
    configure_zshrc || {
        log_error ".zshrc 配置失败"
        return 1
    }
    
    # 5. 设置默认shell
    set_zsh_default || {
        log_warning "设置默认shell失败，可手动执行: chsh -s $(which zsh)"
    }
    
    echo ""
    log_success "Zsh + Oh-My-Zsh 安装完成!"
    echo ""
    echo -e "${YELLOW}请重新打开终端或执行以下命令启动zsh:${NC}"
    echo "  zsh"
    echo ""
}

# 安装Starship
install_starship() {
    log_info "开始安装 Starship..."
    
    if command_exists starship; then
        log_warning "Starship 已安装，跳过安装"
        return 0
    fi
    
    if ! command_exists brew; then
        log_error "Starship 强制使用 Homebrew 安装，请先安装 Homebrew"
        log_info "请选择选项 1 安装 Homebrew 后，再来安装 Starship"
        return 1
    fi
    
    log_info "使用 Homebrew 安装 Starship..."
    brew install starship
    
    if command_exists starship; then
        log_success "Starship 安装成功"
        
        log_info "开始配置 Starship..."
        
        mkdir -p "$HOME/.config"
         if starship preset catppuccin-powerline -o ~/.config/starship.toml 2>/dev/null; then
            log_success "Starship 配置文件已生成"
        else
            log_warning "无法自动生成starship配置文件"
        fi
        
        log_info "配置 Starship 初始化..."
        if [ -f "$HOME/.zshrc" ]; then
            if ! grep -q 'starship init zsh' "$HOME/.zshrc"; then
                echo '' >> "$HOME/.zshrc"
                echo '# Starship 提示符' >> "$HOME/.zshrc"
                echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
                source ~/.zshrc
                log_success "已将 starship 初始化命令添加到 ~/.zshrc"
            else
                log_info "Starship 初始化命令已存在于 ~/.zshrc"
            fi
        else
            echo 'eval "$(starship init zsh)"' > "$HOME/.zshrc"
            source ~/.zshrc
            log_success "已添加 starship 初始化命令"
        fi
        
        echo ""
        log_success "Starship 安装完成!"
        echo ""
        return 0
    else
        log_error "Starship 安装失败"
        return 1
    fi
}

# 安装所有工具
install_all() {
    install_homebrew
    install_nerd_font
    install_zsh_setup
    install_starship
}

# 安装zsh（主要针对Linux系统）
install_zsh() {
    local os_type="$1"

    log_info "检查zsh是否已安装..."
    if command_exists zsh; then
        zsh_version=$(zsh --version | head -n1 | cut -d' ' -f2)
        log_success "zsh 已安装，版本: $zsh_version"
        return 0
    fi

    log_warning "zsh 未安装，开始安装..."

    case "$os_type" in
        ubuntu|debian|linuxmint)
            sudo apt update
            sudo apt install -y zsh
            ;;
        fedora|centos|rhel)
            sudo dnf install -y zsh
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm zsh
            ;;
        macos)
            # macOS 应该自带zsh，但如果确实没有，通过Homebrew安装
            if command_exists brew; then
                brew install zsh
            else
                log_error "macOS 系统应该自带zsh，但未找到。请先安装Homebrew或检查系统。"
                return 1
            fi
            ;;
        *)
            log_error "不支持的操作系统: $os_type"
            log_info "请手动安装zsh: https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH"
            return 1
            ;;
    esac

    if command_exists zsh; then
        log_success "zsh 安装成功"
        return 0
    else
        log_error "zsh 安装失败"
        return 1
    fi
}

# 设置zsh为默认shell
set_zsh_default() {
    log_info "检查当前默认shell..."
    current_shell=$(echo $SHELL)

    if [[ "$current_shell" == *"zsh"* ]]; then
        log_success "zsh 已经是默认shell: $current_shell"
        return 0
    fi

    log_warning "当前默认shell是: $current_shell，需要切换到zsh"

    # 从/etc/shells中查找可用的zsh路径
    local zsh_paths=()
    for path in $(grep zsh /etc/shells 2>/dev/null); do
        if [ -x "$path" ]; then
            zsh_paths+=("$path")
        fi
    done

    # 如果/etc/shells中没有，用which查找
    if [ ${#zsh_paths[@]} -eq 0 ]; then
        zsh_path=$(which zsh)
        if [ -z "$zsh_path" ]; then
            log_error "未找到zsh路径"
            return 1
        fi
        zsh_paths=("$zsh_path")
    fi

    zsh_path="${zsh_paths[0]}"
    log_info "使用zsh路径: $zsh_path"

    # 检查zsh是否在/etc/shells中
    if ! grep -q "^$zsh_path$" /etc/shells 2>/dev/null; then
        log_info "将zsh添加到/etc/shells..."
        echo "$zsh_path" | sudo tee -a /etc/shells
    fi

    # 切换默认shell
    log_info "切换默认shell到zsh..."
    log_info "此操作需要输入你的用户密码..."
    if chsh -s "$zsh_path"; then
        log_success "默认shell已切换到zsh"
        log_warning "需要重新登录或重启终端才能使更改生效"
    else
        log_error "切换默认shell失败"
        log_warning "你可以在安装完成后手动执行: chsh -s $zsh_path"
        log_warning "Oh My Zsh 安装已完成，只是默认shell还没切换，不影响使用"
        # 即使chsh失败也不中止安装
        return 0
    fi
}

# 安装Oh My Zsh
install_ohmyzsh() {
    log_info "开始安装Oh My Zsh..."

    # 检查是否已安装Oh My Zsh
    if [ -d "$HOME/.oh-my-zsh" ]; then
        log_error "Oh My Zsh 已经安装！请检查 $HOME/.oh-my-zsh 目录"
        log_error "如果确实需要重新安装，请先备份并删除该目录"
        return 2  # 特殊退出码表示已安装
    fi

    # 安装Oh My Zsh
    if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; then
        log_error "Oh My Zsh 安装失败 - curl命令执行错误"
        return 1
    fi

    if [ -d "$HOME/.oh-my-zsh" ]; then
        log_success "Oh My Zsh 安装成功"
        return 0
    else
        log_error "Oh My Zsh 安装失败 - 安装后目录未创建"
        return 1
    fi
}

# 安装zsh插件
install_zsh_plugins() {
    log_info "开始安装zsh插件..."

    # 定义插件目录
    ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

    # 检查Oh My Zsh目录是否存在
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        log_error "Oh My Zsh目录不存在，无法安装插件"
        return 1
    fi

    # 创建custom目录（如果不存在）
    mkdir -p "$ZSH_CUSTOM/plugins"

    # 安装zsh-autosuggestions
    log_info "安装 zsh-autosuggestions..."
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
        if ! git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"; then
            log_error "zsh-autosuggestions 安装失败 - git命令执行错误"
            return 1
        fi
        log_success "zsh-autosuggestions 安装成功"
    else
        log_info "zsh-autosuggestions 已存在，跳过"
    fi

    # 安装zsh-syntax-highlighting
    log_info "安装 zsh-syntax-highlighting..."
    if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
        if ! git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"; then
            log_error "zsh-syntax-highlighting 安装失败 - git命令执行错误"
            return 1
        fi
        log_success "zsh-syntax-highlighting 安装成功"
    else
        log_info "zsh-syntax-highlighting 已存在，跳过"
    fi

    return 0
}

# 配置.zshrc文件
configure_zshrc() {
    log_info "配置 ~/.zshrc 文件..."

    ZSHRC_FILE="$HOME/.zshrc"

    # 检查文件是否存在或可创建
    if ! touch "$ZSHRC_FILE" 2>/dev/null; then
        log_error "无法创建或修改 $ZSHRC_FILE 文件"
        return 1
    fi

    # 备份原文件
    if [ -f "$ZSHRC_FILE" ]; then
        backup_file="$ZSHRC_FILE.backup.$(date +%Y%m%d_%H%M%S)"
        if ! cp "$ZSHRC_FILE" "$backup_file"; then
            log_error "备份 $ZSHRC_FILE 文件失败"
            return 1
        fi
        log_info "已备份原文件: $backup_file"
    fi

    # 设置主题为agnoster - 兼容macOS (BSD sed) 和 Linux (GNU sed)
    if grep -q '^ZSH_THEME=' "$ZSHRC_FILE" 2>/dev/null; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            if ! sed -i '' "s/^ZSH_THEME=.*/ZSH_THEME=\"agnoster\"/" "$ZSHRC_FILE" 2>/dev/null; then
                log_error "修改 ZSH_THEME 失败"
                return 1
            fi
        else
            if ! sed -i "s/^ZSH_THEME=.*/ZSH_THEME=\"agnoster\"/" "$ZSHRC_FILE" 2>/dev/null; then
                log_error "修改 ZSH_THEME 失败"
                return 1
            fi
        fi
    else
        if ! echo 'ZSH_THEME="agnoster"' >> "$ZSHRC_FILE"; then
            log_error "添加 ZSH_THEME 失败"
            return 1
        fi
    fi

    # 设置插件 - 兼容macOS (BSD sed) 和 Linux (GNU sed)
    if grep -q '^plugins=' "$ZSHRC_FILE" 2>/dev/null; then
        if [[ "$OSTYPE" == "darwin"* ]]; then
            if ! sed -i '' "s/^plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/" "$ZSHRC_FILE" 2>/dev/null; then
                log_error "修改 plugins 失败"
                return 1
            fi
        else
            if ! sed -i "s/^plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/" "$ZSHRC_FILE" 2>/dev/null; then
                log_error "修改 plugins 失败"
                return 1
            fi
        fi
    else
        if ! echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)' >> "$ZSHRC_FILE"; then
            log_error "添加 plugins 失败"
            return 1
        fi
    fi

    # 添加一些有用的配置
    if ! grep -q "ENABLE_CORRECTION" "$ZSHRC_FILE" 2>/dev/null; then
        if ! echo -e "\n# 启用命令自动纠正\nENABLE_CORRECTION=\"true\"" >> "$ZSHRC_FILE"; then
            log_error "添加 ENABLE_CORRECTION 失败"
            return 1
        fi
    fi

    if ! grep -q "COMPLETION_WAITING_DOTS" "$ZSHRC_FILE" 2>/dev/null; then
        if ! echo -e "\n# 在补全时显示等待提示\nCOMPLETION_WAITING_DOTS=\"true\"" >> "$ZSHRC_FILE"; then
            log_error "添加 COMPLETION_WAITING_DOTS 失败"
            return 1
        fi
    fi

    # 清理可能残留的临时文件
    rm -f "${ZSHRC_FILE}*.bak" 2>/dev/null || true

    log_success "~/.zshrc 配置完成"
    return 0
}


main() {
    while true; do
        show_banner
        show_menu
        read -p "请输入选项 [1-5,9]: " choice
        
        case $choice in
            1)
                install_homebrew
                ;;
            2)
                install_nerd_font
                ;;
            3)
                install_zsh_setup
                ;;
            4)
                install_starship
                ;;
            5)
                install_all
                ;;
            9)
                echo -e "${YELLOW}再见!${NC}"
                exit 0
                ;;
            *)
                echo -e "${RED}无效选项，请重新选择${NC}"
                sleep 1
                ;;
        esac
        
        if [ "$choice" != "9" ]; then
            read -p "按 Enter 键继续..."
        fi
    done
}

main
