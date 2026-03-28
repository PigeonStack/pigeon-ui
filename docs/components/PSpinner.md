# PSpinner

加载旋转动画组件，使用 Canvas 绘制弧线实现旋转效果。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `size` | int | `PTheme.spinnerSizeMd` | 控件尺寸（宽高相等） |
| `color` | color | `PTheme.colorAccent` | 弧线颜色 |
| `running` | bool | `true` | 是否运行动画 |
| `strokeWidth` | int | `size / 10`（最小 2） | 弧线宽度 |

## 主题尺寸

| Token | 值 |
|-------|----|
| `PTheme.spinnerSizeSm` | 16 |
| `PTheme.spinnerSizeMd` | 24 |
| `PTheme.spinnerSizeLg` | 36 |

## 示例

```qml
// 基础用法
PSpinner { }

// 大尺寸 + 自定义颜色
PSpinner {
    size: PTheme.spinnerSizeLg
    color: PTheme.colorAccentBlue
}

// 配合文字
Row {
    spacing: PTheme.spacingSm
    PSpinner { size: PTheme.spinnerSizeMd }
    Text {
        text: "Loading..."
        color: PTheme.colorTextSecondary
    }
}

// 控制启停
PSpinner {
    running: isLoading
}
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PSpinner.qml`。
