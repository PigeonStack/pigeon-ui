# PSnackbar

底部滑入的通知条，支持可选操作按钮，自动消失。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `text` | `string` | `""` | 通知文本 |
| `actionText` | `string` | `""` | 操作按钮文本，空则不显示 |
| `duration` | `int` | `4000` | 自动关闭时长（ms） |
| `accentColor` | `color` | `PTheme.colorAccent` | 操作按钮颜色 |
| `maxWidth` | `int` | `480` | 最大宽度 |

## 信号

| 信号 | 说明 |
|------|------|
| `actionClicked()` | 操作按钮被点击 |
| `closed()` | 关闭动画完成后触发 |

## 方法

| 方法 | 说明 |
|------|------|
| `show(message, actionText)` | 显示通知 |
| `close()` | 手动关闭 |

## 示例

```qml
PSnackbar {
    id: snackbar
    parent: root.contentArea
}

PButton {
    onClicked: snackbar.show("Item deleted.", "UNDO")
}
```
