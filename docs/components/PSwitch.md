# PSwitch

开关组件，用于切换布尔状态。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `checked` | bool | `false` | 是否打开 |
| `enabled` | bool | `true` | 是否启用 |
| `accentColor` | color | `PTheme.colorAccent` | 打开状态的轨道颜色 |

## 信号

| 信号 | 说明 |
|------|------|
| `toggled()` | 开关状态改变时触发 |

## 状态

支持 `normal` / `hovered` / `pressed` / `disabled` 四种状态视觉反馈。

## 示例

```qml
PSwitch {
    checked: true
    onToggled: console.log("switch:", checked)
}

PSwitch {
    accentColor: PTheme.colorSuccess
}
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PSwitch.qml`。
