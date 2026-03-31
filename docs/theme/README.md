# PTheme 主题系统

## 概述

`PTheme` 是 PigeonUI 的主题单例，所有组件的颜色、字号、圆角、间距、动画时长均从此引用。

## 使用方式

QML 中直接引用：

```qml
Rectangle {
    color: PTheme.colorSurface
    radius: PTheme.radiusMd
}
```

## 主题变量分类

### 颜色
- 主色调、表面色、文字色、状态色等

### 字号
- `fontSizeXs`（10）/ `fontSizeSm`（11）/ `fontSizeMd`（13）/ `fontSizeLg`（16）/ `fontSizeXl`（20）/ `fontSizeH1`（28）

### 图标尺寸
- `iconSizeXs`（12）/ `iconSizeSm`（14）/ `iconSizeMd`（16）/ `iconSizeLg`（20）

### 控件尺寸
- `controlHeight`（36）— 标准控件高度（按钮、输入框等）
- `controlItemHeight`（32）— 下拉列表项高度
- `controlIndicatorSize`（18）— 复选框/单选按钮指示器
- `controlSwitchWidth`（44）/ `controlSwitchHeight`（24）/ `controlSwitchThumb`（18）— 开关组件
- `controlTagHeight`（24）— 标签组件高度
- `controlDotSize`（8）— 小圆点指示器
- `tabIndicatorHeight`（2）— TabBar 指示条
- `borderWidth`（1）— 标准边框宽度
- `dropdownMaxHeight`（200）— 下拉菜单最大高度

### 圆角
- `radiusSm` / `radiusMd` / `radiusLg`

### 间距
- `spacingXxs`（2）/ `spacingXs`（4）/ `spacingSm`（8）/ `spacingMd`（16）/ `spacingLg`（24）/ `spacingXl`（32）

### 动画
- `animFast`（150ms）/ `animNormal`（300ms）/ `animSlow`（500ms）
- `spinnerDuration`（900ms）— Spinner 旋转动画时长

## Dark / Light 模式

`PTheme.darkMode` 控制全局主题模式，所有响应式颜色会自动切换：

```qml
// 切换到明亮模式
PTheme.darkMode = false

// 在 PSwitch 中绑定
PSwitch {
    checked: PTheme.darkMode
    onToggled: PTheme.darkMode = !PTheme.darkMode
}
```

### 响应式颜色列表

| 变量 | Dark | Light |
|------|------|-------|
| `colorBg` | `#0f0f0f` | `#f0f2f5` |
| `colorSurface` | `#171717` | `#ffffff` |
| `colorSurfaceAlt` | `#212121` | `#e8ecf0` |
| `colorTextPrimary` | `#f2f2f2` | `#1e293b` |
| `colorTextSecondary` | `#7a7a7a` | `#64748b` |
| `colorTextDisabled` | `#4a4a4a` | `#94a3b8` |
| `colorSuccess` | `#4caf7d` | `#22c55e` |
| `colorWarning` | `#d4935a` | `#f59e0b` |
| `colorError` | `#e05454` | `#ef4444` |
| `colorInfo` | `#5b9bd5` | `#3b82f6` |
| `colorBorder` | `#2a2a2a` | `#d1d5db` |
| `colorDivider` | `#222222` | `#d1d5db` |

> 深色模式采用 Modern Black 风格（参考 Linear、Vercel），极深背景 + 低调表面 + 高对比文字，像素纲1px 级表面分层。

### 交互状态色

以下 token 在 dark/light 模式下自动调整叠加方向（白色叠加 vs 黑色叠加）：

| 变量 | 用途 | Dark | Light |
|------|------|------|-------|
| `colorStateHover` | 悬停高亮 | `rgba(255,255,255,0.06)` | `rgba(0,0,0,0.04)` |
| `colorStatePressed` | 按下反馈 | `rgba(255,255,255,0.1)` | `rgba(0,0,0,0.08)` |
| `colorStateSubtle` | 斑马纹等微弱提示 | `rgba(255,255,255,0.03)` | `rgba(0,0,0,0.02)` |
| `colorOverlay` | 弹层遮罩 | `rgba(0,0,0,0.5)` | `rgba(0,0,0,0.3)` |

### 组件专用 Token

#### Slider
| 变量 | 值 | 说明 |
|------|----|------|
| `sliderTrackHeight` | 4 | 轨道高度 |
| `sliderThumbSize` | 16 | 滑块尺寸 |
| `sliderTrackColor` | dark `#2e2e2e` / light `#d1d5db` | 轨道背景色 |
| `sliderTrackFillColor` | `colorAccent` | 轨道填充色 |

#### Avatar
| 变量 | 值 | 说明 |
|------|----|------|
| `avatarSizeSm` | 28 | 小头像 |
| `avatarSizeMd` | 36 | 中头像（默认） |
| `avatarSizeLg` | 48 | 大头像 |
| `avatarSizeXl` | 64 | 超大头像 |
| `avatarBgColor` | dark `#2a2a2a` / light `#d1d5db` | 默认背景色 |

#### Spinner
| 变量 | 值 | 说明 |
|------|----|------|
| `spinnerSizeSm` | 16 | 小 |
| `spinnerSizeMd` | 24 | 中（默认） |
| `spinnerSizeLg` | 36 | 大 |

#### Pagination
| 变量 | 值 | 说明 |
|------|----|------|
| `paginationItemSize` | 32 | 页码按钮尺寸 |

#### Breadcrumb
| 变量 | 值 | 说明 |
|------|----|------|
| `breadcrumbSeparatorColor` | dark `#4a4a4a` / light `#94a3b8` | 分隔符颜色 |

#### ScrollBar
| 变量 | 值 | 说明 |
|------|----|------|
| `scrollBarWidth` | 6 | 默认宽度 |
| `scrollBarWidthHover` | 10 | 悬停时宽度 |
| `scrollBarMinLength` | 30 | 滑块最小长度 |
| `scrollBarPadding` | 2 | 内边距 |
| `scrollBarColor` | `rgba(255,255,255,0.2)` / `rgba(0,0,0,0.25)` | 默认颜色 |
| `scrollBarHoverColor` | `rgba(255,255,255,0.35)` / `rgba(0,0,0,0.4)` | 悬停颜色 |
| `scrollBarPressedColor` | `rgba(255,255,255,0.5)` / `rgba(0,0,0,0.55)` | 按下颜色 |

## 自定义主题

PTheme 是一个 QML Singleton，可以在运行时直接修改其 non-readonly 属性。

### 方法一：运行时覆盖属性

```qml
Component.onCompleted: {
    PTheme.darkMode = false          // 切换模式
    PTheme.colorAccent = "#6366f1"   // 自定义强调色
}
```

> `colorAccent` 和 `colorAccentBlue` 是固定值，不随 darkMode 变化，可自由覆盖。

### 方法二：Fork PTheme

如需深度定制，复制 `PTheme.qml` 到项目中并修改各 readonly 绑定。确保在 `qmldir` 中重新注册：

```
singleton PTheme 1.0 MyTheme.qml
```

### 方法三：通过 Python 注入

```python
engine.rootContext().setContextProperty("themeAccent", "#6366f1")
```

```qml
Component.onCompleted: {
    PTheme.colorAccent = themeAccent
}
```

> 详细变量列表请参阅源码 `src/pigeon_ui/PigeonUI/PTheme.qml`。
