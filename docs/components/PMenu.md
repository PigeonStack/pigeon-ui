# PMenu

弹出菜单组件。覆盖父容器，点击外部自动关闭。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `model` | `var` | `[]` | 菜单项数组：`["text"]` 或 `[{text, icon}]` |
| `menuWidth` | `int` | `180` | 菜单宽度 |

## 键盘导航

| 按键 | 行为 |
|------|------|
| `↑` | 高亮上一项（循环） |
| `↓` | 高亮下一项（循环） |
| `Enter` | 触发当前高亮项的 `itemClicked` |
| `Esc` | 关闭菜单 |

## 可访问性

- `Accessible.role: Accessible.PopupMenu`
- 菜单项：`Accessible.role: Accessible.MenuItem`
- 鼠标悬停和键盘导航联动高亮状态

## 信号

| 信号 | 说明 |
|------|------|
| `itemClicked(int index)` | 菜单项被点击 |

## 方法

| 方法 | 说明 |
|------|------|
| `open(x, y)` | 在指定位置打开菜单 |
| `popup(x, y)` | `open` 的别名 |
| `close()` | 关闭菜单 |

## 示例

```qml
PMenu {
    id: menu
    parent: root.contentArea
    model: [
        { text: "New File", icon: "document" },
        { text: "Open", icon: "folder" },
        { text: "Save", icon: "save" }
    ]
    onItemClicked: function(index) { console.log("Clicked:", index) }
}

PButton {
    text: "Open Menu"
    onClicked: menu.open(x, y + height)
}
```
