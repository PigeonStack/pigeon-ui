import QtQuick
import PigeonUI

Grid {
    id: root

    Accessible.role: Accessible.Pane

    // ── 公开属性 ──
    columns: 3
    spacing: PTheme.spacingMd
}
