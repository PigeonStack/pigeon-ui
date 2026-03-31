# PigeonUI 开发工作流程

> 本文档适用于 v0.1.0 发布后的日常开发与版本迭代，供维护者与贡献者参考。

---

## 1. 日常开发流程

### 1.1 分支策略

```
main ← 稳定发布分支（tag 在此创建）
  └── dev ← 开发主干（日常合并目标）
        ├── feat/<name> ← 新功能分支
        └── fix/<name>  ← Bug 修复分支
```

- 所有开发工作从 `dev` 分支创建 `feat/` 或 `fix/` 分支。
- 完成后提 PR 到 `dev`，通过 CI 后合并。
- 发布时由维护者将 `dev` 合并到 `main` 并打 tag。

### 1.2 单次任务流程

```
1. 明确需求 → 2. 创建分支 → 3. 实现变更 → 4. 本地验证 → 5. 提交 PR → 6. CI 通过 → 7. 合并
```

**详细步骤：**

1. **明确需求边界**：确认涉及哪些文件、是否需要新主题变量、是否影响公开 API。
2. **创建分支**：`git checkout -b feat/xxx dev`。
3. **实现变更**：
   - 新组件：按 `.github/skills/pigeon-ui-component-workflow.SKILL.md` 执行。
   - Bug 修复：定位问题 → 修复 → 添加回归测试。
   - 主题调整：先改 `PTheme.qml`，再更新引用组件。
4. **本地验证**：
   ```powershell
   make lint          # ruff + mypy + qmllint
   make test          # pytest 全量测试
   python examples/run_gallery.py  # Gallery 启动验证
   python scripts/check_qmldir.py  # qmldir 一致性
   ```
5. **提交**：遵循 Conventional Commits 格式（见 CONTRIBUTING.md）。
6. **提 PR**：填写 PR 模板，附截图（如涉及 UI 变更）。
7. **合并**：CI 全绿后由维护者合并。

---

## 2. 版本发布流程

### 2.1 发布节奏

- **PATCH**（`0.1.x`）：Bug 修复，随时可发布。
- **MINOR**（`0.x.0`）：新功能/新组件，按里程碑周期发布。
- **MAJOR**（`x.0.0`）：破坏性 API 变更，需充分评估与迁移文档。

### 2.2 发布步骤

```
1. 冻结代码 → 2. 更新版本号 → 3. 更新 CHANGELOG → 4. 发布前检查 → 5. 合并到 main → 6. 打 tag → 7. 自动发布 → 8. 发布后验证
```

**详细步骤：**

1. **冻结代码**：`dev` 分支停止合并新功能，仅接受修复。
2. **更新版本号**：修改 `pyproject.toml` 中的 `version` 字段。
3. **更新 CHANGELOG**：在 `CHANGELOG.md` 顶部添加新版本条目。
4. **发布前检查**：
   ```powershell
   python scripts/pre_release_check.py   # 自动化检查
   make lint                             # lint 全通过
   make test                             # 测试全通过
   python examples/run_gallery.py        # Gallery 可正常启动
   ```
   同时对照 `.github/hooks/pre-release.hook.md` 清单逐项确认。
5. **合并到 main**：提 PR 从 `dev` 到 `main`，CI 通过后合并。
6. **打 tag**：
   ```powershell
   git checkout main
   git pull origin main
   git tag v0.2.0
   git push origin v0.2.0
   ```
7. **自动发布**：`release.yml` 被 tag 触发，自动执行 lint → test → build → PyPI 发布。
8. **发布后验证**：
   ```powershell
   pip install pigeon-ui==0.2.0   # 验证 PyPI 安装
   python examples/starter/main.py  # 验证基本运行
   ```

### 2.3 热修复流程

紧急 Bug 需要跳过常规开发周期时：

1. 从 `main` 创建 `fix/hotfix-xxx` 分支。
2. 修复问题 + 添加回归测试。
3. 更新版本号（PATCH +1）和 CHANGELOG。
4. 直接提 PR 到 `main`，通过 CI 后合并。
5. 打 tag 触发发布。
6. 将修复 cherry-pick 回 `dev`。

