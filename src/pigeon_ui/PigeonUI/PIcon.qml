import QtQuick
import PigeonUI

Item {
    id: root

    // ── 公开属性 ──
    property string name: ""
    property bool filled: false
    property int size: PTheme.iconSizeLg
    property color color: PTheme.colorTextPrimary
    property url source: ""          // 自定义图片图标（SVG / PNG）

    implicitWidth: root.size
    implicitHeight: root.size

    Accessible.role: Accessible.Graphic
    Accessible.name: root.name

    // ── 字体加载 ──
    FontLoader { id: _regularFont; source: "fonts/FluentSystemIcons-Regular.ttf" }
    FontLoader { id: _filledFont; source: "fonts/FluentSystemIcons-Filled.ttf" }

    // ── 字体图标（name 模式）──
    Text {
        id: _glyph
        visible: root.source.toString() === "" && root.name !== ""
        anchors.fill: parent
        font.family: root.filled ? _filledFont.name : _regularFont.name
        font.pixelSize: root.size
        color: root.color
        text: _resolve(root.name, root.filled)
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    // ── 图片图标（source 模式）──
    Image {
        id: _img
        visible: root.source.toString() !== ""
        anchors.centerIn: parent
        width: root.size
        height: root.size
        source: root.source
        sourceSize: Qt.size(root.size, root.size)
        fillMode: Image.PreserveAspectFit
    }

    // ── 图标名 → Unicode 字符 ──
    function _resolve(iconName, isFilled) {
        if (!iconName) return ""
        var cp = isFilled ? _filled[iconName] : _regular[iconName]
        return cp !== undefined ? String.fromCodePoint(cp) : ""
    }

    // ── Regular codepoint 映射 ──
    readonly property var _regular: ({
        "add":              0xf109,
        "arrow_down":       0xf148,
        "arrow_left":       0xf15b,
        "arrow_right":      0xf181,
        "arrow_up":         0xf19b,
        "attach":           0xf1a9,
        "calendar":         0xf0284,
        "checkmark":        0xf294,
        "chevron_down":     0xf2a3,
        "chevron_left":     0xf2aa,
        "chevron_right":    0xf2b0,
        "chevron_up":       0xf2b6,
        "clipboard":        0xf2c9,
        "clock":            0xf2dd,
        "close":            0xf369,
        "code":             0xf2ef,
        "color":            0xf2f5,
        "copy":             0xf32b,
        "delete":           0xf34c,
        "document":         0xf378,
        "edit":             0xf3dd,
        "eye":              0xe5f2,
        "eye_off":          0xe5f5,
        "filter":           0xf406,
        "folder":           0xf418,
        "globe":            0xf45a,
        "heart":            0xf479,
        "home":             0xf480,
        "image":            0xf488,
        "info":             0xf4a3,
        "link":             0xf4e4,
        "lock_closed":      0xe78f,
        "lock_open":        0xe795,
        "mail":             0xf506,
        "maximize":         0xe7eb,
        "more_horizontal":  0xe825,
        "navigation":       0xf561,
        "open":             0xf582,
        "pause":            0xf5a1,
        "person":           0xf5bd,
        "play":             0xf605,
        "refresh":          0xf13d,
        "save":             0xf67f,
        "search":           0xf68f,
        "settings":         0xf6a9,
        "share":            0xf6af,
        "sign_out":         0xeafa,
        "square_multiple":  0xeb96,
        "star":             0xf70f,
        "stop":             0xf72a,
        "subtract":         0xebd0,
        "warning":          0xf869,
        "window":           0xf8b5
    })

    // ── Filled codepoint 映射 ──
    readonly property var _filled: ({
        "add":              0xf109,
        "arrow_down":       0xf148,
        "arrow_left":       0xf15b,
        "arrow_right":      0xf181,
        "arrow_up":         0xf19b,
        "attach":           0xf1a9,
        "calendar":         0xf0297,
        "checkmark":        0xf294,
        "chevron_down":     0xf2a3,
        "chevron_left":     0xf2aa,
        "chevron_right":    0xf2b0,
        "chevron_up":       0xf2b6,
        "clipboard":        0xf2c9,
        "clock":            0xf2dd,
        "close":            0xf369,
        "code":             0xf2ef,
        "color":            0xf2f5,
        "copy":             0xf32b,
        "delete":           0xf34c,
        "document":         0xf378,
        "edit":             0xf3dc,
        "eye":              0xe5ff,
        "eye_off":          0xe602,
        "filter":           0xf405,
        "folder":           0xf41c,
        "globe":            0xf45e,
        "heart":            0xf47d,
        "home":             0xf487,
        "image":            0xf48f,
        "info":             0xf4aa,
        "link":             0xf4ee,
        "lock_closed":      0xe79d,
        "lock_open":        0xe7a3,
        "mail":             0xf510,
        "maximize":         0xe7f9,
        "more_horizontal":  0xe832,
        "navigation":       0xf561,
        "open":             0xf58c,
        "pause":            0xf5ab,
        "person":           0xf5c7,
        "play":             0xf60f,
        "refresh":          0xf13d,
        "save":             0xf689,
        "search":           0xf699,
        "settings":         0xf6b2,
        "share":            0xf6b8,
        "sign_out":         0xeb03,
        "square_multiple":  0xeb9f,
        "star":             0xf718,
        "stop":             0xf742,
        "subtract":         0xebca,
        "warning":          0xf881,
        "window":           0xf8cd
    })
}
