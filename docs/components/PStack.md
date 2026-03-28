# PStack

垂直堆叠布局容器，基于 `Column`，默认使用 `PTheme.spacingMd` 间距。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `spacing` | `int` | `PTheme.spacingMd` | 子项间距（继承自 Column） |

## 示例

```qml
PStack {
    width: 300

    PButton { text: "First"; width: parent.width }
    PButton { text: "Second"; width: parent.width }
    PButton { text: "Third"; width: parent.width }
}

PStack {
    spacing: PTheme.spacingLg

    Text { text: "Wide spacing" }
    PInput { placeholderText: "Name" }
    PInput { placeholderText: "Email" }
}
```
