# PigeonUI 弹层定位策略

## 弹层分类

| 组件 | 类型 | z-order | 定位方式 | 模态 |
|------|------|---------|----------|------|
| PDialog | 模态对话框 | 998 | anchors.fill parent（全屏遮罩） | 是 |
| PDrawer | 侧边抽屉 | 998 | anchors.fill parent + edge 定位 | 是 |
| PMenu | 弹出菜单 | 998 | anchors.fill parent + 绝对 x,y 坐标 | 否 |
| PContextMenu | 右键菜单 | 998（内部 PMenu） | 自动挂载到根节点 | 否 |
| PToast | 顶部通知 | 999 | anchors.left/right parent + 顶部滑入 | 否 |
| PSnackbar | 底部通知 | 999 | anchors.left/right/bottom parent + 底部滑入 | 否 |

## 挂载策略

### Window 级挂载（推荐）

弹层组件应放置在 `PWindow` 的 `contentArea` 下，与页面内容同级：

```qml
PWindow {
    id: window

    // 页面内容
    Column { ... }

    // 弹层组件
    PDialog {
        id: myDialog
        // anchors.fill: parent 会自动填满 contentArea
    }

    PToast {
        id: toast
        // anchors.left/right: parent 自动撑满
    }
}
```

### 局部挂载

对于仅在特定区域内显示的弹层，可将其放在目标容器内：

```qml
Rectangle {
    id: panel

    PMenu {
        id: panelMenu
        // anchors.fill: parent 填满 panel，菜单弹出范围受限于 panel
    }
}
```

### PContextMenu 自动挂载

`PContextMenu` 内部自动将 `PMenu` re-parent 到组件树根节点，保证弹出菜单不被父级裁剪：

```qml
PContextMenu {
    model: ["复制", "粘贴", "删除"]
    onItemClicked: (index) => { ... }

    // 包裹目标内容
    Text { text: "右键点击此处" }
}
```

## z-order 约定

| z 值 | 用途 |
|------|------|
| 默认 (0) | 普通页面内容 |
| 998 | 交互弹层（PDialog、PDrawer、PMenu） |
| 999 | 通知弹层（PToast、PSnackbar） |

通知层 z 值高于交互弹层，确保通知始终可见。

## 关闭策略（closePolicy）

| 属性 | 默认值 | 适用组件 |
|------|--------|----------|
| `closeOnOverlay` | `true` | PDialog、PDrawer |
| `closeOnEscape` | `true` | PDialog、PDrawer |
| `modal` | `true` | PDialog、PDrawer |

- PMenu / PContextMenu：点击菜单外部即关闭，ESC 键关闭。
- PToast / PSnackbar：通过 `duration` 定时自动关闭，或点击关闭按钮。

## 焦点管理

### 模态弹层（PDialog、PDrawer）

1. **打开时**：保存之前的焦点项（`_p.previousFocusItem`），将焦点移入弹层。
2. **焦点陷阱**：PDialog 使用 Tab/Backtab 在确认/取消按钮间循环，防止焦点逃离。
3. **关闭时**：自动恢复之前保存的焦点项。

### 菜单弹层（PMenu）

1. **打开时**：获取焦点，`highlightIndex` 重置为 -1。
2. **键盘导航**：Up/Down 移动高亮，Enter 触发选中，ESC 关闭。
3. **鼠标联动**：鼠标悬停自动更新 `highlightIndex`。

### 通知弹层（PToast、PSnackbar）

- 不获取焦点，不中断用户当前操作。
- 通过 `Accessible.role: Accessible.AlertMessage` 让屏幕阅读器自动播报。

## 可访问性

| 组件 | Accessible.role | 说明 |
|------|-----------------|------|
| PDialog | `Dialog` | 标题设为 `Heading`，按钮有独立 name |
| PDrawer | `Pane` | 支持 ESC 关闭 |
| PMenu | `PopupMenu` | 子项为 `MenuItem` |
| PToast | `AlertMessage` | 自动播报通知内容 |
| PSnackbar | `AlertMessage` | 自动播报通知内容 |
