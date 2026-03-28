import QtQuick
import PigeonUI

Rectangle {
    id: root

    // ── 公开属性 ──
    property bool vertical: false
    property int thickness: 1

    // ── 尺寸 ──
    implicitWidth: vertical ? thickness : 200
    implicitHeight: vertical ? 200 : thickness

    Accessible.role: Accessible.Separator

    // ── 外观 ──
    color: PTheme.colorDivider
}
