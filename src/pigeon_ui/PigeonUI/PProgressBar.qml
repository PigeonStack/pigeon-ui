import QtQuick
import PigeonUI

Item {
    id: root

    // ── 公开属性 ──
    property real value: 0.0             // 0.0 ~ 1.0
    property bool indeterminate: false
    property color accentColor: PTheme.colorAccent
    property int barHeight: PTheme.progressBarHeight
    property int sweepDuration: 1200     // 不确定模式往返时长 ms

    // ── 尺寸 ──
    implicitWidth: PTheme.progressBarWidth
    implicitHeight: barHeight

    Accessible.role: Accessible.ProgressBar
    Accessible.name: root.indeterminate ? qsTr("Loading") : (Math.round(root.value * 100) + "%")

    // ── 轨道 ──
    Rectangle {
        id: _track
        anchors.fill: parent
        radius: root.barHeight / 2
        color: PTheme.colorSurfaceAlt
    }

    // ── 确定模式填充 ──
    Rectangle {
        id: _fill
        visible: !root.indeterminate
        height: parent.height
        radius: _track.radius
        color: root.accentColor
        width: parent.width * Math.max(0, Math.min(1, root.value))

        Behavior on width {
            NumberAnimation { duration: PTheme.animNormal; easing.type: Easing.OutCubic }
        }
    }

    // ── 不确定模式滑块 ──
    Rectangle {
        id: _slider
        visible: root.indeterminate
        height: parent.height
        radius: _track.radius
        color: root.accentColor
        width: parent.width * PTheme.progressSweepRatio

        SequentialAnimation on x {
            running: root.indeterminate && root.visible
            loops: Animation.Infinite
            NumberAnimation {
                from: -_slider.width
                to: root.width
                duration: root.sweepDuration
                easing.type: Easing.InOutQuad
            }
            PauseAnimation { duration: PTheme.animFast }
        }
    }

    // ── 裁剪溢出 ──
    clip: true
}
