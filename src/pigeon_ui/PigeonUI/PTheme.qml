pragma Singleton
import QtQuick

QtObject {
    property bool darkMode: true

    // ── 主色调 ──
    readonly property color colorBg:          darkMode ? "#0f0f0f" : "#f0f2f5"
    readonly property color colorSurface:     darkMode ? "#171717" : "#ffffff"
    readonly property color colorSurfaceAlt:  darkMode ? "#212121" : "#e8ecf0"
    readonly property color colorAccent:      '#08927b'
    readonly property color colorAccentBlue:  "#5b9bd5"

    // ── 文字 ──
    readonly property color colorTextPrimary:   darkMode ? "#f2f2f2" : "#1e293b"
    readonly property color colorTextSecondary: darkMode ? "#7a7a7a" : "#64748b"
    readonly property color colorTextDisabled:  darkMode ? "#4a4a4a" : "#94a3b8"

    // ── 状态色 ──
    readonly property color colorSuccess:  darkMode ? "#4caf7d" : "#22c55e"
    readonly property color colorWarning:  darkMode ? "#d4935a" : "#f59e0b"
    readonly property color colorError:    darkMode ? "#e05454" : "#ef4444"
    readonly property color colorInfo:     darkMode ? "#5b9bd5" : "#3b82f6"

    // ── 边框与分割线 ──
    readonly property color colorBorder:   darkMode ? "#2a2a2a" : "#d1d5db"
    readonly property color colorDivider:  darkMode ? "#222222" : "#d1d5db"

    // ── 圆角 ──
    readonly property int radiusSm:  4
    readonly property int radiusMd:  8
    readonly property int radiusLg:  12
    readonly property int radiusXl:  16

    // ── 字体 ──
    readonly property int fontSizeXs:  10
    readonly property int fontSizeSm:  11
    readonly property int fontSizeMd:  13
    readonly property int fontSizeLg:  16
    readonly property int fontSizeXl:  20
    readonly property int fontSizeH1:  28

    // ── 图标尺寸 ──
    readonly property int iconSizeXs:  12
    readonly property int iconSizeSm:  14
    readonly property int iconSizeMd:  16
    readonly property int iconSizeLg:  20

    // ── 控件尺寸 ──
    readonly property int controlHeight:         36
    readonly property int controlItemHeight:     32
    readonly property int controlIndicatorSize:  18
    readonly property int controlSwitchWidth:    44
    readonly property int controlSwitchHeight:   24
    readonly property int controlSwitchThumb:    18
    readonly property int controlTagHeight:      24
    readonly property int controlDotSize:         8
    readonly property int controlRadioInnerGap:   4  // (indicatorSize - innerDot) / 2
    readonly property int tabIndicatorHeight:     2
    readonly property int borderWidth:            1
    readonly property int borderWidthThick:       3
    readonly property int dropdownMaxHeight:    200

    // ── 导航栏 ──
    readonly property int navCollapsedWidth:   48
    readonly property int navExpandedWidth:   120
    readonly property int navItemHeight:       40

    // ── 进度条 ──
    readonly property int progressBarWidth:   200
    readonly property int progressBarHeight:    4
    readonly property real progressSweepRatio: 0.35

    // ── 颜色（固定白色，跨主题不变）──
    readonly property color colorOnAccent: "#ffffff"

    // ── 动画时长（ms）──
    readonly property int animFast:   150
    readonly property int animNormal: 300
    readonly property int animSlow:   500

    // ── 交互状态 ──
    readonly property color colorStateHover:   darkMode ? Qt.rgba(1, 1, 1, 0.06) : Qt.rgba(0, 0, 0, 0.04)
    readonly property color colorStatePressed: darkMode ? Qt.rgba(1, 1, 1, 0.1)  : Qt.rgba(0, 0, 0, 0.08)
    readonly property color colorStateSubtle:  darkMode ? Qt.rgba(1, 1, 1, 0.03) : Qt.rgba(0, 0, 0, 0.02)
    readonly property color colorOverlay:      darkMode ? Qt.rgba(0, 0, 0, 0.5)  : Qt.rgba(0, 0, 0, 0.3)
    readonly property color colorFocusRing:    darkMode ? Qt.rgba(colorAccent.r, colorAccent.g, colorAccent.b, 0.6)
                                                        : Qt.rgba(colorAccent.r, colorAccent.g, colorAccent.b, 0.5)

    // ── 间距 ──
    readonly property int spacingXxs: 2
    readonly property int spacingXs:  4
    readonly property int spacingSm:  8
    readonly property int spacingMd:  16
    readonly property int spacingLg:  24
    readonly property int spacingXl:  32

    // ── 窗口 ──
    readonly property int windowTitleBarHeight: 36
    readonly property int windowShadowRadius:   16
    readonly property int windowResizeEdge:      5
    readonly property color windowShadowColor: darkMode ? "#80000000" : "#30000000"

    // ── Slider ──
    readonly property int sliderTrackHeight:  4
    readonly property int sliderThumbSize:   16
    readonly property color sliderTrackColor:     darkMode ? "#2e2e2e" : "#d1d5db"
    readonly property color sliderTrackFillColor: colorAccent

    // ── Avatar ──
    readonly property int avatarSizeSm:  28
    readonly property int avatarSizeMd:  36
    readonly property int avatarSizeLg:  48
    readonly property int avatarSizeXl:  64
    readonly property color avatarBgColor: darkMode ? "#2a2a2a" : "#d1d5db"

    // ── Spinner ──
    readonly property int spinnerSizeSm:  16
    readonly property int spinnerSizeMd:  24
    readonly property int spinnerSizeLg:  36
    readonly property int spinnerDuration: 900

    // ── Pagination ──
    readonly property int paginationItemSize:  32

    // ── Breadcrumb ──
    readonly property color breadcrumbSeparatorColor: darkMode ? "#4a4a4a" : "#94a3b8"

    // ── ScrollBar ──
    readonly property int scrollBarWidth:        6
    readonly property int scrollBarWidthHover:  10
    readonly property int scrollBarMinLength:   30
    readonly property int scrollBarPadding:      2
    readonly property color scrollBarColor:        darkMode ? Qt.rgba(1, 1, 1, 0.15) : Qt.rgba(0, 0, 0, 0.15)
    readonly property color scrollBarHoverColor:   darkMode ? Qt.rgba(1, 1, 1, 0.30) : Qt.rgba(0, 0, 0, 0.30)
    readonly property color scrollBarPressedColor: darkMode ? Qt.rgba(1, 1, 1, 0.45) : Qt.rgba(0, 0, 0, 0.40)
}
