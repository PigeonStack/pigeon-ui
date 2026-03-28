import QtQuick
import QtQuick.Templates as T
import PigeonUI

T.TextArea {
    id: root

    // ── 公开属性 ──
    property string status: ""           // "" | "success" | "warning" | "error"

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
    Accessible.name: root.placeholderText || qsTr("Text area")
    activeFocusOnTab: root.enabled

    // ── 尺寸 ──
    implicitWidth: 220
    implicitHeight: 100
    padding: PTheme.spacingSm

    font.pixelSize: PTheme.fontSizeMd
    color: root.enabled ? PTheme.colorTextPrimary : PTheme.colorTextDisabled
    selectionColor: Qt.rgba(PTheme.colorAccent.r, PTheme.colorAccent.g, PTheme.colorAccent.b, 0.3)
    selectedTextColor: PTheme.colorTextPrimary
    wrapMode: Text.WordWrap
    hoverEnabled: true

    // ── 占位符 ──
    Text {
        text: root.placeholderText
        font: root.font
        color: PTheme.colorTextDisabled
        anchors.fill: parent
        anchors.margins: root.padding
        verticalAlignment: Text.AlignTop
        visible: !root.text && !root.activeFocus
        elide: Text.ElideRight
        wrapMode: Text.WordWrap
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
