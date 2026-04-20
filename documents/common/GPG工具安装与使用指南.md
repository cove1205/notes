# macOS上GPG工具安装与使用指南

## 目录
1. [什么是GPG](#什么是gpg)
2. [安装GPG](#安装gpg)
3. [基本配置](#基本配置)
4. [密钥管理](#密钥管理)
5. [加密与解密](#加密与解密)
6. [数字签名](#数字签名)
7. [常用命令](#常用命令)
8. [故障排除](#故障排除)
9. [最佳实践](#最佳实践)

## 什么是GPG

GPG (GNU Privacy Guard) 是一个开源的加密软件，用于保护数据的机密性和完整性。它基于OpenPGP标准，可以用于：

- 加密和解密文件
- 数字签名验证
- 安全通信
- 软件包验证

## 安装GPG

### 方法一：使用Homebrew（推荐）

```bash
# 安装Homebrew（如果尚未安装）
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 安装GPG
brew install gnupg

# 验证安装
gpg --version
```

### 方法二：使用MacPorts

```bash
# 安装MacPorts后执行
sudo port install gnupg2
```

### 方法三：从官网下载

1. 访问 [GnuPG官网](https://gnupg.org/download/)
2. 下载macOS版本
3. 按照安装向导完成安装

## 基本配置

### 1. 创建配置文件

```bash
# 创建GPG配置目录
mkdir -p ~/.gnupg

# 设置正确的权限
chmod 700 ~/.gnupg

# 创建配置文件
touch ~/.gnupg/gpg.conf
```

### 2. 基本配置选项

编辑 `~/.gnupg/gpg.conf` 文件：

```conf
# 使用UTF-8编码
charset utf-8

# 显示完整的密钥指纹
keyid-format 0xlong

# 显示详细的输出信息
verbose

# 使用默认的密钥服务器
keyserver hkp://keyserver.ubuntu.com

# 自动信任密钥
auto-key-retrieve

# 显示照片ID
show-photos
```

## 密钥管理

### 1. 生成密钥对

```bash
# 生成新的密钥对
gpg --full-generate-key

# 或者使用快速生成（推荐新手）
gpg --quick-generate-key "your-email@example.com"
```

生成过程中需要输入：
- 密钥类型（通常选择RSA）
- 密钥长度（推荐4096位）
- 有效期（建议1-2年）
- 真实姓名和邮箱
- 密码短语

### 2. 查看密钥

```bash
# 列出所有公钥
gpg --list-keys

# 列出所有私钥
gpg --list-secret-keys

# 显示密钥详细信息
gpg --fingerprint your-email@example.com
```

### 3. 导出密钥

```bash
# 导出公钥（ASCII格式）
gpg --armor --export your-email@example.com > public-key.asc

# 导出私钥（ASCII格式，谨慎使用）
gpg --armor --export-secret-keys your-email@example.com > private-key.asc

# 导出私钥（二进制格式）
gpg --export-secret-keys your-email@example.com > private-key.gpg
```

### 4. 导入密钥

```bash
# 导入公钥
gpg --import public-key.asc

# 导入私钥
gpg --import private-key.asc

# 从密钥服务器导入
gpg --recv-keys KEY_ID
```

### 5. 删除密钥

```bash
# 删除公钥
gpg --delete-key your-email@example.com

# 删除私钥
gpg --delete-secret-key your-email@example.com
```

## 加密与解密

### 1. 加密文件

```bash
# 使用收件人的公钥加密文件
gpg --encrypt --recipient recipient@example.com file.txt

# 使用多个收件人加密
gpg --encrypt --recipient user1@example.com --recipient user2@example.com file.txt

# 加密并保留原文件
gpg --encrypt --recipient recipient@example.com --output encrypted-file.gpg file.txt

# 对称加密（使用密码）
gpg --symmetric file.txt
```

### 2. 解密文件

```bash
# 解密文件
gpg --decrypt encrypted-file.gpg

# 解密并保存到新文件
gpg --decrypt --output decrypted-file.txt encrypted-file.gpg

# 解密对称加密的文件
gpg --decrypt --output decrypted-file.txt encrypted-file.gpg
```

## 数字签名

### 1. 创建签名

```bash
# 创建分离式签名
gpg --detach-sign file.txt

# 创建内嵌式签名
gpg --clearsign file.txt

# 创建二进制签名
gpg --sign file.txt

# 签名并加密
gpg --sign --encrypt --recipient recipient@example.com file.txt
```

### 2. 验证签名

```bash
# 验证分离式签名
gpg --verify file.txt.sig file.txt

# 验证内嵌式签名
gpg --verify file.txt.asc

# 验证二进制签名
gpg --verify file.txt.gpg
```

## 常用命令

### 密钥操作

```bash
# 编辑密钥
gpg --edit-key your-email@example.com

# 添加用户ID
gpg --edit-key your-email@example.com
> adduid
> 输入新的姓名和邮箱
> save

# 添加子密钥
gpg --edit-key your-email@example.com
> addkey
> 选择密钥类型和用途
> save

# 撤销密钥
gpg --gen-revoke your-email@example.com > revocation-certificate.asc
```

### 密钥服务器操作

```bash
# 上传公钥到密钥服务器
gpg --send-keys KEY_ID

# 从密钥服务器搜索密钥
gpg --search-keys "search-term"

# 刷新密钥
gpg --refresh-keys
```

### 信任管理

```bash
# 设置密钥信任级别
gpg --edit-key your-email@example.com
> trust
> 选择信任级别（1-5）
> save

# 签名其他用户的密钥
gpg --sign-key other-user@example.com
```

## 故障排除

### 常见问题

1. **权限错误**
   ```bash
   chmod 700 ~/.gnupg
   chmod 600 ~/.gnupg/*
   ```

2. **找不到密钥**
   ```bash
   # 更新密钥数据库
   gpg --refresh-keys
   
   # 从密钥服务器获取
   gpg --recv-keys KEY_ID
   ```

3. **密码短语问题**
   ```bash
   # 更改密码短语
   gpg --edit-key your-email@example.com
   > passwd
   > save
   ```

4. **GPG代理问题**
   ```bash
   # 重启GPG代理
   gpgconf --kill gpg-agent
   gpgconf --launch gpg-agent
   ```

### 日志和调试

```bash
# 启用详细输出
gpg --verbose --encrypt file.txt

# 查看GPG配置
gpg --version --verbose

# 检查GPG代理状态
gpgconf --list-dirs
```

## 最佳实践

### 1. 密钥管理

- 定期备份私钥和撤销证书
- 设置合理的密钥有效期
- 使用强密码短语
- 定期更新密钥

### 2. 安全建议

- 不要在公共计算机上使用私钥
- 定期检查密钥的信任网络
- 使用硬件安全模块（HSM）存储重要密钥
- 及时撤销泄露的密钥

### 3. 文件组织

```bash
# 创建密钥备份目录
mkdir -p ~/gpg-backup

# 备份重要文件
cp ~/.gnupg/private-keys-v1.d/* ~/gpg-backup/
cp ~/.gnupg/pubring.gpg ~/gpg-backup/
cp ~/.gnupg/secring.gpg ~/gpg-backup/
```

### 4. 自动化脚本

创建便捷的加密/解密脚本：

```bash
#!/bin/bash
# encrypt.sh - 快速加密脚本

if [ $# -ne 2 ]; then
    echo "用法: $0 <文件> <收件人邮箱>"
    exit 1
fi

gpg --encrypt --recipient "$2" --armor --output "$1.asc" "$1"
echo "文件已加密为: $1.asc"
```

```bash
#!/bin/bash
# decrypt.sh - 快速解密脚本

if [ $# -ne 1 ]; then
    echo "用法: $0 <加密文件>"
    exit 1
fi

gpg --decrypt --output "${1%.asc}" "$1"
echo "文件已解密为: ${1%.asc}"
```

## 总结

GPG是一个强大的加密工具，正确使用可以大大提高数据安全性。本指南涵盖了GPG在macOS上的安装、配置和基本使用方法。建议在实际使用前先在测试环境中熟悉这些操作，并始终遵循安全最佳实践。

---

**注意**: 请妥善保管您的私钥和密码短语，丢失私钥将无法恢复加密的数据。
