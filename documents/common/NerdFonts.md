# Nerd font指南

**Nerd Fonts** 是一个使用大量字体图标来解决程序员在开发过程中缺少合适字体的问题的项目。它可以从流行的字体图标库中将大量外部字体引入待开发的项目中，它支持的字体图标库包括 [Font Awesome ➶](https://github.com/FortAwesome/Font-Awesome), [Devicons ➶](https://vorillaz.github.io/devicons/), [Octicons ➶](https://github.com/primer/octicons), and [others](#glyph-sets).


## 重要提示

- `master` 分支的文件路径 **不稳定！** [验证你的 repository URI references](#unstable-file-paths)
- 除非你想成为[开发贡献者](#contributing)，不然最好**不要**克隆这个 repository。

## 目录

**[TL;DR](#tldr)**

**[安装选项](#font-installation)**

- **[1 - 手动](#选项1-手动下载并安装)**
- **[2 - 下载发布存档](#选项2-下载发布存档)**
- **[3 - 安装脚本](#选项3-安装脚本)**
- **[4 - Homebrew Fonts (macOS (OS X))](#选项4-homebrew-字体)**
- **[5 - 克隆 Repo](#选项5-克隆-repo)**
- **[6 - Ad Hoc Curl 下载](#选项6-ad-hoc-curl-下载)**
- **[8 - Arch Linux Repository (Community, AUR)](#选项7-非官方-arch-community-repository)**
- **[8 - 你自己的字体补丁](#选项8-打包你的个人字体)**

**[特征](#features)**

- **[Glyph/Icon sets](#glyph-sets)**
- **[Patched Fonts](#patched-fonts)**
- **[Combinations](#combinations)**
- **[Font Patcher](#font-patcher)**

**[开发者 / 贡献者](#font-patcher)**

- **[Font Patcher](#font-patcher)**
- **[Gotta Patch 'em All Font Patcher!](#gotta-patch-em-all)**
- **[Other Good Fonts to Patch](#other-good-fonts-to-patch)**
- **[Contributing](#contributing)**

**[项目的目的](#project-motivation)**

**附加信息**

- **[master中不稳定的文件路径](#unstable-file-paths)**
- **[更新日志](#changelog)**
- **[证书](#license)**

## TL;DR

Nerd Fonts 中包含流行的程序字体和字形。
如果你想要的字体没有在现有的字体库中，你可以使用 [font patcher](#font-patcher)来自定义字体。
更多信息请见 [wiki](https://github.com/ryanoasis/nerd-fonts/wiki)。如果你正在寻找Vim插件，请见 [VimDevIcons ➶](https://github.com/ryanoasis/vim-devicons "VimDevIcons Vim Plugin (external link) ➶")。

### 多种字体下载选项

_如果你..._

- `选项 1.` 需要**快速**从[`patched-fonts/`](#patched-fonts) [directory](#patched-fonts)下载一个 **独立字体**
- `选项 2.` 需要去下载包含粗体、斜体等等一系列字体的 **字体家族**，请见 [下载档案](#选项2-下载发布存档)
- `选项 3.` 需要**自动安装**或使用**脚本**，请见 [安装脚本](#选项3-安装脚本)
- `选项 4.` 是**macOS**的使用者，并且想要使用**Homebrew**，请见 [Homebrew Fonts](#选项4-homebrew-字体)
- `选项 5.` 想要 **完全控制**，请见 [克隆这个 repo](#选项5-克隆-repo)
- `选项 6.` 想要使用 **`curl`** **command** 或者使用 **scripts**，请见 [Ad Hoc Curl 下载](#选项6-ad-hoc-curl-下载)
- `选项 7.` 是**Arch Linux**的使用者，并且想要使用**Community packages**，请见 [Arch Community Repositories](#选项7-非官方-arch-community-repository)
- `选项 8.` 想要打包你自定义的字体，请见 [字体补丁](#选项8-打包你的个人字体)

## 特征

- [FontForge Python script](#font-patcher) 可以打包任何字体
  - 包括建立**Monospaced (fixed-pitch, fixed-width)** _或者_ **double-width (non-monospaced)** 字形
  - 更多详情请见 **[Font Patcher](#font-patcher)** 段落
- **`50`** 已经 [打包了字体家族](#patched-fonts)
- Over **`1,571,470`** 独立的 组合/变型 字体 [(更多详情)](#combinations)
- Over **`9,000`** 字形/图标 组合 [(更多详情)](#combinations)
  - 当前的字形集包括： [Powerline with Extra Symbols](https://github.com/ryanoasis/powerline-extra-symbols), [Font Awesome](https://github.com/FortAwesome/Font-Awesome), [Devicons](https://vorillaz.github.io/devicons/), [Octicons](https://github.com/primer/octicons), [Font Logos](https://github.com/Lukas-W/font-linux), [Pomicons](https://github.com/gabrielelana/pomicons)
- 每种字体的**Monospaced (fixed-pitch, fixed-width)** _和_ **double-width (non-monospaced)** 版本
  - 这指的是Nerd Font字形本身，并不一定需要将字体作为一个整体考虑
- 一个 开发者/贡献者提供了 [bash script](#gotta-patch-em-all) 来为所有字体再打包

## 字形集

:mag: :mag: 你现在可以通过[NerdFonts.com](https://nerdfonts.com/cheat-sheet)中的[Cheat Sheet](https://nerdfonts.com/cheat-sheet)对字形进行搜索

### Shell中的Icon 名称

从[bin/scripts/lib/](bin/scripts/lib/)路径中下载 `.sh` 文件, 推荐的文件位置为 `~/.local/share/fonts/` 或者 `~/bin/`.

- `i_all.sh` - 帮助你加载你下载的所有文件
- `i_dev.sh` - Devicons (198 icons, 8 does not have an established name)
- `i_fa.sh` - Font Awesome (675 icons, 111 aliases)
- `i_fae.sh` - Font Awesome Extension (170 icons)
- `i_iec.sh` - IEC Power Symbols (5 icons)
- `i_logos.sh` - Font Logos (20 icons)
- `i_oct.sh` - Octicons (172 icons)
- `i_ple.sh` - Powerline Extra Symbols (37 icons, 2 aliases, 16 does not have an established name)
- `i_pom.sh` - Pomicons (11 icons)
- `i_seti.sh` - Seti-UI + Custom (50 icons, 2 aliases, 5 does not have an established name)

然后 `source` 所需的文件并且输出 `$i_*` variables 去寻找字体：

```sh
source ~/.local/share/fonts/i_oct.sh
echo $i_oct_heart
# Output:
# ♥
```

**NOTE:** You have to use one of the Nerd Fonts to see correct icons for some icon sets (Devicons, Font Awesome Extension, Font Logos), but other sets should work with their standard fonts too.

## 字体补丁

| Font Name                                                      | Font Name and Repository                                               | ver        | \*RFN | Status                                                                                                                                                                                                                                                                                                                                                                                      |
| :------------------------------------------------------------- | :--------------------------------------------------------------------- | :--------- | :---- | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| [3270 Nerd Font](patched-fonts/3270)                           | [3270](https://github.com/rbanffy/3270font)                            | 3.0.1      | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[Agave]\[p-agave]                                             | \[Agave]\[f-agave]                                                     | 37         | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [AnonymicePro Nerd Font](patched-fonts/AnonymousPro)           | [Anonymous Pro](https://www.marksimonson.com/fonts/view/anonymous-pro) | 1.002      | YES   | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[Arimo]\[p-arimo]                                             | \[Arimo]\[f-arimo]                                                     | 1.33       | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Aurulent Sans Mono Nerd Font](patched-fonts/AurulentSansMono) | Stephen G. Hartke                                                      | <br />     | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[BigBlueTerminal]\[p-bigblueterm]                             | VileR                                                                  | <br />     | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Bitstrom Wera Nerd Font](patched-fonts/BitstreamVeraSansMono) | Bitstream Inc                                                          | 1.1        | YES   | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[Blex Mono]\[p-blex]                                          | \[IBM Plex Mono]\[f-ibm-plex]                                          | 2.3        | YES   | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[Caskaydia Cove Nerd Font]\[p-cascadia]                       | \[Cascadia Code]\[f-cascadia]                                          | 2111.01    | YES   | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Code New Roman Nerd Font](patched-fonts/CodeNewRoman)         | Sam Radian                                                             | 2.0        | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[Comic Shanns Mono Nerd Font]\[p-comic]                       | \[Comic Shanns Mono]\[f-comic]                                         | 1.3        | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[Cousine Nerd Font]\[p-cousine]                               | \[Cousine]\[f-cousine]                                                 | 1.211      | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[DaddyTimeMono]\[p-daddytimemono]                             | \[DaddyTimeMono]\[f-daddytimemono]                                     | 1.2.3      | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [DepartureMono Nerd Font](patched-fonts/DepartureMono)         | [Departure Mono](https://github.com/rektdeckard/departure-mono)        | 1.422      | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [DejaVu Sans Mono Nerd Font](patched-fonts/DejaVuSansMono)     | \[DejaVu]\[f-dejavu]                                                   | 2.37       | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Droid Sans Mono Nerd Font](patched-fonts/DroidSansMono)       | Ascender Corp                                                          | 1.00-113   | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Fantasque Sans Nerd Font](patched-fonts/FantasqueSansMono)    | [Fantasque Sans](https://github.com/belluzj/fantasque-sans)            | 1.8.0      | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Fira Code Nerd Font](patched-fonts/FiraCode)                  | [Fira Code](https://github.com/tonsky/FiraCode)                        | 6.2        | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Fira Mono Nerd Font](patched-fonts/FiraMono)                  | [Fira](https://github.com/mozilla/Fira)                                | 3.206      | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[Go Mono Nerd Font]\[p-go-mono]                               | \[Go-Mono]\[f-go-mono]                                                 | 2.010      | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Gohu Nerd Font](patched-fonts/Gohu)                           | \[Gohu TTF]\[f-gohu2],[Gohu](http://font.gohu.org/)                    | 2.0        | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Hack Nerd Font](patched-fonts/Hack)                           | [Hack](https://github.com/chrissimpkins/Hack)                          | 3.003      | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Hasklug Nerd Font](patched-fonts/Hasklig)                     | [Hasklig](https://github.com/i-tu/Hasklig)                             | 1.2        | YES   | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Heavy Data Mono Nerd Font](patched-fonts/HeavyData)           | Vic Fieger                                                             | 1          | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Hurmit Nerd Font](patched-fonts/Hermit)                       | \[Hermit]\[f-hermit]                                                   | 2.0        | YES   | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[iM-Writing]\[p-im-writing]                                   | \[iA-Writer]\[f-ia-writer]                                             | Dec 2018   | YES   | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Inconsolata Nerd Font](patched-fonts/Inconsolata)             | \[Inconsolata]\[f-inconsolata]                                         | 3.000      | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Inconsolata Go Nerd Font](patched-fonts/InconsolataGo)        | \[InconsolataGo]\[f-inconsolatago]                                     | 1.013      | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[Inconsolata LGC Nerd Font]\[p-inconsolata-lgc]               | \[Inconsolata LGC]\[f-inconsolatalgc]                                  | 1.3        | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Iosevka Nerd Font](patched-fonts/Iosevka)                     | [Iosevka](https://github.com/be5invis/Iosevka)                         | 22.1.0     | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[Iosevka Term Nerd Font]\[p-iosevka-term]                     | [Iosevka Term](https://github.com/be5invis/Iosevka)                    | 22.1.0     | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [JetBrains Mono](patched-fonts/JetBrainsMono)                  | [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono)           | 2.304      | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Lekton Nerd Font](patched-fonts/Lekton)                       | \[Lekton]\[f-lekton]                                                   | 34         | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Literation Mono Nerd Font](patched-fonts/LiberationMono)      | [Liberation](https://pagure.io/liberation-fonts)                       | 2.1.5      | YES   | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[Lilex Nerd Font]\[p-lilex]                                   | \[Lilex]\[f-lilex]                                                     | 2.300      | NO    | ![w2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-unknown-sm.png "Windows status is Unknown/Un-tested") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺") |
| [Meslo Nerd Font](patched-fonts/Meslo)                         | \[Meslo]\[f-meslo]                                                     | 1.21       | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Monofur Nerd Font](patched-fonts/Monofur)                     | Tobias B Koehler                                                       | 1.0        | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Monoid Nerd Font](patched-fonts/Monoid)                       | [Monoid](https://github.com/larsenwork/monoid)                         | 0.61       | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Mononoki Nerd Font](patched-fonts/Mononoki)                   | [Mononoki](https://madmalik.github.io/mononoki/)                       | 1.6        | YES   | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [M+ (MPlus) Nerd Font](patched-fonts/MPlus)                    | \[M+ Fonts]\[f-mplus]                                                  | 2023/03    | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[Noto]\[p-noto]                                               | \[Noto]\[f-noto]                                                       | div        | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[OpenDyslexic]\[p-opendyslexic]                               | \[OpenDyslexic]\[f-opendyslexic]                                       | 2.001      | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[Overpass]\[p-overpass]                                       | \[Overpass]\[f-overpass]                                               | 3.0.5      | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [ProFont (Windows tweaked) Nerd Font](patched-fonts/ProFont)   | \[ProFont]\[f-profont]                                                 | 2.3        | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [ProFont (x11) Nerd Font](patched-fonts/ProFont)               | \[ProFont]\[f-profont]                                                 | 2.2        | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [ProggyClean Nerd Font](patched-fonts/ProggyClean)             | Tristan Grimmer                                                        | 2004/04/15 | NO    | Imperfect                                                                                                                                                                                                                                                                                                                                                                                   |
| [Roboto Mono](patched-fonts/RobotoMono)                        | \[Roboto Mono]\[f-roboto]                                              | 3.0        | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Sauce Code Nerd Font](patched-fonts/SourceCodePro)            | [Source](https://github.com/adobe-fonts/source-code-pro)               | 2.038      | YES   | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Shure Tech Mono Nerd Font](patched-fonts/ShareTechMono)       | [Share Tech Mono](https://fonts.google.com/specimen/Share+Tech+Mono)   | 1.003      | YES   | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Space Mono Nerd Font](patched-fonts/SpaceMono)                | [Space Mono](https://fonts.google.com/specimen/Space+Mono)             | 1.001      | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Terminess Nerd Font](patched-fonts/Terminus)                  | [Terminus TTF](http://terminus-font.sourceforge.net)                   | 4.49.2     | YES   | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[Tinos]\[p-tinos]                                             | \[Tinos]\[f-tinos]                                                     | 1.23       | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Ubuntu Nerd Font](patched-fonts/Ubuntu)                       | \[Ubuntu Font]\[f-ubuntu]                                              | 0.83       | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| [Ubuntu Mono Nerd Font](patched-fonts/UbuntuMono)              | \[Ubuntu Font]\[f-ubuntu]                                              | 0.80       | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |
| \[Victor Mono]\[p-victor]                                      | \[Victor Mono]\[f-victor]                                              | 1.5.4      | NO    | ![w](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/windows-pass-sm.png "Windows status is working ☺") ![m2](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/mac-unknown-sm.png "macOS (OSX) status is Unknown/Un-tested") ![l](https://github.com/ryanoasis/nerd-fonts/wiki/screenshots/v1.0.x/linux-pass-sm.png "Linux status is working ☺")             |

<sub>_\*RFN = Reserved Font Name_</sub>

## 字体集

- 超过 **`1,485,000`** 独立的 变化/组合(Power Set)字体包：
  - **`50个`** 字体合集
  - **`719`** 字体家族
  - **`2,876`** ‘完全’的 变化/组合字体
  - **`'1,485,410'`** _有可能的_ 变化/组合字体
  - **`1,488,286`** 总字体数 (2,876 + 1,428,110)
- 每种字体的组合都是任意 [Variations](#variations)的组合

### Variations

- no flags given (defaults to only **Seti-UI + Custom** and **[Devicons](https://vorillaz.github.io/devicons/)**)
- **double** _**(variable/proportional)**_ or **single** _**(fixed/monospaced)**_ width glyphs
- [Font Awesome](https://github.com/FortAwesome/Font-Awesome)
- [Font Awesome Extension](https://github.com/AndreLZGava/font-awesome-extension)
- [GitHub Octicons](https://github.com/primer/octicons)
- [Font Logos](https://github.com/Lukas-W/font-linux)
- [Powerline Extra Symbols](https://github.com/ryanoasis/powerline-extra-symbols)
- [IEC Power Symbols](https://unicodepowersymbol.com/)
- [Pomicons](https://github.com/gabrielelana/pomicons)
- Windows Compatibility

## 字体安装

### `选项1: 手动下载并安装`

> 安装特定 **单独字体** 的**最快**方法。

下载你选中的特定字体 [patched font](#patched-fonts)

### `选项2: 下载发布存档`

> 适用于当你需要**archive**或者完整的**字体家族**(Bold, Italic, etc.)的情况。

你可以以压缩包的形式从[latest release](https://github.com/ryanoasis/nerd-fonts/releases/latest)下载所需的字体

### `选项3: 安装脚本`

> 适用于当你想要 **自动** 安装或者使用 **scripts** 的情况。

_注_: 仅适用于 Linux & macOS (OS X)
_注_: **Requires cloning** the repo as of now

#### 所有字体：

- 安装全部的字体包 (_警告：字体的数量众多，需要下载的文件体积巨大_)

```sh
./install.sh
```

#### 单独字体:

- 安装你所需的单独字体

```sh
./install.sh <FontName>
./install.sh Hack
./install.sh HeavyData
```

### `选项4: Homebrew 字体`

> 适用于 **macOS系统**的**Homebrew**使用者。

所有字体都可以通过 [Homebrew 字体](https://github.com/Homebrew/homebrew-cask) 从 macOS (OS X)平台上找到

```sh
brew install font-hack-nerd-font
```

_On Linux you have to add_ _`--cask`_ _after_ _`install`._

### `选项5: 克隆 Repo`

> 适用于要使用 **完全控制**, **所有** 或者 **多数** 字体的情况，或者为Nerd Fonts的开发 **添一份力**的情况。

基于效率考虑，如果你只想使用有限的几种字体，我们**不推荐**克隆这个 repository。

但是如果你想要克隆这个repo，请确认你\_shallow\_克隆了它：

```sh
git clone --depth 1
```

### `选项6: Ad Hoc Curl 下载`

> 适用于当你想要使用 **`curl`** **command** 或者在 **scripts**中使用它的情况。

#### Linux

```sh
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
```

_注:_ deprecated alternative paths: `~/.fonts`

#### macOS (OS X)

```sh
cd ~/Library/Fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
```

### `选项7: 非官方 Arch Community Repository`

> 适用于 **Arch Linux** 下使用 **Community packages**的情况

Most fonts are available via [Arch Community packages](https://archlinux.org/packages/?sort=&repo=Community&q=-nerd).
Some special packages are [in AUR](https://aur.archlinux.org/packages?K=nerd-fonts-&outdated=off).

### `选项8: 打包你的个人字体`

> 适用于 **patching** 你的 **个人字体** 或者深度 **自定义** 字体补丁。

在你的个人字体中使用 Python 命令行脚本去增加新的字形并生成字体包

请见: [Font Patcher](#font-patcher) 的使用方法

- 这个选项适用于当你 **不想** 使用 [fonts provided](#patched-fonts)的情况
- 你需要复制已经生成好的字体到你系统中正确的字体文件夹中

<h2 align="center" id="font-patcher">
	<img src="images/nerd-fonts-patcher-logo.png" alt="Nerd Fonts Patcher">
</h2>

可以通过[VimDevIcons ➶](https://github.com/ryanoasis/vim-devicons "VimDevIcons Vim Plugin (external link) ➶")打包你选中的字体:

- 需要: Python 3, python-fontforge package (version 20141231 或者更新版本，请见 [安装说明](http://designwithfontforge.com/en-US/Installing_Fontforge.html))
- OSX上的替代安装方法为: `brew install fontforge`
- 使用:

```
./font-patcher PATH_TO_FONT
```

- 替代方案: 使用script flag通过FontForge binary来执行打包:

```
./fontforge -script font-patcher PATH_TO_FONT
```

```
Nerd Fonts Patcher v3.0.2 (4.4.0) (ff 20230101)
usage: font-patcher [-h] [-v] [-s] [-l] [-q] [-c] [--careful] [--removeligs] [--postprocess [POSTPROCESS]] [--configfile [CONFIGFILE]] [--custom [CUSTOM]]
                    [-ext [EXTENSION]] [-out [OUTPUTDIR]] [--glyphdir [GLYPHDIR]] [--makegroups [{-1,0,1,2,3,4,5,6}]] [--variable-width-glyphs]
                    [--has-no-italic] [--progressbars | --no-progressbars] [--debug [{0,1,2,3}]] [--dry] [--xavgcharwidth [XAVGWIDTH]] [--fontawesome]
                    [--fontawesomeextension] [--fontlogos] [--octicons] [--codicons] [--powersymbols] [--pomicons] [--powerline] [--powerlineextra]
                    [--material] [--weather]
                    font

Nerd Fonts Font Patcher: patches a given font with programming and development related glyphs

* Website: https://www.nerdfonts.com
* Version: 3.0.2
* Development Website: https://github.com/ryanoasis/nerd-fonts
* Changelog: https://github.com/ryanoasis/nerd-fonts/blob/-/changelog.md

positional arguments:
  font                  The path to the font to patch (e.g., Inconsolata.otf)

options:
  -h, --help            show this help message and exit
  -v, --version         show program's version number and exit
  -s, --mono            Whether to generate the glyphs as single-width not double-width (default is double-width)
  -l, --adjust-line-height
                        Whether to adjust line heights (attempt to center powerline separators more evenly)
  -q, --quiet, --shutup
                        Do not generate verbose output
  -c, --complete        Add all available Glyphs
  --careful             Do not overwrite existing glyphs if detected
  --removeligs, --removeligatures
                        Removes ligatures specificed in JSON configuration file
  --postprocess [POSTPROCESS]
                        Specify a Script for Post Processing
  --configfile [CONFIGFILE]
                        Specify a file path for JSON configuration file (see sample: src/config.sample.json)
  --custom [CUSTOM]     Specify a custom symbol font, all glyphs will be copied; absolute path suggested
  -ext [EXTENSION], --extension [EXTENSION]
                        Change font file type to create (e.g., ttf, otf)
  -out [OUTPUTDIR], --outputdir [OUTPUTDIR]
                        The directory to output the patched font file to
  --glyphdir [GLYPHDIR]
                        Path to glyphs to be used for patching
  --makegroups [{-1,0,1,2,3,4,5,6}]
                        Use alternative method to name patched fonts (recommended)
  --variable-width-glyphs
                        Do not adjust advance width (no "overhang")
  --has-no-italic       Font family does not have Italic (but Oblique)
  --progressbars        Show percentage completion progress bars per Glyph Set (default)
  --no-progressbars     Don't show percentage completion progress bars per Glyph Set
  --debug [{0,1,2,3}]   Verbose mode (optional: 1=just to file; 2*=just to terminal; 3=display and file)
  --dry                 Do neither patch nor store the font, to check naming
  --xavgcharwidth [XAVGWIDTH]
                        Adjust xAvgCharWidth (optional: concrete value)

Symbol Fonts:
  --fontawesome         Add Font Awesome Glyphs (http://fontawesome.io/)
  --fontawesomeextension
                        Add Font Awesome Extension Glyphs (https://andrelzgava.github.io/font-awesome-extension/)
  --fontlogos, --fontlinux
                        Add Font Logos Glyphs (https://github.com/Lukas-W/font-logos)
  --octicons            Add Octicons Glyphs (https://octicons.github.com)
  --codicons            Add Codicons Glyphs (https://github.com/microsoft/vscode-codicons)
  --powersymbols        Add IEC Power Symbols (https://unicodepowersymbol.com/)
  --pomicons            Add Pomicon Glyphs (https://github.com/gabrielelana/pomicons)
  --powerline           Add Powerline Glyphs
  --powerlineextra      Add Powerline Glyphs (https://github.com/ryanoasis/powerline-extra-symbols)
  --material, --materialdesignicons, --mdi
                        Add Material Design Icons (https://github.com/templarian/MaterialDesign)
  --weather, --weathericons
                        Add Weather Icons (https://github.com/erikflowers/weather-icons)
```

#### 例子

```
./font-patcher Droid\ Sans\ Mono\ for\ Powerline.otf
./font-patcher Droid\ Sans\ Mono\ for\ Powerline.otf -s -q
./font-patcher Droid\ Sans\ Mono\ for\ Powerline.otf --mono --quiet
./font-patcher Droid\ Sans\ Mono\ for\ Powerline.otf -w
./font-patcher Droid\ Sans\ Mono\ for\ Powerline.otf --windows --quiet
./font-patcher Droid\ Sans\ Mono\ for\ Powerline.otf --windows --pomicons --quiet
./font-patcher Inconsolata.otf --fontawesome
./font-patcher Inconsolata.otf --fontawesome --octicons --pomicons
./font-patcher Inconsolata.otf
```

<a name="gotta-patch-em-all"></a>

## Gotta Patch 'em All Font Patcher!

- 针对贡献者和开发者使用
- 在未打包的路径中re-patches **所有** 字体:

```
./gotta-patch-em-all-font-patcher\!.sh
```

- 可以选择限制到特定字体名称模式:

```
./gotta-patch-em-all-font-patcher\!.sh Hermit
```

## 贡献

See [contributing.md](contributing.md)

## 不稳定的文件路径

:warning: 警告: 基于后续的新版本发布，文件路径有可能被改变 (特别是 **major** version bumps)

注意 **release** 分支 _不是_ ~~master分支~~因为路径会因为新版本发布而改变

- 举例:
  - :white_check_mark: Use: <code><https://github.com/ryanoasis/nerd-fonts/blob/><b>0.9.0</b>/patched-fonts/Hermit/Medium/complete/Hurmit%20Medium%20Nerd%20Font%20Complete.otf</code>
  - :x: Instead of: <code><https://github.com/ryanoasis/nerd-fonts/blob/><del>master</del>/patched-fonts/Hermit/Medium/complete/Hurmit%20Medium%20Nerd%20Font%20Complete.otf</code>

## 其他的好字体

- 一个包含更多好字体的列表，可惜的是，因为许可问题我们不能提供或分享它们:
- [Input Mono](http://input.djr.com/download/) (license restriction)
  - Possibly coming with external hosting :)
- [PragmataPro](https://www.fsd.it/shop/fonts/pragmatapro/) (not free)
- [Consolas](https://www.microsoft.com/typography/fonts/family.aspx?FID=300) (proprietary)

## 项目目的

See [Wiki: Project Purpose](https://github.com/ryanoasis/nerd-fonts/wiki/Project-Purpose)

## 更新日志

See [changelog.md](changelog.md)

## 许可

[MIT](LICENSE) © Ryan L McIntyre

<!--
Repo References
-->

<!--
Website References
-->

<!--
Link References
-->

<!--
Font repos
-->

<!--
Patched Font internal links
-->

<!--
Quick Link Images
-->

<!--
Patched Font Statuses
-->
