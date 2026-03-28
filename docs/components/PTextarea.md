# PTextarea

多行文本输入组件，基于 `T.TextArea`。支持占位符、状态反馈和禁用状态。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `placeholderText` | `string` | `""` | 占位提示文本（继承自 T.TextArea） |
| `text` | `string` | `""` | 输入内容（继承自 T.TextArea） |
| `status` | `string` | `""` | 状态：`""` / `"success"` / `"warning"` / `"error"` |
| `enabled` | `bool` | `true` | 是否可用（继承自 Item） |

## 状态

| 状态 | 描述 |
|------|------|
| normal | 边框 `colorBorder` |
| hovered | 边框 `colorTextSecondary` |
| focused | 边框 `colorAccent` |
| success / warning / error | 边框对应状态色 |
| disabled | 背景变暗，边框 `colorBorder` |

## 尺寸

- `implicitWidth: 220`
- `implicitHeight: 100`
- `wrapMode: Text.WordWrap`（自动换行）

## 示例

```qml
PTextarea { placeholderText: "Enter description..." }

PTextarea {
    width: 300
    implicitHeight: 120
    placeholderText: "With validation"
    status: "error"
}

PTextarea { placeholderText: "Disabled"; enabled: false }
```
