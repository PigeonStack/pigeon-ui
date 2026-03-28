# PButton

基础按钮组件。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `text` | string | `""` | 按钮显示文本 |
| `enabled` | bool | `true` | 是否启用 |
| `flat` | bool | `false` | 扁平样式 |

## 信号

| 信号 | 说明 |
|------|------|
| `clicked()` | 按钮被点击时触发 |

## 状态

支持 `normal` / `hovered` / `pressed` / `disabled` 四种状态视觉反馈。

## 示例

```qml
PButton {
    text: "确认"
    onClicked: console.log("clicked")
}
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PButton.qml`。
