# scripts/

发布与工程辅助脚本目录。

## 脚本列表

| 脚本 | 用途 |
|------|------|
| `check_version.py` | 检查 pyproject.toml 版本号与 CHANGELOG 是否一致 |
| `check_qmldir.py` | 验证 qmldir 声明与实际 .qml 文件是否匹配 |
| `check_assets.py` | 检查 wheel 打包是否包含必需资源 |
| `check_qmllint.py` | 执行 QML 静态检查（qmllint），CI 集成 |
| `pre_release_check.py` | 发布前自动化检查（版本一致性 + qmldir + 资源 + qmllint） |
