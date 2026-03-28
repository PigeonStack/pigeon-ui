# PIcon

图标组件，支持 Fluent System Icons 字体图标和自定义图片图标。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `name` | string | `""` | 图标名称（Fluent 图标映射键） |
| `filled` | bool | `false` | 是否使用 Filled 变体 |
| `size` | int | `PTheme.iconSizeLg` | 图标尺寸（px） |
| `color` | color | `PTheme.colorTextPrimary` | 图标颜色 |
| `source` | url | `""` | 自定义图片路径（SVG/PNG），优先于 name |

## 示例

```qml
// 字体图标
PIcon {
    name: "home"
    size: PTheme.iconSizeLg
    color: PTheme.colorAccent
}

// 图片图标
PIcon {
    source: "assets/logo.svg"
    size: 24
}
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PIcon.qml`。
