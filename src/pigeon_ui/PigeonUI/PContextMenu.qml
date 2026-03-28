import QtQuick
import PigeonUI

Item {
    id: root

    // ── 公开属性 ──
    property var model: []              // [{text, icon}] or ["text"]
    property int menuWidth: 180
    default property alias content: _container.data

    // ── 信号 ──
    signal itemClicked(int index)

    // ── 尺寸跟随内容 ──
    implicitWidth: _container.childrenRect.width
    implicitHeight: _container.childrenRect.height

    Accessible.role: Accessible.PopupMenu
    Accessible.name: qsTr("Context menu")

    Item {
        id: _container
        width: root.implicitWidth
        height: root.implicitHeight
    }

    // ── 右键区域 ──
    MouseArea {
        anchors.fill: _container
        acceptedButtons: Qt.RightButton
        onClicked: function(mouse) {
            // 将坐标转到最近的 anchors.fill parent
            var gp = mapToItem(root._menuParent, mouse.x, mouse.y)
            _popup.open(gp.x, gp.y)
        }
    }

    // ── 内部寻找挂载目标 ──
    readonly property Item _menuParent: {
        var p = root.parent
        while (p && p.parent) p = p.parent
        return p || root
    }

    // ── 菜单弹层 ──
    PMenu {
        id: _popup
        parent: root._menuParent
        model: root.model
        menuWidth: root.menuWidth
        onItemClicked: function(index) {
            root.itemClicked(index)
        }
    }
}
