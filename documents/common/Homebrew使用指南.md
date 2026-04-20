# Homebrew 使用指南


## 安装 Homebrew

### 系统要求
- macOS 10.15 (Catalina) 或更高版本
- 命令行工具 (Command Line Tools)
- 管理员权限

### 安装步骤

1. **安装 Xcode 命令行工具**（如果尚未安装）：
```bash
xcode-select --install
```

2. **安装 Homebrew**：
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. **配置环境变量**（Apple Silicon Mac）：
```bash
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
```

4. **验证安装**：
```bash
brew --version
```

## 基本使用

### 常用命令

#### 软件包管理
```bash
# 搜索软件包
brew search <package_name>

# 安装软件包
brew install <package_name>

# 卸载软件包
brew uninstall <package_name>

# 查看已安装的软件包
brew list

# 查看软件包信息
brew info <package_name>
```

#### 更新和维护
```bash
# 更新 Homebrew 本身
brew update

# 更新所有已安装的软件包
brew upgrade

# 更新特定软件包
brew upgrade <package_name>

# 清理旧版本和缓存
brew cleanup

# 检查系统问题
brew doctor
```

#### 服务管理
```bash
# 启动服务
brew services start <service_name>

# 停止服务
brew services stop <service_name>

# 重启服务
brew services restart <service_name>

# 查看所有服务状态
brew services list
```

## 常用软件包推荐

### 开发工具
```bash
# Git 版本控制
brew install git

# Node.js 和 npm
brew install node

# Python 3
brew install python

# Java 开发环境
brew install openjdk

# Go 语言
brew install go

# Rust 语言
brew install rust

# Docker 容器化
brew install docker

# Visual Studio Code
brew install --cask visual-studio-code
```

### 系统工具
```bash
# 文件压缩工具
brew install unrar
brew install p7zip

# 网络工具
brew install wget
brew install curl
brew install nmap

# 文本编辑器
brew install vim
brew install nano

# 系统监控
brew install htop
brew install tree
```

### 多媒体工具
```bash
# 图像处理
brew install imagemagick
brew install ffmpeg

# 音频工具
brew install sox

# 视频工具
brew install mpv
```

### 数据库
```bash
# MySQL
brew install mysql

# PostgreSQL
brew install postgresql

# Redis
brew install redis

# MongoDB
brew install mongodb-community
```

### 浏览器和通信
```bash
# Google Chrome
brew install --cask google-chrome

# Firefox
brew install --cask firefox

# Slack
brew install --cask slack

# Zoom
brew install --cask zoom
```

## 高级用法

### 使用 Cask 安装 GUI 应用
```bash
# 搜索 GUI 应用
brew search --cask <app_name>

# 安装 GUI 应用
brew install --cask <app_name>

# 卸载 GUI 应用
brew uninstall --cask <app_name>
```

### 创建自定义 Tap
```bash
# 添加第三方 tap
brew tap <user/repo>

# 移除 tap
brew untap <user/repo>

# 查看已添加的 tap
brew tap
```

### 软件包依赖分析
```bash
# 查看软件包依赖
brew deps <package_name>

# 查看依赖此软件包的其他包
brew uses <package_name>

# 查看软件包依赖树
brew deps --tree <package_name>
```

## 故障排除

### 常见问题及解决方案

#### 1. 权限问题
```bash
# 修复权限
sudo chown -R $(whoami) $(brew --prefix)/*
```

#### 2. 网络连接问题
```bash
# 使用国内镜像源（清华大学）
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
```

#### 3. 清理缓存
```bash
# 清理下载缓存
brew cleanup --prune=all

# 清理所有缓存
rm -rf $(brew --cache)
```

#### 4. 重置 Homebrew
```bash
# 完全卸载 Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
```

## 最佳实践

### 1. 定期维护
```bash
# 每周运行一次
brew update && brew upgrade && brew cleanup
```

### 2. 备份已安装软件包列表
```bash
# 导出已安装软件包
brew bundle dump --file=~/Brewfile

# 从 Brewfile 恢复
brew bundle --file=~/Brewfile
```

### 3. 使用 Brewfile 管理项目依赖
创建 `Brewfile` 文件：
```ruby
# Brewfile 示例
tap "homebrew/cask"
brew "git"
brew "node"
brew "python"
cask "visual-studio-code"
cask "google-chrome"
```

### 4. 环境隔离
```bash
# 使用虚拟环境（Python）
brew install pyenv
pyenv install 3.9.0
pyenv global 3.9.0
```

## 相关资源

- **官方网站**：https://brew.sh/
- **GitHub 仓库**：https://github.com/Homebrew/brew
- **文档**：https://docs.brew.sh/
- **社区论坛**：https://github.com/Homebrew/discussions

