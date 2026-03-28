# PTooltip

工具提示组件，鼠标悬浮时显示辅助说明。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `text` | string | `""` | 提示文本内容 |
| `showDelay` | int | `600` | 显示延迟（ms） |
| `hideDelay` | int | `200` | 隐藏延迟（ms） |
| `timeout` | int | `4000` | 自动隐藏时长（ms） |

## 示例

```qml
PButton {
    text: "悬浮查看"
    PTooltip {
        text: "这是一个提示"
    }
}

PIconButton {
    iconName: "info"
    PTooltip {
        text: "更多信息"
        showDelay: 300
    }
}
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PTooltip.qml`。
