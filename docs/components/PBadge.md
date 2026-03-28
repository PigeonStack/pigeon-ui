# PBadge

徽标组件，用于在内容元素上显示数字或小圆点提示。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `count` | int | `0` | 显示数字 |
| `showZero` | bool | `false` | count 为 0 时是否仍显示 |
| `maxCount` | int | `99` | 超过此值显示 `99+` |
| `dot` | bool | `false` | 仅显示小圆点模式 |
| `badgeColor` | color | `PTheme.colorError` | 徽标背景颜色 |
| `textColor` | color | `PTheme.colorOnAccent` | 徽标文字颜色 |

## 示例

```qml
PBadge {
    count: 5

    PIcon {
        name: "mail"
        size: PTheme.iconSizeLg
    }
}

PBadge {
    dot: true
    count: 1

    Text { text: "消息" }
}
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PBadge.qml`。
