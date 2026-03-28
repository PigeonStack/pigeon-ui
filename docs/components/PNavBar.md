# PNavBar

导航栏组件，支持竖向/横向布局、折叠、底部固定项和活动指示条。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `model` | var | `[]` | 导航项数据，`[{text, icon}]` 或 `["text"]` |
| `currentIndex` | int | `0` | 当前选中项索引 |
| `accentColor` | color | `PTheme.colorAccent` | 强调颜色 |
| `vertical` | bool | `true` | 是否竖向排列 |
| `itemHeight` | int | `PTheme.navItemHeight` | 单项高度 |
| `itemWidth` | int | 自动 | 横向模式单项宽度 |
| `collapsed` | bool | `false` | 是否折叠（仅显示图标） |
| `collapsedWidth` | int | `PTheme.navCollapsedWidth` | 折叠宽度 |
| `expandedWidth` | int | `PTheme.navExpandedWidth` | 展开宽度 |
| `showCollapseButton` | bool | `false` | 是否显示折叠按钮 |
| `bottomModel` | var | `[]` | 底部固定项数据 |
| `bottomCurrentIndex` | int | `-1` | 底部选中索引 |
| `textRole` | string | `"text"` | model 中文本字段名 |
| `iconRole` | string | `"icon"` | model 中图标字段名 |

## 信号

| 信号 | 说明 |
|------|------|
| `itemClicked(int index)` | 主项被点击 |
| `bottomItemClicked(int index)` | 底部项被点击 |

## 方法

| 方法 | 说明 |
|------|------|
| `toggle()` | 切换折叠/展开 |

## 示例

```qml
PNavBar {
    model: [
        { text: "首页", icon: "home" },
        { text: "设置", icon: "settings" }
    ]
    bottomModel: [
        { text: "帮助", icon: "info" }
    ]
    showCollapseButton: true
}
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PNavBar.qml`。
