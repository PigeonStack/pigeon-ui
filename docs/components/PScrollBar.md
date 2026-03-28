# PScrollBar

滚动条组件，基于 `T.ScrollBar`，支持自动隐藏、悬停展宽、平滑过渡动画。适用于 Flickable、ListView 等可滚动视图。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `autoHide` | bool | `true` | 内容不滚动时自动隐藏 |
| `showDelay` | int | `0` | 显示延迟（ms） |
| `hideDelay` | int | `1000` | 停止滚动后隐藏延迟（ms） |
| `orientation` | enum | 由 attached 属性决定 | `Qt.Vertical` / `Qt.Horizontal` |

> 其余属性继承自 `T.ScrollBar`：`position`、`size`、`active`、`pressed`、`hovered` 等。

## 行为

- **自动隐藏**：`autoHide: true` 时，仅在滚动或鼠标悬停时显示，停止操作后淡出。
- **宽度展开**：默认宽度 6px，鼠标悬停时展宽至 10px，平滑过渡。
- **颜色状态**：idle → hover → pressed 三级反馈色。
- **背景轨道**：仅在悬停或按下时显示半透明背景。

## 示例

```qml
// 配合 Flickable 使用
Flickable {
    width: 300; height: 400
    contentHeight: _col.implicitHeight
    clip: true

    Column {
        id: _col
        width: parent.width
        Repeater { model: 50; delegate: Text { text: "Item " + index } }
    }

    ScrollBar.vertical: PScrollBar { }
}

// 始终显示
Flickable {
    contentHeight: 2000
    ScrollBar.vertical: PScrollBar { autoHide: false }
}

// 配合 ListView 使用
ListView {
    model: 100
    delegate: Text { text: modelData }
    ScrollBar.vertical: PScrollBar { }
}
```

## 无障碍

- `Accessible.role: Accessible.ScrollBar`
- 自动根据方向设置 `Accessible.name`。

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PScrollBar.qml`。
