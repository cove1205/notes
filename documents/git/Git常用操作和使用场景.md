# Git 常用操作和使用场景

## 基础配置

### 用户信息配置
```bash
# 设置用户名和邮箱
git config --global user.name "你的姓名"
git config --global user.email "你的邮箱@example.com"

# 查看配置信息
git config --list
```

### 常用配置
```bash
# 设置默认编辑器
git config --global core.editor "vim"

# 设置换行符处理（Windows推荐）
git config --global core.autocrlf true

# 设置换行符处理（Mac/Linux推荐）
git config --global core.autocrlf input
```

### GPG签名配置

#### 生成GPG密钥
```bash
# 生成新的GPG密钥
gpg --full-generate-key

# 选择密钥类型（推荐选择RSA and RSA）
# 选择密钥大小（推荐4096位）
# 设置过期时间（推荐1-2年）
# 输入姓名和邮箱（与Git配置保持一致）
# 设置密码短语
```

#### 查看和管理GPG密钥
```bash
# 列出所有GPG密钥
gpg --list-secret-keys --keyid-format LONG

# 查看公钥
gpg --armor --export <密钥ID>

# 删除密钥（谨慎操作）
gpg --delete-secret-keys <密钥ID>
gpg --delete-keys <密钥ID>
```

#### 配置Git使用GPG签名
```bash
# 设置GPG密钥ID（替换为你的实际密钥ID）
git config --global user.signingkey <密钥ID>

# 启用提交签名
git config --global commit.gpgsign true

# 启用标签签名
git config --global tag.gpgsign true

# 设置GPG程序路径（如果需要）
git config --global gpg.program gpg
```

#### 使用GPG签名
```bash
# 创建带签名的提交
git commit -S -m "带GPG签名的提交"

# 创建带签名的标签
git tag -s <标签名> -m "带GPG签名的标签"

# 验证签名
git log --show-signature
git tag -v <标签名>
```

#### 导出和导入GPG密钥
```bash
# 导出公钥（用于添加到GitHub/GitLab）
gpg --armor --export <密钥ID>

# 导出私钥（备份用）
gpg --armor --export-secret-keys <密钥ID> > private-key.asc

# 导入私钥
gpg --import private-key.asc

# 信任导入的密钥
gpg --edit-key <密钥ID>
# 在GPG命令行中输入：trust
# 选择信任级别（通常选择5）
# 输入：quit
```

#### 在GitHub/GitLab中配置GPG
1. 复制公钥内容：
   ```bash
   gpg --armor --export <密钥ID>
   ```

2. 在GitHub中：
   - 进入 Settings → SSH and GPG keys
   - 点击 "New GPG key"
   - 粘贴公钥内容并保存

3. 在GitLab中：
   - 进入 Preferences → GPG Keys
   - 粘贴公钥内容并保存

#### 验证GPG签名
```bash
# 查看提交的签名状态
git log --show-signature --oneline

# 验证特定提交的签名
git show --show-signature <提交哈希>

# 查看标签的签名
git tag -v <标签名>
```

#### 常见问题解决
```bash
# 如果遇到"gpg: signing failed: No secret key"错误
# 1. 检查密钥ID是否正确
git config --global user.signingkey

# 2. 检查GPG密钥是否存在
gpg --list-secret-keys

# 3. 重启GPG代理
gpg-connect-agent reloadagent /bye

# 如果遇到"gpg: signing failed: Inappropriate ioctl for device"错误
export GPG_TTY=$(tty)

# 永久设置（添加到~/.bashrc或~/.zshrc）
echo 'export GPG_TTY=$(tty)' >> ~/.bashrc
```

## 仓库操作

### 创建和克隆仓库
```bash
# 初始化本地仓库
git init

# 克隆远程仓库
git clone <仓库URL>
git clone https://github.com/username/repository.git

# 克隆指定分支
git clone -b <分支名> <仓库URL>
```

### 查看仓库状态
```bash
# 查看工作区状态
git status

# 查看提交历史
git log
git log --oneline  # 简洁显示
git log --graph    # 图形化显示分支

# 查看文件差异
git diff           # 工作区与暂存区差异
git diff --cached  # 暂存区与最新提交差异
git diff HEAD      # 工作区与最新提交差异
```

## 文件操作

### 添加和提交
```bash
# 添加文件到暂存区
git add <文件名>
git add .          # 添加所有文件
git add *.js       # 添加所有js文件

# 提交更改
git commit -m "提交信息"
git commit -am "提交信息"  # 跳过暂存区直接提交

# 修改最后一次提交
git commit --amend -m "新的提交信息"
```

### 撤销操作
```bash
# 撤销工作区修改
git checkout -- <文件名>
git restore <文件名>  # Git 2.23+新命令

# 撤销暂存区文件
git reset HEAD <文件名>
git restore --staged <文件名>  # Git 2.23+新命令

# 撤销最后一次提交（保留修改）
git reset --soft HEAD~1

# 撤销最后一次提交（不保留修改）
git reset --hard HEAD~1
```

## 分支操作

### 分支管理
```bash
# 查看分支
git branch         # 查看本地分支
git branch -r      # 查看远程分支
git branch -a      # 查看所有分支

# 创建和切换分支
git branch <分支名>
git checkout <分支名>
git checkout -b <分支名>  # 创建并切换分支

# 删除分支
git branch -d <分支名>    # 删除已合并分支
git branch -D <分支名>    # 强制删除分支
```

