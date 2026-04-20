# Git Commit 规范

Git Commit 规范是团队协作中非常重要的实践，它能让提交历史清晰、可读，方便代码审查、问题追溯和自动化版本管理。下面为你详细介绍主流的规范。

## 一、主流规范：Conventional Commits（约定式提交）

目前最广泛使用的是 Conventional Commits 规范，它也是 Semantic Versioning（语义化版本）的基础。

### 基本格式

```text
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### 完整示例

```text
feat(auth): 添加微信登录功能

- 集成微信 OAuth2.0 SDK
- 新增微信登录回调接口
- 添加相关配置项

Closes #123
```

## 二、Type 类型（必填）

| Type       | 说明                               | 示例                                 |
| ---------- | ---------------------------------- | ------------------------------------ |
| `feat`     | 新功能                             | `feat: 添加用户注册功能`             |
| `fix`      | 修复 Bug                           | `fix: 修复登录超时未重定向问题`      |
| `docs`     | 文档更新                           | `docs: 更新 API 接口文档`            |
| `style`    | 代码格式调整（不影响功能）         | `style: 统一缩进为2空格`             |
| `refactor` | 代码重构（不新增功能、不修复 Bug） | `refactor: 优化用户认证模块代码结构` |
| `perf`     | 性能优化                           | `perf: 优化图片加载速度`             |
| `test`     | 测试相关                           | `test: 添加用户服务单元测试`         |
| `build`    | 构建系统或依赖变更                 | `build: 升级 Webpack 到 v5`          |
| `ci`       | CI/CD 配置变更                     | `ci: 添加自动化部署流程`             |
| `chore`    | 杂项（不修改业务代码）             | `chore: 更新 .gitignore 文件`        |
| `revert`   | 回滚之前的提交                     | `revert: 回滚 feat(auth) 提交`       |

## 三、Scope（可选）

Scope 用于标识变更的范围，通常用括号括起来，如 `feat(api):`。

常见 Scope 示例：

- 模块名：`feat(auth)`、`fix(payment)`
- 组件名：`style(button)`
- 平台：`feat(iOS)`、`fix(android)`
- 服务：`perf(database)`

## 四、Subject（主题）

Subject 是提交的简短描述，需要遵循：

- 使用祈使句，如"添加"而不是"添加了"
- 不超过 50 个字符
- 首字母小写（中文不要求）
- 结尾不加句号

### 正确示例：

```text
feat: 添加用户头像上传功能
fix: 修复分页组件在移动端显示异常
```

### 错误示例：

```text
feat: 添加了用户头像上传功能。（时态错误，有句号）
```

## 五、Body（正文，可选）

Body 用于详细描述提交内容：

- 说明"为什么"做这个变更
- 说明"如何"实现的
- 多行用换行分隔

### 示例：

```text
fix(login): 修复 token 过期后未自动刷新

由于前端未正确处理 401 状态码，导致 token 过期后用户需要手动刷新页面。
现在添加了 axios 拦截器，自动调用 refresh token 接口。
```

## 六、Footer（脚注，可选）

Footer 通常用于：

- 关联 Issue：`Closes #123` 或 `Fixes #456`
- 标记破坏性变更：`BREAKING CHANGE: 修改了 API 响应格式`

### 示例：

```text
feat(api): 升级用户接口到 v2 版本

将 /api/user 接口从 v1 升级到 v2，响应格式由 XML 改为 JSON。

BREAKING CHANGE: 原有 v1 接口已弃用，请升级到 v2。

Closes #789
```

## 七、破坏性变更标识

如果需要标记破坏性变更，有两种方式：

在 type 后加 `!`：

```text
feat(api)!: 修改用户接口返回格式
```

在 footer 中添加 `BREAKING CHANGE:`：

```text
refactor: 重构配置管理模块

BREAKING CHANGE: 移除了旧的 config.yml 支持，请使用 config.json
```

## 八、工具与自动化

### 1. Commitizen（交互式生成规范提交）

```bash
# 安装
npm install -g commitizen

# 使用
git cz
```

### 2. Commitlint（检查提交信息是否符合规范）

```bash
# 安装
npm install --save-dev @commitlint/{config-conventional,cli}

# 配置
echo "module.exports = {extends: ['@commitlint/config-conventional']}" > commitlint.config.js

# 结合 Husky 在 commit 时自动检查
```

### 3. Semantic Release（根据规范自动版本发布）

基于 Conventional Commits，可以自动：

- 计算版本号（major/minor/patch）
- 生成 CHANGELOG.md
- 发布到 npm/GitHub

## 九、团队实践建议

- **统一规范**：团队内达成一致，推荐 Conventional Commits
- **使用工具**：通过 Commitizen + Commitlint + Husky 强制规范
- **PR 标题规范**：如果使用 PR/MR 工作流，可以让 PR 标题也遵循相同规范，合并时 squash 成一条规范提交
- **中文 vs 英文**：根据团队习惯选择，但建议保持一致
- **提交频率**：小步提交，每次提交只做一件事

## 十、快速参考表

| 场景             | 规范示例                                   |
| ---------------- | ------------------------------------------ |
| 新增登录功能     | `feat: 添加手机号登录功能`                 |
| 修复空指针异常   | `fix: 修复用户详情页空指针异常`            |
| 优化首页加载速度 | `perf: 优化首页图片懒加载`                 |
| 更新 README      | `docs: 更新环境搭建说明`                   |
| 升级依赖版本     | `chore: 升级 lodash 到 4.17.21`            |
| 回滚错误提交     | `revert: 回滚因接口变更导致的登录失败问题` |

---

遵循规范的 Git Commit 不仅让代码历史清晰，还能让团队成员在 `git log` 或 `git blame` 时快速理解每次变更的意图。建议从现在开始，让团队逐步引入这套规范。
