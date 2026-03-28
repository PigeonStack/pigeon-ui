# PTable

简版表格组件，支持表头 + 数据行，可选条纹样式。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `columns` | `var` | `[]` | 列定义：`[{title, width}]`，width 可选（默认均分） |
| `rows` | `var` | `[]` | 二维数据数组：`[[cell1, cell2, ...], ...]` |
| `rowHeight` | `int` | `36` | 数据行高度 |
| `headerHeight` | `int` | `36` | 表头高度 |
| `showBorder` | `bool` | `true` | 是否显示外框 |
| `striped` | `bool` | `false` | 是否显示条纹背景 |

## 信号

| 信号 | 说明 |
|------|------|
| `cellClicked(int row, int col)` | 单元格被点击（预留） |

## 示例

```qml
PTable {
    width: 500
    columns: [
        { title: "Name", width: 150 },
        { title: "Role", width: 120 },
        { title: "Status" }
    ]
    rows: [
        ["Alice", "Developer", "Active"],
        ["Bob", "Designer", "Away"]
    ]
}
```
