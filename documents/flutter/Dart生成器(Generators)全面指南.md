# Dart 生成器（Generators）全面指南

## 一、什么是生成器？

生成器是 Dart 中用于惰性生成值序列的特殊函数。与普通函数一次性返回所有值不同，生成器可以按需逐个产生值，这在处理大量数据或无限序列时特别有用。

## 二、生成器的类型

Dart 支持两种生成器：

- **同步生成器** - 返回 `Iterable`
- **异步生成器** - 返回 `Stream`

## 三、核心语法

### 1. 同步生成器

使用 `sync*` 标记，配合 `yield` 关键字：

```dart
// 基础语法
Iterable<int> countUpTo(int n) sync* {
  for (int i = 1; i <= n; i++) {
    yield i;  // 逐个产生值
  }
}

// 使用示例
void main() {
  final numbers = countUpTo(5);
  for (var num in numbers) {
    print(num);  // 输出: 1,2,3,4,5
  }
}
```

### 2. 异步生成器

使用 `async*` 标记，配合 `yield` 关键字：

```dart
// 基础语法
Stream<int> countUpToAsync(int n) async* {
  for (int i = 1; i <= n; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;  // 异步逐个产生值
  }
}

// 使用示例
void main() async {
  await for (var num in countUpToAsync(5)) {
    print(num);  // 每秒输出一个数字: 1,2,3,4,5
  }
}
```

## 四、高级特性

### 1. yield* - 委托生成

`yield*` 可以将生成委托给另一个生成器：

```dart
Iterable<int> naturalsDownFrom(int n) sync* {
  if (n > 0) {
    yield n;  // 产生当前值
    yield* naturalsDownFrom(n - 1);  // 递归产生剩余值
  }
}

// 更实用的例子：扁平化嵌套序列
Iterable<int> flatten(List<List<int>> nested) sync* {
  for (var list in nested) {
    yield* list;  // 委托给列表的迭代器
  }
}

void main() {
  final nested = [[1, 2], [3, 4], [5, 6]];
  print(flatten(nested).toList());  // [1, 2, 3, 4, 5, 6]
}
```

### 2. 递归生成器

生成器可以递归调用自己：

```dart
// 生成斐波那契数列
Iterable<int> fibonacci() sync* {
  yield 0;
  yield 1;

  int a = 0, b = 1;
  while (true) {
    int next = a + b;
    yield next;
    a = b;
    b = next;
  }
}

void main() {
  final fib = fibonacci().take(10);
  print(fib.toList());  // [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
}
```

### 3. 无限序列

生成器天然支持无限序列：

```dart
// 无限自然数序列
Iterable<int> naturalNumbers() sync* {
  int i = 0;
  while (true) {
    yield i++;
  }
}

// 无限随机数流
Stream<int> randomNumbers(int seed) async* {
  var random = seed;
  while (true) {
    random = (random * 1103515245 + 12345) & 0x7fffffff;
    yield random;
    await Future.delayed(Duration(milliseconds: 100));
  }
}
```

## 五、实战应用场景

### 场景1：分页数据处理

```dart
// 模拟API分页获取数据
Stream<List<User>> fetchUsersPageByPage() async* {
  int page = 1;
  bool hasMore = true;

  while (hasMore) {
    final users = await api.getUsers(page: page, limit: 20);
    yield users;  // 每页数据到达时立即返回

    hasMore = users.length == 20;
    page++;

    // 避免请求过快
    await Future.delayed(Duration(milliseconds: 500));
  }
}

// 使用
void processUsers() async {
  await for (var page in fetchUsersPageByPage()) {
    for (var user in page) {
      print('Processing: ${user.name}');
    }
  }
}
```

### 场景2：文件读取与处理

```dart
import 'dart:io';

// 逐行读取大文件
Stream<String> readLargeFileLines(String path) async* {
  final file = File(path);
  final lines = file.openRead();

  await for (var chunk in lines.transform(utf8.decoder)) {
    // 处理数据块
    final lineBuffer = StringBuffer();
    for (var char in chunk.split('')) {
      if (char == '\n') {
        yield lineBuffer.toString();
        lineBuffer.clear();
      } else {
        lineBuffer.write(char);
      }
    }
  }
}

// 使用
void processLargeFile() async {
  await for (var line in readLargeFileLines('large_file.txt')) {
    if (line.contains('ERROR')) {
      print(line);
    }
  }
}
```

