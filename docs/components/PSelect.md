# PSelect

下拉选择组件，点击展开选项列表。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `model` | `var` | `[]` | 选项数组：`["text"]` 或 `[{text, value}]` |
| `currentIndex` | `int` | `-1` | 当前选中索引 |
| `currentText` | `string` | 只读 | 当前选中文本 |
| `currentValue` | `var` | 只读 | 当前选中值 |
| `placeholder` | `string` | `""` | 占位提示文本 |
| `accentColor` | `color` | `PTheme.colorAccent` | 选中项高亮色 |
| `enabled` | `bool` | `true` | 是否可用 |

## 信号

| 信号 | 说明 |
|------|------|
| `selected(int index)` | 选项被选中 |

## 状态

| 状态 | 描述 |
|------|------|
| normal | 边框 `colorBorder` |
| hovered | 边框 `colorTextSecondary` |
| opened | 边框 `accentColor`，箭头旋转 180° |
| disabled | 背景变暗，文本 `colorTextDisabled` |

## 示例

```qml
PSelect {
    width: 220
    placeholder: "Choose..."
    model: ["Small", "Medium", "Large"]
    onSelected: function(index) { console.log("Selected:", index) }
}
```
