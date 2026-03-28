import QtQuick
import QtQuick.Templates as T
import PigeonUI

T.TextField {
    id: root

    // ── 公开属性 ──
    property bool clearable: false
    property string status: ""           // "" | "success" | "warning" | "error"
    property string prefixIcon: ""
    property string suffixIcon: ""

    // ── 内部状态 ──
    QtObject {
        id: _p
        property color borderColor: {
            if (!root.enabled) return PTheme.colorBorder
            if (root.status === "error")   return PTheme.colorError
            if (root.status === "warning") return PTheme.colorWarning
            if (root.status === "success") return PTheme.colorSuccess
            if (root.activeFocus) return PTheme.colorAccent
            if (root.hovered)    return PTheme.colorTextSecondary
            return PTheme.colorBorder
        }
    }

    Accessible.role: Accessible.EditableText
    Accessible.name: root.placeholderText || qsTr("Input")
    activeFocusOnTab: root.enabled

    // ── 尺寸 ──
    implicitWidth: 220
    implicitHeight: PTheme.controlHeight
    leftPadding: root.prefixIcon !== ""
        ? PTheme.spacingSm + PTheme.iconSizeLg + PTheme.spacingSm
        : PTheme.spacingSm
    rightPadding: {
        var p = PTheme.spacingSm
        if (root.clearable && root.text.length > 0) p += PTheme.iconSizeLg + PTheme.spacingXs
        if (root.suffixIcon !== "") p += PTheme.iconSizeLg + PTheme.spacingXs
        return p
    }
    topPadding: 0
    bottomPadding: 0

    font.pixelSize: PTheme.fontSizeMd
    color: root.enabled ? PTheme.colorTextPrimary : PTheme.colorTextDisabled
    selectionColor: Qt.rgba(PTheme.colorAccent.r, PTheme.colorAccent.g, PTheme.colorAccent.b, 0.3)
    selectedTextColor: PTheme.colorTextPrimary
    verticalAlignment: Text.AlignVCenter
    hoverEnabled: true

    // ── 占位符 ──
    Text {
        text: root.placeholderText
        font: root.font
        color: PTheme.colorTextDisabled
        anchors.fill: parent
        anchors.leftMargin: root.leftPadding
        anchors.rightMargin: root.rightPadding
        verticalAlignment: Text.AlignVCenter
        visible: !root.text && !root.activeFocus
        elide: Text.ElideRight
    }

    // ── 前缀图标 ──
    PIcon {
        visible: root.prefixIcon !== ""
        name: root.prefixIcon
        size: PTheme.iconSizeMd
        color: PTheme.colorTextSecondary
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: PTheme.spacingSm
    }

    // ── 后缀图标 ──
    PIcon {
        visible: root.suffixIcon !== ""
        name: root.suffixIcon
        size: PTheme.iconSizeMd
        color: PTheme.colorTextSecondary
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: _clearBtn.visible ? _clearBtn.left : parent.right
        anchors.rightMargin: PTheme.spacingSm
    }

    // ── 清除按钮 ──
    T.Button {
        id: _clearBtn
        visible: root.clearable && root.text.length > 0
        width: PTheme.iconSizeLg
        height: PTheme.iconSizeLg
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: PTheme.spacingSm
        onClicked: { root.clear(); root.forceActiveFocus() }

        contentItem: PIcon {
            name: "close"
            size: PTheme.iconSizeSm
            color: _clearBtn.hovered
                ? PTheme.colorTextPrimary
                : PTheme.colorTextSecondary

            Behavior on color {
                ColorAnimation { duration: PTheme.animFast }
            }
        }

        background: Rectangle {
            radius: PTheme.radiusSm
            color: _clearBtn.hovered ? PTheme.colorStatePressed : "transparent"

            Behavior on color {
                ColorAnimation { duration: PTheme.animFast }
            }
        }

        HoverHandler {
            cursorShape: Qt.PointingHandCursor
        }
    }

    // ── 背景 ──
    background: Rectangle {
        radius: PTheme.radiusSm
        color: root.enabled ? PTheme.colorSurfaceAlt : Qt.darker(PTheme.colorSurfaceAlt, 1.2)
        border.width: PTheme.borderWidth
        border.color: _p.borderColor

        Behavior on border.color {
            ColorAnimation { duration: PTheme.animFast }
        }
    }
}
