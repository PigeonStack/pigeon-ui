# PBreadcrumb

面包屑导航组件，支持多级路径、图标、hover 高亮。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `model` | array | `[]` | 路径数组，每项为 `{ text, icon? }`  |
| `separatorIcon` | string | `"chevron_right"` | 分隔符图标名称 |

## 信号

| 信号 | 说明 |
|------|------|
| `itemClicked(int index)` | 点击某项时触发，参数为索引 |

## Model 格式

```js
[
    { text: "Home", icon: "home" },    // icon 可选
    { text: "Settings" },
    { text: "Profile", icon: "person" }
]
```

## 行为

- 最后一项以 `DemiBold` + 主色显示，表示当前位置。
- 其他项以 `Secondary` 色显示，hover 时高亮为主色。
- 分隔符自动出现在除第一项外的每项前面。

## 示例

```qml
// 基础用法
PBreadcrumb {
    model: [
        { text: "Home" },
        { text: "Components" },
        { text: "PBreadcrumb" }
    ]
    onItemClicked: function(index) {
        console.log("Navigate to:", index)
    }
}

// 带图标
PBreadcrumb {
    model: [
        { text: "Home", icon: "home" },
        { text: "Settings", icon: "settings" },
        { text: "Profile", icon: "person" }
    ]
}
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PBreadcrumb.qml`。
