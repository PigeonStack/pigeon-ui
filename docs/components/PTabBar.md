# PTabBar

标签栏组件，用于页面/视图切换。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `model` | var | `[]` | 标签数据，`["Tab1", "Tab2"]` 或 `[{text: "Tab1"}]` |
| `currentIndex` | int | `0` | 当前选中标签索引 |
| `accentColor` | color | `PTheme.colorAccent` | 指示条和选中文字颜色 |
| `tabHeight` | int | `PTheme.controlHeight` | 标签高度 |
| `tabMinWidth` | int | `60` | 标签最小宽度 |

## 信号

| 信号 | 说明 |
|------|------|
| `tabClicked(int index)` | 标签被点击时触发 |

## 状态

标签支持 `normal` / `hovered` / `pressed` / `current` 状态视觉反馈，底部有动态滑动指示条。

## 示例

```qml
PTabBar {
    model: ["概览", "详情", "设置"]
    currentIndex: 0
    onTabClicked: (index) => console.log("tab:", index)
}
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PTabBar.qml`。
