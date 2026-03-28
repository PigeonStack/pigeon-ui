# PBanner

持久性通知横幅，用于页面级提示。带左侧色带和图标。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `text` | `string` | `""` | 通知文本 |
| `type` | `string` | `"info"` | 类型：`"info"` / `"success"` / `"warning"` / `"error"` |
| `closable` | `bool` | `true` | 是否显示关闭按钮 |

## 信号

| 信号 | 说明 |
|------|------|
| `closed()` | 关闭按钮被点击 |

## 示例

```qml
PBanner {
    width: parent.width
    text: "System update available."
    type: "info"
    onClosed: visible = false
}

PBanner {
    width: parent.width
    text: "Operation failed!"
    type: "error"
}
```
