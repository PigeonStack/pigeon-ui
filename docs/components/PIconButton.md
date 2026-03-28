# PIconButton

图标按钮组件，仅显示图标的按钮。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `iconName` | string | `""` | 图标名称 |
| `iconSource` | url | `""` | 自定义图标路径 |
| `iconSize` | int | `PTheme.iconSizeLg` | 图标尺寸 |
| `iconColor` | color | `PTheme.colorTextPrimary` | 图标颜色 |
| `flatStyle` | bool | `true` | 扁平样式（无背景） |
| `accentColor` | color | `PTheme.colorAccent` | 悬浮时的强调色 |
| `size` | int | `PTheme.controlHeight` | 按钮整体尺寸 |
| `enabled` | bool | `true` | 是否启用 |

## 信号

| 信号 | 说明 |
|------|------|
| `clicked()` | 按钮被点击时触发 |

## 状态

支持 `normal` / `hovered` / `pressed` / `disabled` 四种状态视觉反馈。

## 示例

```qml
PIconButton {
    iconName: "add"
    onClicked: console.log("add clicked")
}

PIconButton {
    iconName: "settings"
    flatStyle: false
    accentColor: PTheme.colorAccentBlue
}
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PIconButton.qml`。