### 场景3：事件流处理

```dart
// 鼠标移动事件流
Stream<Point> mouseMoveEvents() async* {
  // 假设有鼠标事件监听器
  while (true) {
    final event = await waitForMouseMove();
    yield Point(event.x, event.y);
  }
}

// 防抖处理
Stream<Point> debounce(Stream<Point> source, Duration duration) async* {
  Point? lastValue;
  Timer? timer;

  await for (var value in source) {
    timer?.cancel();
    timer = Timer(duration, () {
      if (lastValue != null) {
        // 这里需要用 StreamController，简化示例
      }
    });
    lastValue = value;
  }
}
```

## 六、性能优化与最佳实践

### 1. 惰性求值的好处

```dart
// ❌ 不好：立即创建所有数据
List<int> getEvenNumbers(int max) {
  var result = <int>[];
  for (var i = 0; i <= max; i++) {
    if (i % 2 == 0) result.add(i);
  }
  return result;
}

// ✅ 好：惰性生成
Iterable<int> getEvenNumbersLazy(int max) sync* {
  for (var i = 0; i <= max; i++) {
    if (i % 2 == 0) yield i;
  }
}

// 使用
void example() {
  // 只计算前10个偶数，不会计算全部
  final evens = getEvenNumbersLazy(1000000).take(10);
  print(evens.toList());
}
```

### 2. 避免过早转换

```dart
// 保持延迟链
Iterable<int> processNumbers(Iterable<int> source) sync* {
  yield* source
      .where((n) => n > 0)
      .map((n) => n * 2)
      .take(100);
}
```

### 3. 资源管理

```dart
// 使用 finally 确保资源释放
Stream<String> readFileSafely(String path) async* {
  final file = File(path);
  Stream<String>? lines;

  try {
    lines = file.openRead()
        .transform(utf8.decoder)
        .transform(LineSplitter());

    await for (var line in lines) {
      yield line;
    }
  } finally {
    // 确保资源清理
    print('File closed');
  }
}
```

## 七、常见陷阱与注意事项

### 陷阱1：生成器不是普通函数

```dart
// ❌ 错误：不能在生成器中使用 return 返回值
Iterable<int> wrong() sync* {
  return [1, 2, 3];  // 编译错误
}

// ✅ 正确：使用 yield
Iterable<int> correct() sync* {
  yield 1;
  yield 2;
  yield 3;
}
```

### 陷阱2：异步生成器的错误处理

```dart
// ✅ 使用 try-catch 处理错误
Stream<int> safeGenerator() async* {
  try {
    for (int i = 0; i < 10; i++) {
      if (i == 5) throw Exception('Error at 5');
      yield i;
    }
  } catch (e) {
    print('Caught: $e');
    // 可以选择 yield 错误信息或重新抛出
  }
}
```

## 全面的学习计划步骤

### 📅 第1周：基础入门（3-5小时）

**目标**：理解生成器基本概念和语法

| 天数 | 学习内容 | 实践任务 |
|------|----------|----------|
| Day 1 | 理解生成器 vs 普通函数 | 对比写两个函数，一个返回List，一个返回Iterable |
| Day 2 | 同步生成器 sync* 和 yield | 实现 range(start, end) 函数 |
| Day 3 | 异步生成器 async* 和 yield | 实现每秒产生一个数字的计时器 |
| Day 4 | 理解惰性求值概念 | 用 take() 限制生成数量，观察内存使用 |
| Day 5 | 复习与练习 | 完成5个基础练习题 |

**参考资源**：
- Dart官方文档 - Generators
- DartPad在线练习

---

### 📅 第2周：核心特性深入（4-6小时）

**目标**：掌握高级特性和常用模式

| 天数 | 学习内容 | 实践任务 |
|------|----------|----------|
| Day 6 | yield* 委托生成 | 实现扁平化嵌套列表的生成器 |
| Day 7 | 递归生成器 | 实现二叉树遍历生成器 |
| Day 8 | 无限序列 | 创建素数生成器、斐波那契生成器 |
| Day 9 | 错误处理与资源管理 | 实现带错误恢复的文件读取生成器 |
| Day 10 | 组合生成器 | 创建管道式数据处理流 |

**项目练习**：

