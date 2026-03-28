# PDrawer

侧边抽屉面板，支持从左或右滑入，带半透明遮罩。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `edge` | `enum` | `Qt.LeftEdge` | 滑出方向：`Qt.LeftEdge` / `Qt.RightEdge` |
| `drawerWidth` | `int` | `280` | 抽屉宽度 |
| `closeOnOverlay` | `bool` | `true` | 点击遮罩是否关闭 |
| `closeOnEscape` | `bool` | `true` | 按 ESC 键是否关闭 |
| `modal` | `bool` | `true` | 是否显示遮罩层 |
| `content` | `default` | — | 抽屉内容 |

## 可访问性

- `Accessible.role: Accessible.Pane`
- 打开时保存并恢复焦点
- 支持 ESC 键关闭（可通过 `closeOnEscape` 控制）

## 信号

| 信号 | 说明 |
|------|------|
| `closed()` | 关闭动画完成后触发 |

## 方法

| 方法 | 说明 |
|------|------|
| `open()` | 打开抽屉 |
| `close()` | 关闭抽屉 |

## 示例

```qml
PDrawer {
    id: drawer
    parent: root.contentArea
    edge: Qt.LeftEdge

    Column {
        width: parent.width
        spacing: PTheme.spacingMd

        Text { text: "Drawer Title"; font.bold: true }
        PList { model: ["Item 1", "Item 2", "Item 3"] }
    }
}

PButton { text: "Open"; onClicked: drawer.open() }
```
