# PList

列表组件，支持文本、图标和副标题。内置悬停和分割线。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `model` | `var` | `[]` | 列表数据：`["text"]` 或 `[{text, icon, subtitle}]` |
| `showDivider` | `bool` | `true` | 是否显示分割线 |
| `itemHeight` | `int` | `40` | 每行高度 |

## 信号

| 信号 | 说明 |
|------|------|
| `itemClicked(int index)` | 列表项被点击 |

## 示例

```qml
PList {
    width: 280
    model: ["Dashboard", "Analytics", "Settings"]
    onItemClicked: function(index) { console.log(index) }
}

PList {
    width: 280
    itemHeight: 48
    model: [
        { text: "Inbox", icon: "mail", subtitle: "3 new" },
        { text: "Drafts", icon: "edit", subtitle: "2 items" }
    ]
}
```
