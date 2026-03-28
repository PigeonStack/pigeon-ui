# PWindow

无边框窗口组件，提供自定义标题栏、侧边栏导航、阴影、圆角和窗口控制功能。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `windowTitle` | string | `"PigeonUI Application"` | 标题栏文字 |
| `windowTitleSize` | int | `PTheme.fontSizeSm` | 标题字号 |
| `windowRadius` | int | `PTheme.radiusLg` | 窗口圆角 |
| `windowBg` | color | `PTheme.colorBg` | 窗口背景色 |
| `titleBarColor` | color | `PTheme.colorSurface` | 标题栏背景色 |
| `showTitleBar` | bool | `true` | 是否显示标题栏 |
| `resizable` | bool | `true` | 是否可缩放 |
| `showSidebar` | bool | `false` | 是否显示侧边栏 |
| `sidebarColor` | color | `PTheme.colorSurface` | 侧边栏背景色 |
| `navBar` | PNavBar | — | 侧边栏导航栏引用 |
| `pages` | list | `[]` | 页面列表，配合 navBar 自动切换 |
| `contentArea` | Item | — | 只读，内容区域引用 |

## 示例

```qml
PWindow {
    windowTitle: "My App"
    showSidebar: true
    navBar.model: [
        { text: "Home", icon: "home" },
        { text: "Settings", icon: "settings" }
    ]

    pages: [
        Text { text: "Home Page" },
        Text { text: "Settings Page" }
    ]
}
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PWindow.qml`。
