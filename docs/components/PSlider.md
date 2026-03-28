# PSlider

滑块组件，基于 `T.Slider`，支持水平/垂直方向、值标签、步进。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `from` | real | `0.0` | 最小值 |
| `to` | real | `1.0` | 最大值 |
| `value` | real | `0.0` | 当前值 |
| `stepSize` | real | `0.0` | 步进值，`0` 表示连续 |
| `orientation` | enum | `Qt.Horizontal` | 方向（`Qt.Horizontal` / `Qt.Vertical`） |
| `accentColor` | color | `PTheme.colorAccent` | 滑块与填充色 |
| `showValue` | bool | `false` | 按下时显示值标签 |

## 信号

继承自 `T.Slider`：

| 信号 | 说明 |
|------|------|
| `moved()` | 用户拖动时触发 |
| `valueChanged()` | 值变化时触发 |

## 状态

支持 `normal` / `hovered` / `pressed` / `disabled` 四种状态视觉反馈。按下时滑块放大，聚焦时显示焦点环。

## 示例

```qml
// 基础用法
PSlider {
    from: 0; to: 100; value: 40
    width: 300
}

// 带步进和值标签
PSlider {
    from: 0; to: 100; value: 50
    stepSize: 10
    showValue: true
}

// 自定义颜色
PSlider {
    from: 0; to: 1; value: 0.7
    accentColor: PTheme.colorAccentBlue
}
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PSlider.qml`。
