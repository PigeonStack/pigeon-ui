# PContextMenu

右键上下文菜单。包裹内容区域，右键点击自动弹出菜单。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `model` | `var` | `[]` | 菜单项数组：`["text"]` 或 `[{text, icon}]` |
| `menuWidth` | `int` | `180` | 菜单宽度 |
| `content` | `default` | — | 右键目标内容 |

## 信号

| 信号 | 说明 |
|------|------|
| `itemClicked(int index)` | 菜单项被点击 |

## 示例

```qml
PContextMenu {
    model: [
        { text: "Cut", icon: "copy" },
        { text: "Copy", icon: "copy" },
        { text: "Paste", icon: "clipboard" }
    ]
    onItemClicked: function(index) { console.log("Context:", index) }

    Rectangle {
        width: 200
        height: 100
        color: PTheme.colorSurfaceAlt
        Text { anchors.centerIn: parent; text: "Right-click me" }
    }
}
```
