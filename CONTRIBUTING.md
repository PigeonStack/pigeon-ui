# 贡献指南

感谢你对 PigeonUI 的关注！以下是参与贡献的流程和规范。

---

## 开发环境

### 前置条件

- Python >= 3.11
- PySide6 >= 6.7
- Git

### 本地搭建

```bash
git clone https://github.com/aspect-ui/pigeon-ui.git
cd pigeon-ui
python -m venv .venv
.venv\Scripts\Activate.ps1   # Windows PowerShell
pip install -e ".[dev]"
pre-commit install
```

### 运行示例

```bash
python examples/run_gallery.py
```

---

## 分支策略

| 分支 | 用途 |
|------|------|
| `main` | 稳定发布分支 |
| `dev` | 开发主干，日常合并目标 |
| `feat/<name>` | 新功能分支 |
| `fix/<name>` | Bug 修复分支 |

- 从 `dev` 创建功能/修复分支，完成后提 PR 到 `dev`。
- 发布时由维护者将 `dev` 合并到 `main` 并打 tag。

---

## 版本与发布规范

本项目遵循 [Semantic Versioning 2.0.0](https://semver.org/lang/zh-CN/)：

- **MAJOR**：不兼容的 API 变更。
- **MINOR**：向下兼容的新功能。
- **PATCH**：向下兼容的 Bug 修复。

### Tag 规范

- 格式：`v<MAJOR>.<MINOR>.<PATCH>`，例如 `v0.2.0`。
- Tag 创建在 `main` 分支上，必须与 `pyproject.toml` 中的版本号一致。

### 发布流程

1. 在 `dev` 分支完成所有变更，更新 `pyproject.toml` 版本号和 `CHANGELOG.md`。
2. 提 PR 从 `dev` 到 `main`，通过 CI 后合并。
3. 在 `main` 上打 tag：`git tag v0.2.0 && git push origin v0.2.0`。
4. GitHub Actions `release.yml` 自动执行：lint → test → build → 发布到 PyPI。

---

## 提交规范

采用 [Conventional Commits](https://www.conventionalcommits.org/) 格式：

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

### 常用 type

| type | 说明 |
|------|------|
| `feat` | 新功能 |
| `fix` | Bug 修复 |
| `docs` | 文档变更 |
| `style` | 格式调整（不影响功能） |
| `refactor` | 重构（不新增功能、不修复 bug） |
| `test` | 测试相关 |
| `chore` | 构建/工具/依赖变更 |

### scope 示例

`PButton`、`PTheme`、`gallery`、`ci`、`docs`

---

## PR 检查表

提交 PR 前请确认：

- [ ] 代码通过 `make lint`（或 `just lint`）。
- [ ] 新增/修改的公开组件已在 `qmldir` 注册。
- [ ] 新组件在 `examples/Gallery.qml` 中有示例演示。
- [ ] 涉及 API 变更已更新文档和 `CHANGELOG.md`。
- [ ] 已在本地运行 Gallery 验证无崩溃。
- [ ] 提交信息符合 Conventional Commits 规范。

---

## 组件开发规范

- 所有视觉参数通过 `PTheme` 引用，禁止硬编码。
- 公开组件以 `P` 前缀命名，内部组件放 `internal/`。
- 交互组件必须支持 `normal / hovered / pressed / disabled` 状态。
- 详细规范见 `.github/instructions/pigeon-ui-qml.instructions.md`。

---

## 报告问题

请使用 GitHub Issues，并提供：

1. 操作系统和 Python / PySide6 版本。
2. 最小复现步骤或代码片段。
3. 期望行为 vs 实际行为。
4. 截图（如涉及 UI 问题）。

---

## 行为准则

参与本项目即表示同意遵守 [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md)。
