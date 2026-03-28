# PDialog

模态对话框，支持标题、消息、自定义内容、确认/取消按钮。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `title` | `string` | `""` | 对话框标题 |
| `message` | `string` | `""` | 消息文本 |
| `body` | `default` | — | 自定义内容区域 |
| `confirmText` | `string` | `"OK"` | 确认按钮文本 |
| `cancelText` | `string` | `"Cancel"` | 取消按钮文本 |
| `showCancel` | `bool` | `true` | 是否显示取消按钮 |
| `accentColor` | `color` | `PTheme.colorAccent` | 确认按钮强调色 |
| `dialogWidth` | `int` | `360` | 对话框宽度 |
| `closeOnOverlay` | `bool` | `false` | 点击遮罩是否关闭 |
| `closeOnEscape` | `bool` | `true` | 按 ESC 键是否关闭 |
| `modal` | `bool` | `true` | 是否显示遮罩层 |

## 信号

| 信号 | 说明 |
|------|------|
| `confirmed()` | 确认按钮点击 |
| `cancelled()` | 取消按钮点击 |
| `closed()` | 关闭动画完成后触发 |

## 方法

| 方法 | 说明 |
|------|------|
| `open()` | 打开对话框 |
| `close()` | 关闭对话框 |

## 键盘导航

| 按键 | 行为 |
|------|------|
| `Tab` / `Shift+Tab` | 在确认/取消按钮间循环（焦点陷阱） |
| `Enter` | 触发当前聚焦按钮 |
| `Esc` | 关闭对话框（可通过 `closeOnEscape` 控制） |

## 可访问性

- `Accessible.role: Accessible.Dialog`
- 标题：`Accessible.role: Accessible.Heading`
- 按钮有独立 `Accessible.name`
- 打开时保存焦点，关闭时恢复

## 示例

```qml
PDialog {
    id: dialog
    parent: root.contentArea
    title: "Confirm Action"
    message: "Are you sure you want to continue?"
    onConfirmed: console.log("Confirmed")
    onCancelled: console.log("Cancelled")
}

PButton { text: "Open Dialog"; onClicked: dialog.open() }
```
