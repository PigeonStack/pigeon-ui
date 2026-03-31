# PigeonUI

[![PyPI version](https://img.shields.io/pypi/v/pigeon-ui)](https://pypi.org/project/pigeon-ui/)
[![CI](https://github.com/aspect-ui/pigeon-ui/actions/workflows/ci.yml/badge.svg)](https://github.com/aspect-ui/pigeon-ui/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Python](https://img.shields.io/pypi/pyversions/pigeon-ui)](https://pypi.org/project/pigeon-ui/)

一致设计语言驱动的 **PySide6 + QML** 桌面组件库。

> Windows 平台 · MIT 许可 · PTheme 主题系统统一驱动

---

## 特性

- **PTheme 主题系统**：60+ design tokens（颜色、字号、圆角、间距、动画时长），支持 dark/light 一键切换。
- **36 个开箱即用组件**：覆盖基础、数据录入、数据展示、导航、反馈、容器六大类别。
- **无边框窗口**：PWindow 内置 FramelessHelper，Windows 下原生支持 Snap Layout。
- **可访问性**：13 个组件配置 Accessible.role/name，6 个组件具备焦点环。
- **pip 安装即可使用**：`pip install pigeon-ui`，QML 中 `import PigeonUI` 即可。

---

## 安装

```bash
pip install pigeon-ui
```

> 需要 Python >= 3.11，PySide6 >= 6.7。仅支持 Windows 平台。

---

## 快速开始

### Python 入口

```python
import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

import pigeon_ui

app = QGuiApplication(sys.argv)
engine = QQmlApplicationEngine()

pigeon_ui.register(engine)

engine.load(Path(__file__).parent / "main.qml")

if not engine.rootObjects():
    sys.exit(1)

sys.exit(app.exec())
```

### QML 使用

```qml
import QtQuick
import PigeonUI

PWindow {
    width: 800
    height: 600
    title: "My App"

    PButton {
        text: "Hello PigeonUI"
        anchors.centerIn: parent
    }
}
```

---

## 组件矩阵

| 类别 | 组件 | 数量 |
|------|------|------|
| 基础 | PButton · PIconButton · PIcon · PBadge · PTag · PTooltip · PProgressBar | 7 |
| 数据录入 | PInput · PSwitch · PCheckbox · PRadio · PSelect · PTextarea · PSlider | 7 |
| 数据展示 | PTable · PList · PPagination · PScrollBar · PAvatar · PSpinner | 6 |
| 导航 | PNavBar · PTabBar · PBreadcrumb | 3 |
| 反馈 | PDialog · PToast · PSnackbar · PBanner · PMenu · PContextMenu | 6 |
| 容器/布局 | PCard · PDrawer · PDivider · PStack · PGrid | 5 |
| 窗口/主题 | PWindow · PTheme（单例） | 2 |

**共 36 个组件**

---

## 运行示例

```bash
git clone https://github.com/aspect-ui/pigeon-ui.git
cd pigeon-ui
pip install -e ".[dev]"
python examples/run_gallery.py
```

更多示例见 [`examples/`](examples/) 目录。

---

---

## 贡献

欢迎参与！请阅读 [CONTRIBUTING.md](CONTRIBUTING.md) 了解开发流程与提交规范。

1. Fork 本仓库
2. 创建功能分支 (`git checkout -b feat/my-feature`)
3. 提交变更 (`git commit -m 'feat(PButton): add size variant'`)
4. 推送分支 (`git push origin feat/my-feature`)
5. 提交 Pull Request

---

## 许可证

[MIT License](LICENSE) — 详见 LICENSE 文件。

第三方资源版权声明见 [NOTICE](NOTICE)。
