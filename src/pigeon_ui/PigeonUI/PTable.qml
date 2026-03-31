import QtQuick
import PigeonUI

Item {
    id: root

    // ── 公开属性 ──
    property var columns: []            // [{title, width}]  width 可选
    property var rows: []               // [[cell1, cell2, ...], ...]
    property int rowHeight: PTheme.controlHeight
    property int headerHeight: PTheme.controlHeight
    property bool showBorder: true
    property bool striped: false

    // ── 信号 ──
    signal cellClicked(int row, int col)

    Accessible.role: Accessible.Table
    Accessible.name: qsTr("Table")

    // ── 内部计算 ──
    QtObject {
        id: _p

        function colWidth(colIndex) {
            if (colIndex < root.columns.length) {
                var c = root.columns[colIndex]
                if (c && c.width !== undefined) return c.width
            }
            // 均分
            return root.width / Math.max(1, root.columns.length)
        }

        function colTitle(colIndex) {
            if (colIndex < root.columns.length) {
                var c = root.columns[colIndex]
                if (typeof c === "string") return c
                if (c && c.title !== undefined) return c.title
                return ""
            }
            return ""
        }
    }

    // ── 尺寸 ──
    implicitWidth: 400
    implicitHeight: headerHeight + rows.length * rowHeight

    // ── 外框 ──
    Rectangle {
        anchors.fill: parent
        radius: PTheme.radiusMd
        color: "transparent"
        border.width: root.showBorder ? 1 : 0
        border.color: PTheme.colorBorder
        clip: true

        // ── 表头 ──
        Row {
            id: _header
            width: parent.width
            height: root.headerHeight

            Repeater {
                model: root.columns.length

                Rectangle {
                    required property int index
                    width: _p.colWidth(index)
                    height: root.headerHeight
                    color: PTheme.colorSurfaceAlt

                    // 右侧分割线
                    Rectangle {
                        anchors.right: parent.right
                        width: PTheme.borderWidth
                        height: parent.height
                        color: PTheme.colorDivider
                        visible: index < root.columns.length - 1
                    }

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: PTheme.spacingSm
                        text: _p.colTitle(index)
                        font.pixelSize: PTheme.fontSizeSm
                        font.bold: true
                        color: PTheme.colorTextSecondary
                    }
                }
            }
        }

        // ── 表头下方分割线 ──
        Rectangle {
            anchors.top: _header.bottom
            width: parent.width
            height: PTheme.borderWidth
            color: PTheme.colorBorder
        }

        // ── 数据行 ──
        Flickable {
            anchors.top: _header.bottom
            anchors.topMargin: PTheme.borderWidth
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            contentHeight: _rowsCol.height
            clip: true

            Column {
                id: _rowsCol
                width: parent.width

                Repeater {
                    model: root.rows.length

                    Item {
                        id: _rowDelegate
                        required property int index

                        width: _rowsCol.width
                        height: root.rowHeight

                        Rectangle {
                            anchors.fill: parent
                            color: {
                                if (_rowMa.containsMouse) return PTheme.colorStateHover
                                if (root.striped && _rowDelegate.index % 2 === 1) return PTheme.colorStateSubtle
                                return "transparent"
                            }

                            Behavior on color {
                                ColorAnimation { duration: PTheme.animFast }
                            }
                        }

                        Row {
                            anchors.fill: parent

                            Repeater {
                                model: root.columns.length

                                Item {
                                    required property int index

                                    // 注意：此处 index 是列索引
                                    property int colIdx: index
                                    property int rowIdx: _rowDelegate.index

                                    width: _p.colWidth(colIdx)
                                    height: root.rowHeight

                                    Text {
                                        anchors.verticalCenter: parent.verticalCenter
                                        anchors.left: parent.left
                                        anchors.leftMargin: PTheme.spacingSm
                                        anchors.right: parent.right
                                        anchors.rightMargin: PTheme.spacingSm
                                        text: {
                                            var row = root.rows[rowIdx]
                                            if (row && colIdx < row.length) return row[colIdx]
                                            return ""
                                        }
                                        font.pixelSize: PTheme.fontSizeMd
                                        color: PTheme.colorTextPrimary
                                        elide: Text.ElideRight
                                    }
                                }
                            }
                        }

                        // ── 行分割线 ──
                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width
                            height: PTheme.borderWidth
                            color: PTheme.colorDivider
                            visible: _rowDelegate.index < root.rows.length - 1
                        }

                        MouseArea {
                            id: _rowMa
                            anchors.fill: parent
                            hoverEnabled: true
                        }
                    }
                }
            }
        }
    }
}
