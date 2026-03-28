# Changelog

本项目的变更记录。格式基于 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.1.0/)，版本号遵循 [Semantic Versioning](https://semver.org/lang/zh-CN/)。

## [0.1.0] - 2026-03-28

### Added
- 核心组件（36 个）：PButton、PIconButton、PIcon、PBadge、PInput、PSwitch、PCard、PDialog、PTooltip、PProgressBar、PNavBar、PTabBar、PTag、PToast、PSnackbar、PBanner、PMenu、PContextMenu、PDrawer、PSelect、PCheckbox、PRadio、PTextarea、PTable、PList、PDivider、PStack、PGrid、PSlider、PAvatar、PSpinner、PPagination、PBreadcrumb、PScrollBar。
- PTheme 主题单例系统：60+ design tokens（颜色、字号、圆角、间距、动画时长），dark/light 模式切换。
- PWindow 无边框窗口 + FramelessHelper（仅 Windows）。
- Gallery 示例应用 + 分类示例（starter、dialog、input、nav、theming）。
- Python 包入口 `pigeon_ui.register(engine)`。
- 仓库治理文件：README、LICENSE (MIT)、CONTRIBUTING、CODE_OF_CONDUCT、SECURITY、CHANGELOG。
- 开发工具链：ruff、mypy、pre-commit。
- 测试体系：Python 层 / QML 冒烟 / 集成 / 回归测试，pytest-cov 覆盖率集成。
- GitHub Actions CI（lint + typecheck + test + build，Windows，Python 3.11/3.12）。
- QML lint 集成（`.qmllint.ini` + `scripts/check_qmllint.py`）。
- 发布前自动检查（`scripts/pre_release_check.py`）。
- 发布工作流 `release.yml`（tag 触发 → PyPI OIDC 发布）。
- 可访问性：13 个组件 Accessible.role/name，6 个组件焦点环。
- i18n：组件内文本 `qsTr()` 包裹，RTL 兼容。
- 社区模板：Issue 模板（Bug/Feature/Question）、PR 模板、Discussions 分类。
- 组件 API 文档（`docs/components/`）、主题文档（`docs/theme/`）。

### Changed
- 深色模式配色采用 Modern Black 风格（参考 Linear、Vercel）。
