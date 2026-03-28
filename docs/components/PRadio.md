# PRadio

单选按钮组件，基于 `T.RadioButton`。配合 `ButtonGroup` 实现互斥选择。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `text` | `string` | `""` | 标签文本（继承自 T.RadioButton） |
| `checked` | `bool` | `false` | 是否选中（继承自 T.RadioButton） |
| `enabled` | `bool` | `true` | 是否可用（继承自 Item） |
| `accentColor` | `color` | `PTheme.colorAccent` | 选中时指示器颜色 |

## 状态

| 状态 | 描述 |
|------|------|
| normal | 圆形边框 `colorBorder`，背景透明 |
| hovered | 边框 `colorTextSecondary` |
| checked | 边框 2px `accentColor`，内部实心圆点 |
| disabled | 边框 `colorTextDisabled`，文字 `colorTextDisabled` |

## 示例

```qml
ButtonGroup { id: group }

PRadio { text: "Option A"; checked: true; ButtonGroup.group: group }
PRadio { text: "Option B"; ButtonGroup.group: group }
PRadio { text: "Option C"; ButtonGroup.group: group }

// 自定义颜色
PRadio { text: "Blue"; checked: true; accentColor: PTheme.colorAccentBlue }
```
