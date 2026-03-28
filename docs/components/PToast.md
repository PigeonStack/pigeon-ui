# PToast

临时通知组件，从顶部滑入，自动消失。支持 info/success/warning/error 四种类型。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `text` | `string` | `""` | 通知文本 |
| `type` | `string` | `"info"` | 类型：`"info"` / `"success"` / `"warning"` / `"error"` |
| `duration` | `int` | `3000` | 自动关闭时长（ms），0 表示不自动关闭 |
| `maxWidth` | `int` | `360` | 最大宽度 |

## 信号

| 信号 | 说明 |
|------|------|
| `closed()` | 关闭动画完成后触发 |

## 方法

| 方法 | 说明 |
|------|------|
| `show(message, type)` | 显示通知，参数可选覆盖 text/type |
| `close()` | 手动关闭 |

## 用法

需挂载到窗口级容器（如 `PWindow.contentArea`）以确保显示在顶层。

```qml
PToast {
    id: toast
    parent: root.contentArea
}

PButton {
    text: "Show Toast"
    onClicked: toast.show("Hello!", "success")
}
```
