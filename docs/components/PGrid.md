# PGrid

网格布局容器，基于 `Grid`，默认 3 列，使用 `PTheme.spacingMd` 间距。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `columns` | `int` | `3` | 列数（继承自 Grid） |
| `spacing` | `int` | `PTheme.spacingMd` | 子项间距（继承自 Grid） |

## 示例

```qml
PGrid {
    columns: 3

    Repeater {
        model: 9
        Rectangle {
            width: 80; height: 80
            radius: PTheme.radiusMd
            color: PTheme.colorSurfaceAlt
        }
    }
}

PGrid {
    columns: 4
    spacing: PTheme.spacingSm

    PTag { text: "Tag 1" }
    PTag { text: "Tag 2" }
    PTag { text: "Tag 3" }
    PTag { text: "Tag 4" }
}
```
