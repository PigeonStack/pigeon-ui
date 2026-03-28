# PDivider

简单的分割线组件，支持水平和垂直方向。

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `vertical` | `bool` | `false` | 是否为垂直方向 |
| `thickness` | `int` | `1` | 线条粗细（px） |
| `color` | `color` | `PTheme.colorDivider` | 继承自 Rectangle，可覆盖 |

## 尺寸行为

- 水平模式：`implicitWidth: 200`, `implicitHeight: thickness`
- 垂直模式：`implicitWidth: thickness`, `implicitHeight: 200`

## 示例

```qml
// 水平分割线
PDivider { width: parent.width }

// 垂直分割线
PDivider { vertical: true; height: 60 }

// 加粗分割线
PDivider { width: parent.width; thickness: 2 }
```
