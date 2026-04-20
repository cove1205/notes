# Flutter 组件库发布到 pub.dev 完整流程

## 前置准备

### 1. 环境要求

- Flutter SDK: >=3.0.0
- Dart SDK: >=3.0.0
- 已注册 [pub.dev](https://pub.dev) 账号

### 2. 项目结构规范

```
your_package_name/
├── lib/
│   ├── src/              # 私有实现目录
│   │   └── your_widget.dart
│   └── your_package_name.dart  # 导出入口文件
├── test/                 # 测试目录
├── example/              # 示例项目
├── CHANGELOG.md          # 变更日志
├── README.md             # 项目说明
├── LICENSE               # 开源协议
└── pubspec.yaml          # 包配置文件
```

## 配置 pubspec.yaml

```yaml
name: your_package_name
description: A short description of your package
version: 1.0.0
homepage: https://github.com/your_username/your_package_name
repository: https://github.com/your_username/your_package_name
issue_tracker: https://github.com/your_username/your_package_name/issues

environment:
  sdk: ">=3.0.0 <4.0.0"
  flutter: ">=3.0.0"

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0

flutter:
  plugin:
    platforms:
      android:
        package: your.package.name
        pluginClass: YourPackageNamePlugin
```

\*\*关键配置说明:

- `name`: 包名，必须在 pub.dev 上唯一，使用小写字母加下划线
- `version`: 使用语义化版本号 (major.minor.patch)
- `description`: 简短描述，不超过150个字符
- `homepage`/`repository`/`issue_tracker`: 链接必填

## 准备必要文件

### 1. README.md

````markdown
# package_name

![Build Status](https://img.shields.io/pub/v/your_package_name.svg)

A new Flutter package project.

## Getting started

Add this to your package's pubspec.yaml file:

```yaml
dependencies:
  your_package_name: ^1.0.0
```
````

## Usage

```dart
import 'package:your_package_name/your_package_name.dart';

// Example code...
```

````

### 2. CHANGELOG.md
```markdown
## 1.0.0

* Initial release.
````

### 3. LICENSE

选择开源协议，推荐使用 MIT:

```text
MIT License

Copyright (c) [year] [fullname]

Permission is hereby granted...
```

## 验证配置

### 1. 检查依赖

```bash
flutter pub get
```

### 2. 运行代码检查

```bash
flutter analyze
```

### 3. 运行测试

```bash
flutter test
```

### 4. 检查包是否可以发布

```bash
flutter pub publish --dry-run
```

该命令会检查所有问题并输出结果，不会实际发布。

## 登录 pub.dev

### 1. 获取认证令牌

如果使用官方 pub.dev:

```bash
dart pub login
```

执行后会打开浏览器，登录后授权获取令牌，复制令牌到终端。

如果使用国内镜像 pub.flutter-io.cn 需要手动添加令牌:

```bash
flutter pub token add https://pub.flutter-io.cn
```

按提示粘贴从网站获取的令牌即可。

### 2. 确认登录状态

```bash
dart pub login
```

## 发布包

```bash
flutter pub publish
```

或者:

```bash
dart pub publish
```

\*\*流程说明:

1. 命令会再次检查所有验证
2. 显示将要发布的文件列表
3. 需要输入 `y` 确认发布
4. 等待上传完成后，包就会出现在 pub.dev 上

## 发布注意事项

1. **首次发布**
   - 发布后需要几分钟才能被搜索到
   - 需要在 pub.dev 控制面板查看分析结果

2. **版本更新**
   - 修改 `pubspec.yaml` 中的 version
   - 更新 `CHANGELOG.md`
   - 重新执行 `flutter pub publish` 即可

3. **私有发布**
   如果你不想公开发布，可以发布到私有仓库:

```bash
flutter pub publish --server=https://your-private-server.com
```

4. **撤回发布**
   只能撤回相同版本，不支持修改已发布版本:

```bash
dart pub unset --package your_package_name --version 1.0.0
```

## 常见问题

### Q: 发布时提示名称已被占用

A: 更换包名，pub.dev 不允许重名

### Q: 发布失败，提示有错误

A: 仔细阅读错误信息，运行 `flutter pub publish --dry-run` 检查

### Q: 如何更新已发布的包？

A: 修改版本号，更新 CHANGELOG，重新发布即可

### Q: 哪些文件会被发布？

A: pub.dev 会遵循 .gitignore 和 .pubignore 规则，默认不发布测试、示例等不会被包含

### Q: 提示需要添加 credentials，提示 `You can provide credentials using: flutter pub token add https://pub.flutter-io.cn`

A: 这是因为配置了国内镜像，直接上传到pub.dev即可:

```bash
flutter pub publish --server=https://pub.dartlang.org
```

## 发布后

1. 在 [pub.dev](https://pub.dev/packages) 搜索你的包，确认发布成功
2. 添加徽章到 README.md: `![Pub Version](https://img.shields.io/pub/v/your_package_name)`
3. 在 GitHub 项目中添加使用说明
4. 分享给社区