---

## 3. 新组件开发清单

新增公开组件时，按以下清单逐项完成：

- [ ] 确认组件 API 设计（属性、信号、默认尺寸）。
- [ ] 检查是否需要新增 PTheme 变量。
- [ ] 创建 `src/pigeon_ui/PigeonUI/PXxx.qml`。
- [ ] 实现 `normal/hovered/pressed/disabled` 四态。
- [ ] 配置 `Accessible.role` 和 `Accessible.name`。
- [ ] 用户可见文本使用 `qsTr()` 包裹。
- [ ] 在 `qmldir` 中注册组件。
- [ ] 在 `examples/Gallery.qml` 中添加示例。
- [ ] 创建 `docs/components/PXxx.md` API 文档。
- [ ] 运行 `python scripts/check_qmldir.py` 验证一致性。
- [ ] Gallery 启动验证通过。
- [ ] 添加 QML smoke test。

---

## 4. Bug 修复清单

- [ ] 定位问题根因。
- [ ] 编写回归测试（先写测试 → 确认失败 → 修复 → 确认通过）。
- [ ] 修复代码。
- [ ] 本地验证（`make lint && make test`）。
- [ ] 更新 CHANGELOG（如影响用户侧行为）。
- [ ] 如涉及 API 变更，补充迁移说明到 `docs/migration/`。

---

## 5. CI/CD 流水线

### 5.1 CI（每次 push/PR 到 main）

`.github/workflows/ci.yml`：
1. **Lint & Typecheck**：ruff check + ruff format + mypy + qmllint
2. **Test**：pytest 全量测试（Python 3.11 + 3.12，Windows）
3. **Build**：hatch build + 资源完整性检查

### 5.2 Release（tag 推送触发）

`.github/workflows/release.yml`：
1. lint → test → verify-version → build → publish to PyPI（OIDC）

### 5.3 CI 失败处理

- **lint 失败**：运行 `ruff check --fix` 和 `ruff format` 自动修复。
- **test 失败**：查看失败用例，本地复现并修复。
- **build 失败**：检查 `pyproject.toml` 配置和资源文件完整性。
- **version 不一致**：确保 tag 版本与 `pyproject.toml` 中的版本号一致。

---

## 6. 质量标准

| 指标 | 当前 | 目标 |
|------|------|------|
| Python 覆盖率 | 60%+ | 85%+ |
| QML lint 错误 | 0 | 0 |
| 组件 API 文档覆盖率 | 100% | 100% |
| 可交互组件 Accessible 配置率 | 100% | 100% |
| CI 通过率 | 必须 | 必须 |

---

## 7. 常用命令速查

```powershell
# 开发环境
pip install -e ".[dev]"
pre-commit install

# 验证
make lint                        # ruff + mypy + qmllint
make test                        # pytest 全量
python examples/run_gallery.py   # Gallery 启动

# 检查脚本
python scripts/check_qmldir.py       # qmldir 一致性
python scripts/check_assets.py       # wheel 资源完整性
python scripts/check_version.py      # 版本号一致性
python scripts/check_qmllint.py      # QML lint
python scripts/pre_release_check.py  # 发布前全量检查

# 构建
python -m hatch build            # 构建 wheel

# 发布（通过 tag 触发，通常不手动执行）
git tag v0.x.0
git push origin v0.x.0
```

---

## 8. 文档维护规则

- **新增/修改组件** → 同步更新 `docs/components/PXxx.md`。
- **API 破坏性变更** → 在 `docs/migration/` 添加迁移指南。
- **版本发布** → 更新 `CHANGELOG.md`、`OPEN_SOURCE_ROADMAP.md` 历史发布记录。
- **架构决策** → 记录到 `docs/adr/`。
- **主题变量变更** → 同步更新 `docs/theme/README.md`。
