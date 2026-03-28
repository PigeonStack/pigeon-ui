# PTag

小型标签组件，用于标记和分类。支持多种类型颜色和可关闭功能。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `text` | `string` | `""` | 标签文本 |
| `type` | `string` | `"default"` | 类型：`"default"` / `"primary"` / `"success"` / `"warning"` / `"error"` |
| `closable` | `bool` | `false` | 是否显示关闭按钮 |
| `accentColor` | `color` | `PTheme.colorAccent` | `type: "primary"` 时的主色 |

## 信号

| 信号 | 说明 |
|------|------|
| `closed()` | 关闭按钮被点击时触发 |

## 状态

- **default**：灰色背景 + 次要文字色
- **primary**：主题色半透明背景
- **success / warning / error**：对应状态色半透明背景

## 示例

```qml
PTag { text: "Default" }
PTag { text: "Success"; type: "success" }
PTag { text: "Removable"; type: "error"; closable: true; onClosed: destroy() }
PTag { text: "Blue"; type: "primary"; accentColor: PTheme.colorAccentBlue }
```
