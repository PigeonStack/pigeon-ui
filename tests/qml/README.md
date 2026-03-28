# tests/qml/

QML 组件交互测试目录。

用于放置 QML 层面的 smoke test（通过最小 App 场景驱动）。

## 约定

- 测试文件命名：`test_<ComponentName>.py`
- 每个测试启动最小 QQmlApplicationEngine 加载对应 QML 片段
- 验证组件可实例化、不崩溃、基础属性可访问