### 分支合并
```bash
# 合并分支
git merge <分支名>

# 变基合并（保持线性历史）
git rebase <分支名>

# 解决冲突后继续变基
git rebase --continue
git rebase --abort  # 取消变基
```

## 远程操作

### 远程仓库管理
```bash
# 查看远程仓库
git remote -v

# 添加远程仓库
git remote add origin <仓库URL>

# 删除远程仓库
git remote remove origin

# 重命名远程仓库
git remote rename old-name new-name
```

### 推送和拉取
```bash
# 推送到远程仓库
git push origin <分支名>
git push -u origin <分支名>  # 设置上游分支

# 拉取远程更新
git pull origin <分支名>
git fetch origin           # 只获取不合并

# 强制推送（谨慎使用）
git push --force origin <分支名>
```

## 标签操作

### 标签管理
```bash
# 创建标签
git tag <标签名>
git tag -a <标签名> -m "标签说明"  # 创建带说明的标签

# 查看标签
git tag
git show <标签名>

# 推送标签
git push origin <标签名>
git push origin --tags  # 推送所有标签

# 删除标签
git tag -d <标签名>
git push origin :refs/tags/<标签名>  # 删除远程标签
```

## 常用使用场景

### 1. 日常开发流程
```bash
# 1. 拉取最新代码
git pull origin main

# 2. 创建功能分支
git checkout -b feature/new-feature

# 3. 开发并提交
git add .
git commit -m "添加新功能"

# 4. 推送分支
git push -u origin feature/new-feature

# 5. 创建Pull Request（在GitHub/GitLab上）
```

### 2. 代码回滚
```bash
# 回滚到指定提交
git reset --hard <提交哈希>

# 回滚单个文件
git checkout <提交哈希> -- <文件名>

# 创建回滚提交
git revert <提交哈希>
```

### 3. 暂存工作
```bash
# 暂存当前工作
git stash
git stash save "暂存说明"

# 查看暂存列表
git stash list

# 恢复暂存
git stash pop        # 恢复并删除
git stash apply      # 恢复但保留

# 删除暂存
git stash drop stash@{0}
```

### 4. 查找和定位
```bash
# 查找提交
git log --grep="关键词"
git log --author="作者名"

# 查找文件修改历史
git log --follow <文件名>

# 查找引入bug的提交
git bisect start
git bisect bad    # 标记当前版本有问题
git bisect good <好的提交哈希>
```

### 5. 清理和维护
```bash
# 清理未跟踪文件
git clean -f      # 删除未跟踪文件
git clean -fd     # 删除未跟踪文件和目录

# 压缩提交历史
git rebase -i HEAD~3

# 查看仓库大小
git count-objects -vH
```

### 6. GPG签名工作流
```bash
# 1. 首次设置GPG签名
git config --global user.signingkey <你的GPG密钥ID>
git config --global commit.gpgsign true

# 2. 创建带签名的提交
git add .
git commit -S -m "feat: 添加新功能"

# 3. 创建带签名的标签
git tag -s v1.0.0 -m "发布版本1.0.0"

# 4. 推送带签名的提交和标签
git push origin main
git push origin v1.0.0

# 5. 验证签名
git log --show-signature --oneline
git tag -v v1.0.0
```

## 最佳实践

### 提交信息规范
```
<类型>(<范围>): <描述>

[可选的正文]

[可选的脚注]
```

类型包括：
- `feat`: 新功能
- `fix`: 修复bug
- `docs`: 文档更新
- `style`: 代码格式调整
- `refactor`: 重构
- `test`: 测试相关
- `chore`: 构建过程或辅助工具的变动

### 分支命名规范
- `feature/功能名称`: 功能开发分支
- `bugfix/问题描述`: 问题修复分支
- `hotfix/紧急修复`: 紧急修复分支
- `release/版本号`: 发布分支

### 工作流建议
1. **主分支保护**: 主分支（main/master）应该受到保护，只能通过Pull Request合并
2. **功能分支**: 每个功能都应该创建独立的分支
3. **及时提交**: 完成一个小功能就提交一次
4. **清晰描述**: 提交信息要清晰描述做了什么
5. **定期同步**: 经常从主分支拉取最新代码
6. **GPG签名**: 重要项目建议启用GPG签名来验证提交的真实性

## 常见问题解决

### 1. 合并冲突
```bash
# 查看冲突文件
git status

# 手动解决冲突后
git add <解决冲突的文件>
git commit -m "解决合并冲突"
```

### 2. 误删文件恢复
```bash
# 恢复被删除的文件
git checkout HEAD -- <文件名>
```

### 3. 修改最后一次提交
```bash
# 修改提交信息
git commit --amend -m "新的提交信息"

# 添加文件到上次提交
git add <文件名>
git commit --amend --no-edit
```

### 4. 撤销远程提交
```bash
# 创建反向提交
git revert <提交哈希>
git push origin main
```

### 5. GPG签名问题
```bash
# 如果提交时提示需要输入密码
# 1. 确保GPG代理正在运行
gpg-connect-agent reloadagent /bye

# 2. 设置GPG_TTY环境变量
export GPG_TTY=$(tty)

# 3. 如果仍然有问题，可以临时禁用签名
git commit --no-gpg-sign -m "临时提交"

# 4. 检查GPG密钥状态
gpg --list-secret-keys --keyid-format LONG
```

这些是Git的常用操作和典型使用场景，掌握这些命令可以应对大部分日常开发需求。
