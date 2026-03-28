# PAvatar

头像组件，支持图片、文字首字母、图标、默认回退四种显示模式。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `source` | string | `""` | 图片路径，优先级最高 |
| `text` | string | `""` | 显示名称，自动提取首字母（1~2 个） |
| `iconName` | string | `""` | 图标名称，图片和文字均为空时使用 |
| `size` | int | `PTheme.avatarSizeMd` | 头像尺寸（宽高相等） |
| `bgColor` | color | `PTheme.avatarBgColor` | 背景色 |
| `textColor` | color | `PTheme.colorTextPrimary` | 文字/图标颜色 |

## 显示优先级

1. `source` 不为空 → 显示图片
2. `text` 不为空 → 显示首字母
3. `iconName` 不为空 → 显示指定图标
4. 以上均空 → 显示默认 `person` 图标

## 主题尺寸

| Token | 值 |
|-------|----|
| `PTheme.avatarSizeSm` | 28 |
| `PTheme.avatarSizeMd` | 36 |
| `PTheme.avatarSizeLg` | 48 |
| `PTheme.avatarSizeXl` | 64 |

## 示例

```qml
// 文字首字母
PAvatar {
    text: "Alice Baker"
    size: PTheme.avatarSizeLg
}

// 自定义颜色
PAvatar {
    text: "John"
    bgColor: PTheme.colorAccent
    textColor: PTheme.colorOnAccent
}

// 图标模式
PAvatar {
    iconName: "settings"
    bgColor: PTheme.colorSuccess
    textColor: PTheme.colorOnAccent
}

// 回退模式（无参数）
PAvatar { }
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PAvatar.qml`。