```dart
// 实现一个文件系统遍历器
Stream<FileSystemEntity> walkDirectory(String path) async* {
  // 递归遍历目录，yield 所有文件和子目录
}
```

---

### 📅 第3周：实战应用（5-8小时）

**目标**：在真实场景中应用生成器

| 天数 | 学习内容 | 实践任务 |
|------|----------|----------|
| Day 11 | 分页API数据获取 | 实现分页加载生成器 |
| Day 12 | 实时数据处理 | 实现WebSocket消息流生成器 |
| Day 13 | 大数据处理 | 实现CSV/JSON大文件流式解析 |
| Day 14 | 状态机实现 | 用生成器实现简单的状态机 |
| Day 15 | 游戏开发应用 | 实现游戏中的粒子系统生成器 |

**项目练习**：

```dart
// 实现一个日志分析器
Stream<LogEntry> parseLogFile(String path) async* {
  // 流式解析日志文件，实时分析异常
}
```

---

### 📅 第4周：高级主题与优化（4-6小时）

**目标**：掌握性能优化和高级模式

| 天数 | 学习内容 | 实践任务 |
|------|----------|----------|
| Day 16 | 性能分析与优化 | 对比生成器 vs 集合的内存占用 |
| Day 17 | 与其他特性结合 | 结合扩展方法创建优雅的API |
| Day 18 | 设计模式实现 | 用生成器实现观察者模式、迭代器模式 |
| Day 19 | 测试生成器 | 编写生成器单元测试 |
| Day 20 | 源码分析 | 阅读Dart SDK中生成器的实现 |

**优化清单**：
- 使用 `takeWhile` 避免无限循环
- 避免在生成器中做过多计算
- 合理使用缓冲区
- 正确处理取消订阅

---

### 📅 第5周：综合项目（8-10小时）

**目标**：完成一个完整的实战项目

#### 项目选项A：构建实时数据管道系统

```dart
// 实现一个ETL数据处理管道
class DataPipeline<T> {
  // 支持数据源、转换、聚合、输出
  Stream<T> fromSource(Stream<T> source);
  DataPipeline<R> map<R>(R Function(T) transform);
  DataPipeline<T> filter(bool Function(T) predicate);
  DataPipeline<List<T>> buffer(int size);
  Future<void> toSink(Sink<T> sink);
}
```

#### 项目选项B：Web爬虫系统

```dart
// 实现一个流式网页爬虫
Stream<WebPage> crawlWebsite(String startUrl) async* {
  // 广度优先遍历，流式输出页面内容
  // 支持并发控制、去重、错误重试
}
```

#### 项目选项C：实时监控系统

```dart
// 实现服务器指标监控
Stream<Metric> monitorSystem() async* {
  // 实时采集CPU、内存、网络等指标
  // 支持告警规则配置
}
```

## 📚 学习资源推荐

**官方资源**：
- Dart Language Tour
- Effective Dart

**书籍**：
- 《Dart Cookbook》- 第4章：Collections and Generators
- 《Flutter in Action》- 相关章节

**视频教程**：
- YouTube: "Dart Generators Explained" (by Tensor Programming)
- DartConf 相关演讲视频

**练习平台**：
- Exercism.io - Dart Track
- LeetCode - Dart

## ✅ 学习检查清单

完成学习后，你应该能够：

**基础知识**：
- [ ] 解释生成器与普通函数的区别
- [ ] 正确使用 `sync*` 和 `async*` 语法
- [ ] 理解 `yield` 和 `yield*` 的区别

**核心能力**：
- [ ] 实现递归生成器
- [ ] 创建无限序列并安全使用
- [ ] 组合多个生成器构建数据处理管道

**高级应用**：
- [ ] 处理异步流和错误
- [ ] 优化生成器性能
- [ ] 在大型项目中合理使用生成器

**实战能力**：
- [ ] 完成至少一个完整的数据处理项目
- [ ] 编写生成器的单元测试
- [ ] 能够为团队讲解生成器的最佳实践

## 🎯 最终目标

**5周后，你将能够：**

- 熟练运用生成器解决实际问题
- 理解Dart异步编程的精髓
- 写出更高效、更优雅的Dart代码
- 在Flutter应用中有效管理状态和数据流

---

> 记住：生成器的核心优势是惰性求值和内存效率。在实际开发中，当你需要处理大量数据或无限序列时，优先考虑使用生成器而不是集合。
