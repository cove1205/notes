# Starship 终端提示符指南

> 轻量、迅速、客制化的高颜值终端！
> 项目地址：https://github.com/starship/starship
> 官网：https://starship.rs

## 特性

- 🚀 **快**：真的非常快
- 🎨 **客制化**：可定制各种各样的提示符
- 🌍 **通用**：适用于任何 Shell、任何操作系统
- 🧠 **智能**：一目了然地显示相关信息
- 📦 **功能丰富**：支持所有你喜欢的工具
- ⚡ **易用**：安装快速，几分钟就可上手

## 安装

### Android

| 软件包来源 | 指令 |
| ------------ | ------ |
| Termux     | `pkg install starship`     |

### BSD

| 发行版     | 软件包来源 | 指令 |
| ------------ | ------------ | ------ |
| 任意发行版 | crates.io  | `cargo install starship --locked`     |
| FreeBSD    | FreshPorts | `pkg install starship`     |
| NetBSD     | pkgsrc     | `pkgin install starship`     |

### Linux

**安装最新版本：**

```bash
curl -sS https://starship.rs/install.sh | sh
```

**其他包管理器：**

| 发行版             | 软件包来源            | 指令 |
| -------------------- | ----------------------- | ------ |
| 任意发行版         | crates.io             | `cargo install starship --locked`     |
| 任意发行版         | conda-forge           | `conda install -c conda-forge starship`     |
| 任意发行版         | Linuxbrew             | `brew install starship`     |
| Alpine Linux 3.13+ | Alpine Linux Packages | `apk add starship`     |
| Arch Linux         | Arch Linux extra      | `pacman -S starship`     |
| CentOS 7+          | Copr                  | `dnf copr enable atim/starship && dnf install starship`     |
| Debian 13+         | Debian Main           | `apt install starship`     |
| Fedora 40+         | Copr                  | `dnf copr enable atim/starship && dnf install starship`     |
| Gentoo             | Gentoo Packages       | `emerge app-shells/starship`     |
| Manjaro            | Arch                  | `pacman -S starship`     |
| NixOS              | nixpkgs               | `nix-env -iA nixpkgs.starship`     |
| openSUSE           | OSS                   | `zypper in starship`     |
| Ubuntu 25.04+      | Ubuntu Universe       | `apt install starship`     |
| Void Linux         | Void Linux Packages   | `xbps-install -S starship`     |

### macOS

**安装最新版本：**

```bash
curl -sS https://starship.rs/install.sh | sh
```

**其他包管理器：**

| 软件包来源  | 指令 |
| ------------- | ------ |
| crates.io   | `cargo install starship --locked`     |
| conda-forge | `conda install -c conda-forge starship`     |
| Homebrew    | `brew install starship`     |
| MacPorts    | `port install starship`     |

### Windows

在 [发布页](https://github.com/starship/starship/releases/latest) 下载 MSI 包安装。

**其他包管理器：**

| 软件包来源  | 指令 |
| ------------- | ------ |
| crates.io   | `cargo install starship --locked`     |
| Chocolatey  | `choco install starship`     |
| conda-forge | `conda install -c conda-forge starship`     |
| Scoop       | `scoop install starship`     |
| winget      | `winget install --id Starship.Starship`     |

## 初始化配置

配置你的终端来初始化 Starship，选择你的终端：

### Bash

在 `~/.bashrc` 的最后，添加以下内容：

```bash
eval "$(starship init bash)"
```

### Cmd

需要使用 [Clink](https://chrisant996.github.io/clink/clink.html) (v1.2.30+)。在路径 `%LocalAppData%\clink\starship.lua` 下创建文件：

```lua
load(io.popen('starship init cmd'):read("*a"))()
```

### Elvish

添加到 `~/.config/elvish/rc.elv`（或 `%AppData%\elvish\rc.elv`）末尾：

```elvish
eval (starship init elvish)
```

> 注意：仅支持 v0.18+ 的 Elvish。v0.21.0 之前版本配置可能在 `~/.elvish/rc.elv`。

### Fish

在 `~/.config/fish/config.fish` 末尾添加：

```fish
starship init fish | source
```

### Ion

在 `~/.config/ion/initrc` 末尾添加：

```bash
eval $(starship init ion)
```

### Nushell

添加到 Nushell 配置文件末尾（运行 `$nu.config-path` 获取路径）：

```nu
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
```

> 注意：仅支持 Nushell v0.96+

### PowerShell

添加到 PowerShell 配置文件末尾（运行 `$PROFILE` 获取路径）：

```powershell
Invoke-Expression (&starship init powershell)
```

### Tcsh

在 `~/.tcshrc` 末尾添加：

```tcsh
eval `starship init tcsh`
```

### Xonsh

在 `~/.xonshrc` 末尾添加：

```python
execx($(starship init xonsh))
```

### Zsh

在 `~/.zshrc` 末尾添加：

```zsh
eval "$(starship init zsh)"
```

打开新的 Shell 实例即可看到提示符。

## 后续配置

- [配置文档](https://starship.rs/config/)：学习如何配置 Starship
- [预设](https://starship.rs/presets/)：从其他构建好的配置中获取灵感

---