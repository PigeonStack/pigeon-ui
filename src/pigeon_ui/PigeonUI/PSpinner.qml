import QtQuick
import PigeonUI

Item {
    id: root

    // ── 公开属性 ──
    property int size: PTheme.spinnerSizeMd
    property color color: PTheme.colorAccent
    property bool running: true
    property int strokeWidth: Math.max(2, Math.round(root.size / 10))

    Accessible.role: Accessible.Indicator
    Accessible.name: qsTr("Loading")

    // ── 尺寸 ──
    implicitWidth: root.size
    implicitHeight: root.size

    visible: root.running

    Canvas {
        id: _canvas
        anchors.fill: parent
        antialiasing: true

        property real _angle: 0

        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()

            var cx = width / 2
            var cy = height / 2
            var r = (Math.min(width, height) - root.strokeWidth) / 2
            var startAngle = _canvas._angle - Math.PI / 2
            var sweepAngle = Math.PI * 0.75

            ctx.lineCap = "round"
            ctx.lineWidth = root.strokeWidth
            ctx.strokeStyle = root.color

            ctx.beginPath()
            ctx.arc(cx, cy, r, startAngle, startAngle + sweepAngle, false)
            ctx.stroke()
        }

        NumberAnimation on _angle {
            from: 0
            to: Math.PI * 2
            duration: 900
            loops: Animation.Infinite
            running: root.running && root.visible
        }

        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
        on_AngleChanged: requestPaint()

        Connections {
            target: root
            function onColorChanged() { _canvas.requestPaint() }
        }
    }
}
