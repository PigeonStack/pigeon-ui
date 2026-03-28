# PCheckbox

复选框组件，基于 `T.CheckBox`。支持选中/未选中状态、自定义主题色和禁用状态。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `text` | `string` | `""` | 标签文本（继承自 T.CheckBox） |
| `checked` | `bool` | `false` | 是否选中（继承自 T.CheckBox） |
| `enabled` | `bool` | `true` | 是否可用（继承自 Item） |
| `accentColor` | `color` | `PTheme.colorAccent` | 选中时指示器颜色 |

## 状态

| 状态 | 描述 |
|------|------|
| normal | 边框 `colorBorder`，背景透明 |
| hovered | 边框 `colorTextSecondary` |
| checked | 背景填充 `accentColor`，显示勾选图标 |
| disabled | 边框 `colorTextDisabled`，文字 `colorTextDisabled` |

## 示例

```qml
PCheckbox { text: "Accept terms" }
PCheckbox { text: "Selected"; checked: true }
PCheckbox { text: "Blue"; checked: true; accentColor: PTheme.colorAccentBlue }
PCheckbox { text: "Disabled"; enabled: false }
```
