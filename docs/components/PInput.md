# PInput

文本输入框组件，支持前后缀图标、清除按钮和状态校验。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `text` | string | `""` | 输入文本（继承自 TextField） |
| `placeholderText` | string | `""` | 占位提示文本 |
| `clearable` | bool | `false` | 是否显示清除按钮 |
| `status` | string | `""` | 校验状态：`""` / `"success"` / `"warning"` / `"error"` |
| `prefixIcon` | string | `""` | 前缀图标名称 |
| `suffixIcon` | string | `""` | 后缀图标名称 |
| `enabled` | bool | `true` | 是否启用 |

## 状态

支持 `normal` / `hovered` / `focused` / `disabled` 状态，边框颜色自动响应。

## 示例

```qml
PInput {
    placeholderText: "请输入用户名"
    prefixIcon: "person"
    clearable: true
}

PInput {
    text: "错误输入"
    status: "error"
}
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PInput.qml`。
