# PPagination

分页组件，支持页码导航、省略号、上一页/下一页按钮。

## 导入

```qml
import PigeonUI
```

## 属性

| 属性 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `totalPages` | int | `1` | 总页数 |
| `currentPage` | int | `1` | 当前页码 |
| `maxVisible` | int | `7` | 最多显示的页码按钮数（含省略号） |
| `accentColor` | color | `PTheme.colorAccent` | 当前页高亮色 |

## 信号

| 信号 | 说明 |
|------|------|
| `pageClicked(int page)` | 点击某页时触发，参数为页码 |

## 行为

- 总页数 ≤ `maxVisible` 时显示全部页码。
- 总页数 > `maxVisible` 时，首尾页始终显示，中间用 `…` 省略号分隔。
- 上一页/下一页按钮在边界时自动置灰。

## 状态

支持 `normal` / `hovered` 状态视觉反馈。

## 示例

```qml
// 基础用法
PPagination {
    totalPages: 10
    currentPage: 3
    onPageClicked: function(page) { currentPage = page }
}

// 大量页码 + 自定义颜色
PPagination {
    totalPages: 50
    currentPage: 25
    accentColor: PTheme.colorAccentBlue
    onPageClicked: function(page) { currentPage = page }
}
```

> 详细属性请参阅源码 `src/pigeon_ui/PigeonUI/PPagination.qml`。
