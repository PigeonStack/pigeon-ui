# PCard

卡片容器组件，支持标题、内容区和底部区域。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `title` | string | `""` | 卡片标题 |
| `subtitle` | string | `""` | 卡片副标题 |
| `headerVisible` | bool | 自动 | 标题/副标题非空时自动显示 |
| `footerVisible` | bool | `false` | 是否显示底部区域 |
| `padding` | int | `PTheme.spacingMd` | 内边距 |

## 插槽

| 插槽 | 说明 |
|------|------|
| `default` | 卡片内容区 |
| `footer` | 底部区域内容 |

## 示例

```qml
PCard {
    title: "标题"
    subtitle: "副标题描述"
    width: 300

    Text {
        text: "卡片内容"
        color: PTheme.colorTextPrimary
    }
}
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PCard.qml`。
