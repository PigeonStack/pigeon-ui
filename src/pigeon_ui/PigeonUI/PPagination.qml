import QtQuick
import PigeonUI

Row {
    id: root

    // ── 公开属性 ──
    property int totalPages: 1
    property int currentPage: 1
    property int maxVisible: 7
    property color accentColor: PTheme.colorAccent

    // ── 公开信号 ──
    signal pageClicked(int page)

    Accessible.role: Accessible.PageTabList
    Accessible.name: qsTr("Page %1 of %2").arg(root.currentPage).arg(root.totalPages)

    // ── 尺寸 ──
    spacing: PTheme.spacingXs

    // ── 私有状态 ──
    QtObject {
        id: _p

        function buildPages() {
            var pages = []
            var total = root.totalPages
            var current = root.currentPage
            var maxV = root.maxVisible

            if (total <= maxV) {
                for (var i = 1; i <= total; i++) pages.push(i)
                return pages
            }

            // 始终显示首页和末页
            pages.push(1)

            var start = Math.max(2, current - Math.floor((maxV - 4) / 2))
            var end = Math.min(total - 1, start + maxV - 4)
            start = Math.max(2, end - (maxV - 4))

            if (start > 2) pages.push(-1) // 省略号
            for (var j = start; j <= end; j++) pages.push(j)
            if (end < total - 1) pages.push(-1) // 省略号

            pages.push(total)
            return pages
        }
    }

    // ── 上一页按钮 ──
    Rectangle {
        width: PTheme.paginationItemSize
        height: PTheme.paginationItemSize
        radius: PTheme.radiusSm
        color: _prevMa.containsMouse && root.currentPage > 1 ? PTheme.colorStateHover : "transparent"
        opacity: root.currentPage > 1 ? 1.0 : 0.4

        Behavior on color { ColorAnimation { duration: PTheme.animFast } }

        PIcon {
            anchors.centerIn: parent
            name: "chevron_left"
            size: PTheme.iconSizeSm
            color: PTheme.colorTextPrimary
        }

        MouseArea {
            id: _prevMa
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: root.currentPage > 1 ? Qt.PointingHandCursor : Qt.ArrowCursor
            onClicked: {
                if (root.currentPage > 1)
                    root.pageClicked(root.currentPage - 1)
            }
        }
    }

    // ── 页码 ──
    Repeater {
        model: _p.buildPages()

        Rectangle {
            required property var modelData

            width: PTheme.paginationItemSize
            height: PTheme.paginationItemSize
            radius: PTheme.radiusSm
            color: {
                if (modelData === -1) return "transparent"
                if (modelData === root.currentPage) return root.accentColor
                if (_pageMa.containsMouse) return PTheme.colorStateHover
                return "transparent"
            }

            Behavior on color { ColorAnimation { duration: PTheme.animFast } }

            Text {
                anchors.centerIn: parent
                text: modelData === -1 ? "…" : modelData
                font.pixelSize: PTheme.fontSizeSm
                font.weight: modelData === root.currentPage ? Font.DemiBold : Font.Normal
                color: {
                    if (modelData === root.currentPage) return PTheme.colorOnAccent
                    if (modelData === -1) return PTheme.colorTextDisabled
                    return PTheme.colorTextPrimary
                }
            }

            MouseArea {
                id: _pageMa
                anchors.fill: parent
                hoverEnabled: modelData !== -1
                cursorShape: modelData !== -1 ? Qt.PointingHandCursor : Qt.ArrowCursor
                onClicked: {
                    if (modelData !== -1)
                        root.pageClicked(modelData)
                }
            }
        }
    }

    // ── 下一页按钮 ──
    Rectangle {
        width: PTheme.paginationItemSize
        height: PTheme.paginationItemSize
        radius: PTheme.radiusSm
        color: _nextMa.containsMouse && root.currentPage < root.totalPages ? PTheme.colorStateHover : "transparent"
        opacity: root.currentPage < root.totalPages ? 1.0 : 0.4

        Behavior on color { ColorAnimation { duration: PTheme.animFast } }

        PIcon {
            anchors.centerIn: parent
            name: "chevron_right"
            size: PTheme.iconSizeSm
            color: PTheme.colorTextPrimary
        }

        MouseArea {
            id: _nextMa
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: root.currentPage < root.totalPages ? Qt.PointingHandCursor : Qt.ArrowCursor
            onClicked: {
                if (root.currentPage < root.totalPages)
                    root.pageClicked(root.currentPage + 1)
            }
        }
    }
}
