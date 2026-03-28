# PProgressBar

进度条组件，支持确定和不确定（加载中）两种模式。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `value` | real | `0.0` | 进度值，范围 0.0 ~ 1.0 |
| `indeterminate` | bool | `false` | 不确定模式（循环动画） |
| `accentColor` | color | `PTheme.colorAccent` | 进度条颜色 |
| `barHeight` | int | `PTheme.progressBarHeight` | 进度条高度 |
| `sweepDuration` | int | `1200` | 不确定模式往返时长（ms） |

## 示例

```qml
// 确定模式
PProgressBar {
    value: 0.65
    width: 300
}

// 不确定模式
PProgressBar {
    indeterminate: true
    accentColor: PTheme.colorAccentBlue
}
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PProgressBar.qml`。
