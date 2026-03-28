# tests/integration/

集成测试目录。

用于 Gallery 启动测试、核心组件渲染测试等端到端场景。

## 约定

- 测试文件命名：`test_<scenario>.py`
- Gallery 启动测试：验证 `examples/run_gallery.py` 可启动且 rootObjects 非空
- 不依赖人工交互，超时自动退出
