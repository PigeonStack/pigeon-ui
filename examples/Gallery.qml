import QtQuick
import QtQuick.Controls
import PigeonUI

PWindow {
    id: root
    width: 800
    height: 500
    minimumWidth: 600
    minimumHeight: 400
    windowTitle: "PigeonUI Gallery"
    showSidebar: true
    navBar.model: [
        { text: "Overview", icon: "home" },
        { text: "PButton", icon: "play" },
        { text: "PNavBar", icon: "navigation" },
        { text: "PIcon", icon: "image" },
        { text: "PInput", icon: "edit" },
        { text: "PSwitch", icon: "settings" },
        { text: "PCard", icon: "document" },
        { text: "PProgress", icon: "refresh" },
        { text: "PBadge", icon: "star" },
        { text: "PTooltip", icon: "info" },
        { text: "PIconBtn", icon: "add" },
        { text: "PDialog", icon: "window" },
        { text: "PTabBar", icon: "navigation" },
        { text: "PDivider", icon: "subtract" },
        { text: "PTag", icon: "attach" },
        { text: "PCheckbox", icon: "checkmark" },
        { text: "PRadio", icon: "checkmark" },
        { text: "PTextarea", icon: "clipboard" },
        { text: "PToast", icon: "info" },
        { text: "PSnackbar", icon: "info" },
        { text: "PBanner", icon: "warning" },
        { text: "PMenu", icon: "navigation" },
        { text: "PDrawer", icon: "open" },
        { text: "PSelect", icon: "chevron_down" },
        { text: "PList", icon: "document" },
        { text: "PTable", icon: "filter" },
        { text: "PLayout", icon: "code" },
        { text: "PSlider", icon: "settings" },
        { text: "PAvatar", icon: "person" },
        { text: "PSpinner", icon: "refresh" },
        { text: "PPaginate", icon: "navigation" },
        { text: "PBread", icon: "chevron_right" },
        { text: "PScrollBar", icon: "navigation" }
    ]
    navBar.bottomModel: [
        { text: "Settings", icon: "settings" }
    ]

    pages: [
        // Overview
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingMd

            Text {
                text: "PigeonUI Gallery"
                font.pixelSize: PTheme.fontSizeH1
                color: PTheme.colorAccent
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Text {
                text: "Select a component from the left navigation."
                font.pixelSize: PTheme.fontSizeMd
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: PTheme.spacingSm

                PIcon {
                    name: "color"
                    size: PTheme.iconSizeLg
                    color: PTheme.colorTextSecondary
                    anchors.verticalCenter: parent.verticalCenter
                }
                Text {
                    text: PTheme.darkMode ? "Dark Mode" : "Light Mode"
                    font.pixelSize: PTheme.fontSizeMd
                    color: PTheme.colorTextPrimary
                    anchors.verticalCenter: parent.verticalCenter
                }
                PSwitch {
                    checked: PTheme.darkMode
                    onToggled: PTheme.darkMode = !PTheme.darkMode
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        },

        // PButton 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingMd

            Text {
                text: "PButton"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingSm
                anchors.horizontalCenter: parent.horizontalCenter
                PButton { text: "Default" }
                PButton { text: "Primary"; type: "primary" }
                PButton { text: "Outlined"; type: "outlined" }
                PButton { text: "Flat"; type: "flat" }
            }

            Row {
                spacing: PTheme.spacingSm
                anchors.horizontalCenter: parent.horizontalCenter
                PButton { text: "Blue"; type: "primary"; accentColor: PTheme.colorAccentBlue }
                PButton { text: "Success"; type: "primary"; accentColor: PTheme.colorSuccess }
                PButton { text: "Warning"; type: "outlined"; accentColor: PTheme.colorWarning }
                PButton { text: "Error"; type: "primary"; accentColor: PTheme.colorError }
            }

            Row {
                spacing: PTheme.spacingSm
                anchors.horizontalCenter: parent.horizontalCenter
                PButton { text: "Disabled"; enabled: false }
                PButton { text: "Disabled"; type: "primary"; enabled: false }
                PButton { text: "Disabled"; type: "outlined"; enabled: false }
            }
        },

        // PNavBar 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: "PNavBar"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingXl
                anchors.horizontalCenter: parent.horizontalCenter

                // 竖向 + 图标 + 可折叠
                Column {
                    spacing: PTheme.spacingSm
                    Text {
                        text: "Vertical + Icons"
                        font.pixelSize: PTheme.fontSizeSm
                        color: PTheme.colorTextSecondary
                    }
                    Rectangle {
                        width: demoVertNav.implicitWidth + PTheme.spacingXs * 2
                        height: 240
                        color: PTheme.colorSurface
                        radius: PTheme.radiusMd
                        clip: true

                        Behavior on width {
                            NumberAnimation {
                                duration: PTheme.animNormal
                                easing.type: Easing.OutCubic
                            }
                        }

                        PNavBar {
                            id: demoVertNav
                            anchors.fill: parent
                            anchors.topMargin: PTheme.spacingXs
                            anchors.leftMargin: PTheme.spacingXs
                            anchors.rightMargin: PTheme.spacingXs
                            anchors.bottomMargin: PTheme.spacingXs
                            showCollapseButton: true
                            model: [
                                { text: "Home", icon: "home" },
                                { text: "Settings", icon: "settings" },
                                { text: "Profile", icon: "person" },
                                { text: "About", icon: "info" }
                            ]
                        }
                    }
                }

                // 横向 + 图标
                Column {
                    spacing: PTheme.spacingSm
                    Text {
                        text: "Horizontal + Icons"
                        font.pixelSize: PTheme.fontSizeSm
                        color: PTheme.colorTextSecondary
                    }
                    Rectangle {
                        width: 420
                        height: 44
                        color: PTheme.colorSurface
                        radius: PTheme.radiusMd
                        PNavBar {
                            anchors.fill: parent
                            vertical: false
                            itemWidth: 100
                            model: [
                                { text: "Home", icon: "home" },
                                { text: "Explore", icon: "search" },
                                { text: "Settings", icon: "settings" },
                                { text: "About", icon: "info" },
                                { text: "About", icon: "info" },
                                { text: "About", icon: "info" },
                                { text: "About", icon: "info" },
                                { text: "About", icon: "info" }
                            ]
                        }
                    }
                }
            }
        },

        // PIcon 展示
        Flickable {
            anchors.fill: parent
            contentWidth: width
            contentHeight: iconContent.height
            clip: true

            Column {
                id: iconContent
                width: parent.width
                padding: PTheme.spacingLg
                spacing: PTheme.spacingLg

                Text {
                    text: "PIcon"
                    font.pixelSize: PTheme.fontSizeXl
                    color: PTheme.colorTextPrimary
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                // Regular 图标网格
                Text {
                    text: "Regular"
                    font.pixelSize: PTheme.fontSizeMd
                    color: PTheme.colorTextSecondary
                    leftPadding: PTheme.spacingSm
                }

                Grid {
                    columns: 8
                    spacing: PTheme.spacingXs
                    anchors.horizontalCenter: parent.horizontalCenter

                    Repeater {
                        model: [
                            "home", "search", "settings", "person",
                            "add", "close", "edit", "delete",
                            "copy", "save", "folder", "document",
                            "mail", "heart", "star", "info",
                            "eye", "eye_off", "lock_closed", "lock_open",
                            "chevron_down", "chevron_up", "chevron_left", "chevron_right",
                            "arrow_down", "arrow_up", "arrow_left", "arrow_right",
                            "checkmark", "warning", "play", "pause",
                            "stop", "refresh", "share", "link",
                            "globe", "image", "calendar", "clock",
                            "code", "filter", "attach", "clipboard",
                            "navigation", "open", "sign_out", "maximize",
                            "subtract", "square_multiple", "more_horizontal", "window",
                            "color"
                        ]

                        Column {
                            width: 64
                            spacing: PTheme.spacingXs

                            Rectangle {
                                width: 48
                                height: 48
                                radius: PTheme.radiusSm
                                color: PTheme.colorSurfaceAlt
                                anchors.horizontalCenter: parent.horizontalCenter

                                PIcon {
                                    anchors.centerIn: parent
                                    name: modelData
                                    size: 20
                                }
                            }

                            Text {
                                text: modelData
                                font.pixelSize: 9
                                color: PTheme.colorTextSecondary
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                                elide: Text.ElideRight
                            }
                        }
                    }
                }

                // Filled 图标网格
                Text {
                    text: "Filled"
                    font.pixelSize: PTheme.fontSizeMd
                    color: PTheme.colorTextSecondary
                    leftPadding: PTheme.spacingSm
                }

                Grid {
                    columns: 8
                    spacing: PTheme.spacingXs
                    anchors.horizontalCenter: parent.horizontalCenter

                    Repeater {
                        model: [
                            "home", "search", "settings", "person",
                            "heart", "star", "mail", "folder",
                            "eye", "play", "info", "warning"
                        ]

                        Column {
                            width: 64
                            spacing: PTheme.spacingXs

                            Rectangle {
                                width: 48
                                height: 48
                                radius: PTheme.radiusSm
                                color: PTheme.colorSurfaceAlt
                                anchors.horizontalCenter: parent.horizontalCenter

                                PIcon {
                                    anchors.centerIn: parent
                                    name: modelData
                                    filled: true
                                    size: 20
                                }
                            }

                            Text {
                                text: modelData
                                font.pixelSize: 9
                                color: PTheme.colorTextSecondary
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width
                                horizontalAlignment: Text.AlignHCenter
                                elide: Text.ElideRight
                            }
                        }
                    }
                }

                // 不同尺寸
                Text {
                    text: "Sizes"
                    font.pixelSize: PTheme.fontSizeMd
                    color: PTheme.colorTextSecondary
                    leftPadding: PTheme.spacingSm
                }

                Row {
                    spacing: PTheme.spacingLg
                    anchors.horizontalCenter: parent.horizontalCenter

                    Repeater {
                        model: [12, 16, 20, 24, 32, 48]

                        Column {
                            spacing: PTheme.spacingXs

                            PIcon {
                                name: "home"
                                size: modelData
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                            Text {
                                text: modelData + "px"
                                font.pixelSize: PTheme.fontSizeSm
                                color: PTheme.colorTextSecondary
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                }

                // 不同颜色
                Text {
                    text: "Colors"
                    font.pixelSize: PTheme.fontSizeMd
                    color: PTheme.colorTextSecondary
                    leftPadding: PTheme.spacingSm
                }

                Row {
                    spacing: PTheme.spacingLg
                    anchors.horizontalCenter: parent.horizontalCenter

                    PIcon { name: "star"; size: 24; color: PTheme.colorAccent }
                    PIcon { name: "heart"; size: 24; color: PTheme.colorError }
                    PIcon { name: "checkmark"; size: 24; color: PTheme.colorSuccess }
                    PIcon { name: "info"; size: 24; color: PTheme.colorAccentBlue }
                    PIcon { name: "warning"; size: 24; color: PTheme.colorWarning }
                    PIcon { name: "person"; size: 24; color: PTheme.colorTextSecondary }
                }

                Item { width: 1; height: PTheme.spacingLg }
            }
        },

        // PInput 展示
        Flickable {
            anchors.fill: parent
            contentWidth: width
            contentHeight: _inputCol.height
            clip: true

            Column {
                id: _inputCol
                width: parent.width
                padding: PTheme.spacingLg
                spacing: PTheme.spacingMd

                Text {
                    text: "PInput"
                    font.pixelSize: PTheme.fontSizeXl
                    color: PTheme.colorTextPrimary
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Basic"
                    font.pixelSize: PTheme.fontSizeSm
                    color: PTheme.colorTextSecondary
                }

                Row {
                    spacing: PTheme.spacingSm
                    PInput { placeholderText: "Default input" }
                    PInput { placeholderText: "Clearable"; clearable: true }
                }

                Text {
                    text: "With Icons"
                    font.pixelSize: PTheme.fontSizeSm
                    color: PTheme.colorTextSecondary
                }

                Row {
                    spacing: PTheme.spacingSm
                    PInput { placeholderText: "Search..."; prefixIcon: "search"; clearable: true }
                    PInput { placeholderText: "Email"; prefixIcon: "mail"; suffixIcon: "checkmark" }
                }

                Text {
                    text: "Status"
                    font.pixelSize: PTheme.fontSizeSm
                    color: PTheme.colorTextSecondary
                }

                Row {
                    spacing: PTheme.spacingSm
                    PInput { placeholderText: "Success"; status: "success"; prefixIcon: "checkmark" }
                    PInput { placeholderText: "Warning"; status: "warning"; prefixIcon: "warning" }
                    PInput { placeholderText: "Error"; status: "error"; prefixIcon: "close" }
                }

                Text {
                    text: "Disabled"
                    font.pixelSize: PTheme.fontSizeSm
                    color: PTheme.colorTextSecondary
                }

                PInput { placeholderText: "Disabled input"; enabled: false }

                Item { width: 1; height: PTheme.spacingLg }
            }
        },

        // PSwitch 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingMd

            Text {
                text: "PSwitch"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Basic"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingLg
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    spacing: PTheme.spacingXs
                    PSwitch { id: sw1; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: sw1.checked ? "On" : "Off"; font.pixelSize: PTheme.fontSizeSm; color: PTheme.colorTextSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                }

                Column {
                    spacing: PTheme.spacingXs
                    PSwitch { id: sw2; checked: true; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: sw2.checked ? "On" : "Off"; font.pixelSize: PTheme.fontSizeSm; color: PTheme.colorTextSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                }
            }

            Text {
                text: "Colors"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter
                PSwitch { checked: true }
                PSwitch { checked: true; accentColor: PTheme.colorAccentBlue }
                PSwitch { checked: true; accentColor: PTheme.colorSuccess }
                PSwitch { checked: true; accentColor: PTheme.colorError }
            }

            Text {
                text: "Disabled"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter
                PSwitch { enabled: false }
                PSwitch { checked: true; enabled: false }
            }
        },

        // PCard 展示
        Flickable {
            anchors.fill: parent
            contentWidth: width
            contentHeight: _cardCol.height
            clip: true

            Column {
                id: _cardCol
                width: parent.width
                padding: PTheme.spacingLg
                spacing: PTheme.spacingMd

                Text {
                    text: "PCard"
                    font.pixelSize: PTheme.fontSizeXl
                    color: PTheme.colorTextPrimary
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Row {
                    spacing: PTheme.spacingMd
                    anchors.horizontalCenter: parent.horizontalCenter

                    PCard {
                        title: "Simple Card"
                        subtitle: "With subtitle"
                        implicitWidth: 240

                        Text { text: "Card content goes here."; font.pixelSize: PTheme.fontSizeMd; color: PTheme.colorTextPrimary }
                    }

                    PCard {
                        title: "No Subtitle"
                        implicitWidth: 240

                        Text { text: "Content only with title."; font.pixelSize: PTheme.fontSizeMd; color: PTheme.colorTextPrimary }
                    }
                }

                PCard {
                    title: "Full Width Card"
                    subtitle: "A card that stretches to available width"
                    width: Math.min(parent.width - PTheme.spacingLg * 2, 500)
                    anchors.horizontalCenter: parent.horizontalCenter

                    Column {
                        width: parent.width
                        spacing: PTheme.spacingSm

                        Text { text: "This card demonstrates wider layouts."; font.pixelSize: PTheme.fontSizeMd; color: PTheme.colorTextPrimary }
                        Row {
                            spacing: PTheme.spacingSm
                            PButton { text: "Action"; type: "primary" }
                            PButton { text: "Cancel"; type: "flat" }
                        }
                    }
                }

                PCard {
                    title: "Interactive Card"
                    subtitle: "With switches and inputs"
                    width: Math.min(parent.width - PTheme.spacingLg * 2, 500)
                    anchors.horizontalCenter: parent.horizontalCenter

                    Column {
                        width: parent.width
                        spacing: PTheme.spacingSm

                        Row {
                            width: parent.width
                            Text { text: "Enable Feature"; font.pixelSize: PTheme.fontSizeMd; color: PTheme.colorTextPrimary; anchors.verticalCenter: parent.verticalCenter }
                            Item { width: parent.width - 160; height: 1 }
                            PSwitch { checked: true; anchors.verticalCenter: parent.verticalCenter }
                        }

                        PInput {
                            placeholderText: "Enter a value..."
                            clearable: true
                            width: parent.width
                        }
                    }
                }

                Item { width: 1; height: PTheme.spacingLg }
            }
        },

        // PProgressBar 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingMd
            width: 400

            Text {
                text: "PProgressBar"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Determinate"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PProgressBar {
                width: parent.width
                value: _progressSlider.value
            }

            Slider {
                id: _progressSlider
                width: parent.width
                from: 0; to: 1; value: 0.4
            }

            Text {
                text: "Colors"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PProgressBar {
                width: parent.width
                value: 0.7
                accentColor: PTheme.colorAccentBlue
            }
            PProgressBar {
                width: parent.width
                value: 0.5
                accentColor: PTheme.colorSuccess
            }
            PProgressBar {
                width: parent.width
                value: 0.3
                accentColor: PTheme.colorError
            }

            Text {
                text: "Indeterminate"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PProgressBar {
                width: parent.width
                indeterminate: true
            }
            PProgressBar {
                width: parent.width
                indeterminate: true
                accentColor: PTheme.colorAccentBlue
            }

            Text {
                text: "Bar Height"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PProgressBar {
                width: parent.width
                value: 0.6
                barHeight: 8
            }
        },

        // PBadge 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: "PBadge"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Number Badges"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingXl
                anchors.horizontalCenter: parent.horizontalCenter

                PBadge {
                    count: 5
                    PIcon { name: "mail"; size: 28 }
                }

                PBadge {
                    count: 25
                    PIcon { name: "heart"; size: 28 }
                }

                PBadge {
                    count: 128
                    PIcon { name: "person"; size: 28 }
                }

                PBadge {
                    count: 0
                    showZero: true
                    PIcon { name: "star"; size: 28 }
                }
            }

            Text {
                text: "Dot Mode"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingXl
                anchors.horizontalCenter: parent.horizontalCenter

                PBadge {
                    dot: true
                    count: 1
                    PIcon { name: "mail"; size: 28 }
                }

                PBadge {
                    dot: true
                    count: 1
                    badgeColor: PTheme.colorWarning
                    PIcon { name: "settings"; size: 28 }
                }

                PBadge {
                    dot: true
                    count: 1
                    badgeColor: PTheme.colorSuccess
                    PIcon { name: "checkmark"; size: 28 }
                }
            }

            Text {
                text: "On Buttons"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter

                PBadge {
                    count: 3
                    PButton { text: "Messages"; type: "primary" }
                }

                PBadge {
                    dot: true
                    count: 1
                    PButton { text: "Alerts"; type: "outlined" }
                }
            }
        },

        // PTooltip 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: "PTooltip"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Hover over the buttons below"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter

                PButton {
                    text: "Default Tooltip"
                    PTooltip {
                        text: "This is a default tooltip"
                        visible: parent.hovered
                    }
                }

                PButton {
                    text: "Quick Tooltip"
                    type: "primary"
                    PTooltip {
                        text: "Shows faster!"
                        visible: parent.hovered
                        showDelay: 200
                    }
                }

                PButton {
                    text: "Slow Tooltip"
                    type: "outlined"
                    PTooltip {
                        text: "Takes a moment to appear"
                        visible: parent.hovered
                        showDelay: 1200
                    }
                }
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter

                PButton {
                    text: "Multi-line"
                    type: "flat"
                    PTooltip {
                        text: "This tooltip has a longer text\nthat wraps across multiple lines."
                        visible: parent.hovered
                    }
                }
            }

            Text {
                text: "On Icons"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingLg
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater {
                    model: [
                        { icon: "home", tip: "Home" },
                        { icon: "search", tip: "Search" },
                        { icon: "settings", tip: "Settings" },
                        { icon: "person", tip: "Profile" }
                    ]

                    Rectangle {
                        width: 40; height: 40
                        radius: PTheme.radiusSm
                        color: _iconMa.containsMouse ? PTheme.colorSurfaceAlt : "transparent"

                        Behavior on color { ColorAnimation { duration: PTheme.animFast } }

                        PIcon {
                            name: modelData.icon
                            size: 20
                            anchors.centerIn: parent
                        }

                        MouseArea {
                            id: _iconMa
                            anchors.fill: parent
                            hoverEnabled: true
                        }

                        PTooltip {
                            text: modelData.tip
                            visible: _iconMa.containsMouse
                        }
                    }
                }
            }
        },

        // PIconButton 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: "PIconButton"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Basic"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter
                PIconButton { iconName: "home" }
                PIconButton { iconName: "search" }
                PIconButton { iconName: "settings" }
                PIconButton { iconName: "edit" }
                PIconButton { iconName: "delete" }
                PIconButton { iconName: "add" }
            }

            Text {
                text: "Colors & Sizes"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter
                PIconButton { iconName: "heart"; accentColor: PTheme.colorError; iconSize: 16; size: 28 }
                PIconButton { iconName: "star"; accentColor: PTheme.colorWarning }
                PIconButton { iconName: "checkmark"; accentColor: PTheme.colorSuccess; iconSize: 24; size: 44 }
                PIconButton { iconName: "info"; accentColor: PTheme.colorAccentBlue; iconSize: 28; size: 48 }
            }

            Text {
                text: "Non-flat (with background)"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter
                PIconButton { iconName: "home"; flatStyle: false }
                PIconButton { iconName: "search"; flatStyle: false }
                PIconButton { iconName: "settings"; flatStyle: false }
            }

            Text {
                text: "Disabled"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter
                PIconButton { iconName: "home"; enabled: false }
                PIconButton { iconName: "search"; enabled: false; flatStyle: false }
            }
        },

        // PDialog 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: "PDialog"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Click buttons below to open dialogs"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter

                PButton {
                    text: "Basic Dialog"
                    type: "primary"
                    onClicked: _dialogs.openBasic()
                }

                PButton {
                    text: "Confirm Dialog"
                    type: "outlined"
                    onClicked: _dialogs.openConfirm()
                }

                PButton {
                    text: "Alert (No Cancel)"
                    onClicked: _dialogs.openAlert()
                }

                PButton {
                    text: "Custom Width"
                    type: "flat"
                    onClicked: _dialogs.openWide()
                }
            }

            Text {
                id: _dialogResult
                font.pixelSize: PTheme.fontSizeMd
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
                text: _dialogs.resultText || "Result will appear here"
            }
        },

        // PTabBar 展示
        Column {
            anchors.fill: parent
            anchors.margins: PTheme.spacingLg
            spacing: PTheme.spacingMd

            Text {
                text: "PTabBar"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Basic"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PTabBar {
                id: _demoTabBar
                width: parent.width
                model: ["Overview", "Details", "Settings", "About"]
            }

            Rectangle {
                width: parent.width
                height: 80
                radius: PTheme.radiusSm
                color: PTheme.colorSurfaceAlt

                Text {
                    anchors.centerIn: parent
                    font.pixelSize: PTheme.fontSizeMd
                    color: PTheme.colorTextSecondary
                    text: "Tab content: " + ["Overview", "Details", "Settings", "About"][_demoTabBar.currentIndex]
                }
            }

            Text {
                text: "Colors"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PTabBar {
                width: parent.width
                model: ["Tab A", "Tab B", "Tab C"]
                accentColor: PTheme.colorAccentBlue
            }

            PTabBar {
                width: parent.width
                model: ["Success", "Warning", "Error"]
                accentColor: PTheme.colorSuccess
            }
        },

        // PDivider 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingMd
            width: 400

            Text {
                text: "PDivider"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Horizontal"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PDivider { width: parent.width }

            Row {
                spacing: PTheme.spacingMd
                width: parent.width
                Text { text: "Left"; font.pixelSize: PTheme.fontSizeMd; color: PTheme.colorTextPrimary }
                PDivider { width: 120; anchors.verticalCenter: parent.verticalCenter }
                Text { text: "Right"; font.pixelSize: PTheme.fontSizeMd; color: PTheme.colorTextPrimary }
            }

            Text {
                text: "Vertical"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            Row {
                spacing: PTheme.spacingMd
                height: 60
                anchors.horizontalCenter: parent.horizontalCenter

                Text { text: "A"; font.pixelSize: PTheme.fontSizeMd; color: PTheme.colorTextPrimary; anchors.verticalCenter: parent.verticalCenter }
                PDivider { vertical: true; height: parent.height }
                Text { text: "B"; font.pixelSize: PTheme.fontSizeMd; color: PTheme.colorTextPrimary; anchors.verticalCenter: parent.verticalCenter }
                PDivider { vertical: true; height: parent.height }
                Text { text: "C"; font.pixelSize: PTheme.fontSizeMd; color: PTheme.colorTextPrimary; anchors.verticalCenter: parent.verticalCenter }
            }

            Text {
                text: "Thickness"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PDivider { width: parent.width; thickness: 1 }
            PDivider { width: parent.width; thickness: 2 }
            PDivider { width: parent.width; thickness: 4 }
        },

        // PTag 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: "PTag"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Types"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingSm
                anchors.horizontalCenter: parent.horizontalCenter
                PTag { text: "Default" }
                PTag { text: "Primary"; type: "primary" }
                PTag { text: "Success"; type: "success" }
                PTag { text: "Warning"; type: "warning" }
                PTag { text: "Error"; type: "error" }
            }

            Text {
                text: "Closable"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingSm
                anchors.horizontalCenter: parent.horizontalCenter
                PTag { text: "Removable"; type: "primary"; closable: true }
                PTag { text: "Delete Me"; type: "error"; closable: true }
                PTag { text: "Close"; closable: true }
            }

            Text {
                text: "Custom Color"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingSm
                anchors.horizontalCenter: parent.horizontalCenter
                PTag { text: "Blue"; type: "primary"; accentColor: PTheme.colorAccentBlue }
                PTag { text: "Accent"; type: "primary"; accentColor: PTheme.colorAccent }
            }
        },

        // PCheckbox 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: "PCheckbox"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Basic"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Column {
                spacing: PTheme.spacingSm
                anchors.horizontalCenter: parent.horizontalCenter
                PCheckbox { text: "Unchecked" }
                PCheckbox { text: "Checked"; checked: true }
                PCheckbox { text: "Disabled"; enabled: false }
                PCheckbox { text: "Checked Disabled"; checked: true; enabled: false }
            }

            Text {
                text: "Colors"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Column {
                spacing: PTheme.spacingSm
                anchors.horizontalCenter: parent.horizontalCenter
                PCheckbox { text: "Accent (default)"; checked: true }
                PCheckbox { text: "Blue"; checked: true; accentColor: PTheme.colorAccentBlue }
                PCheckbox { text: "Success"; checked: true; accentColor: PTheme.colorSuccess }
                PCheckbox { text: "Error"; checked: true; accentColor: PTheme.colorError }
            }
        },

        // PRadio 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: "PRadio"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Group Selection"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            ButtonGroup { id: _radioGroup1 }

            Column {
                spacing: PTheme.spacingSm
                anchors.horizontalCenter: parent.horizontalCenter
                PRadio { text: "Option A"; checked: true; ButtonGroup.group: _radioGroup1 }
                PRadio { text: "Option B"; ButtonGroup.group: _radioGroup1 }
                PRadio { text: "Option C"; ButtonGroup.group: _radioGroup1 }
            }

            Text {
                text: "Colors"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingLg
                anchors.horizontalCenter: parent.horizontalCenter
                PRadio { text: "Default"; checked: true }
                PRadio { text: "Blue"; checked: true; accentColor: PTheme.colorAccentBlue }
                PRadio { text: "Success"; checked: true; accentColor: PTheme.colorSuccess }
            }

            Text {
                text: "Disabled"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Column {
                spacing: PTheme.spacingSm
                anchors.horizontalCenter: parent.horizontalCenter
                PRadio { text: "Disabled"; enabled: false }
                PRadio { text: "Disabled Checked"; checked: true; enabled: false }
            }
        },

        // PTextarea 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingMd
            width: 400

            Text {
                text: "PTextarea"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Basic"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PTextarea {
                width: parent.width
                placeholderText: "Enter multi-line text..."
            }

            Text {
                text: "Status"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            Row {
                spacing: PTheme.spacingSm

                PTextarea {
                    width: 190
                    implicitHeight: 80
                    placeholderText: "Success"
                    status: "success"
                }

                PTextarea {
                    width: 190
                    implicitHeight: 80
                    placeholderText: "Error"
                    status: "error"
                }
            }

            Text {
                text: "Disabled"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PTextarea {
                width: parent.width
                implicitHeight: 60
                placeholderText: "Disabled textarea"
                enabled: false
            }
        },

        // PToast 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: "PToast"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Click buttons to show toast notifications"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingSm
                anchors.horizontalCenter: parent.horizontalCenter

                PButton {
                    text: "Info"
                    type: "primary"
                    accentColor: PTheme.colorInfo
                    onClicked: _toast.show("This is an info message.", "info")
                }
                PButton {
                    text: "Success"
                    type: "primary"
                    accentColor: PTheme.colorSuccess
                    onClicked: _toast.show("Operation successful!", "success")
                }
                PButton {
                    text: "Warning"
                    type: "primary"
                    accentColor: PTheme.colorWarning
                    onClicked: _toast.show("Please check your input.", "warning")
                }
                PButton {
                    text: "Error"
                    type: "primary"
                    accentColor: PTheme.colorError
                    onClicked: _toast.show("Something went wrong!", "error")
                }
            }
        },

        // PSnackbar 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: "PSnackbar"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Click buttons to show snackbar notifications"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingSm
                anchors.horizontalCenter: parent.horizontalCenter

                PButton {
                    text: "Simple"
                    type: "primary"
                    onClicked: _snackbar.show("File saved successfully.")
                }
                PButton {
                    text: "With Action"
                    type: "outlined"
                    onClicked: _snackbar.show("Item deleted.", "UNDO")
                }
            }
        },

        // PBanner 展示
        Flickable {
            anchors.fill: parent
            contentWidth: width
            contentHeight: _bannerCol.height
            clip: true

            Column {
                id: _bannerCol
                width: parent.width
                padding: PTheme.spacingLg
                spacing: PTheme.spacingMd

                Text {
                    text: "PBanner"
                    font.pixelSize: PTheme.fontSizeXl
                    color: PTheme.colorTextPrimary
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                PBanner {
                    width: parent.width - PTheme.spacingLg * 2
                    text: "This is an informational banner."
                    type: "info"
                }

                PBanner {
                    width: parent.width - PTheme.spacingLg * 2
                    text: "Operation completed successfully!"
                    type: "success"
                }

                PBanner {
                    width: parent.width - PTheme.spacingLg * 2
                    text: "Please review your settings before proceeding."
                    type: "warning"
                }

                PBanner {
                    width: parent.width - PTheme.spacingLg * 2
                    text: "An error occurred while processing your request."
                    type: "error"
                }

                PBanner {
                    width: parent.width - PTheme.spacingLg * 2
                    text: "Non-closable banner"
                    type: "info"
                    closable: false
                }

                Item { width: 1; height: PTheme.spacingLg }
            }
        },

        // PMenu 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: "PMenu"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Click button to show menu, right-click area for context menu"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter

                PButton {
                    id: _menuTrigger
                    text: "Open Menu"
                    type: "primary"
                    onClicked: _demoMenu.open(_menuTrigger.x, _menuTrigger.y + _menuTrigger.height + PTheme.spacingXs)
                }
            }

            Text {
                id: _menuResult
                font.pixelSize: PTheme.fontSizeMd
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Click a menu item..."
            }

            Text {
                text: "Right-click area below"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            PContextMenu {
                anchors.horizontalCenter: parent.horizontalCenter
                model: [
                    { text: "Cut", icon: "copy" },
                    { text: "Copy", icon: "copy" },
                    { text: "Paste", icon: "clipboard" },
                    { text: "Delete", icon: "delete" }
                ]
                onItemClicked: function(index) {
                    _menuResult.text = "Context: " + ["Cut", "Copy", "Paste", "Delete"][index]
                }

                Rectangle {
                    width: 200
                    height: 80
                    radius: PTheme.radiusMd
                    color: PTheme.colorSurfaceAlt
                    border.width: 1
                    border.color: PTheme.colorBorder

                    Text {
                        anchors.centerIn: parent
                        text: "Right-click me"
                        font.pixelSize: PTheme.fontSizeMd
                        color: PTheme.colorTextSecondary
                    }
                }
            }

            PMenu {
                id: _demoMenu
                parent: root.contentArea || root
                model: [
                    { text: "New File", icon: "document" },
                    { text: "Open", icon: "folder" },
                    { text: "Save", icon: "save" },
                    { text: "Settings", icon: "settings" }
                ]
                onItemClicked: function(index) {
                    _menuResult.text = "Menu: " + ["New File", "Open", "Save", "Settings"][index]
                }
            }
        },

        // PDrawer 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: "PDrawer"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Click buttons to open drawers"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter

                PButton {
                    text: "Left Drawer"
                    type: "primary"
                    onClicked: _leftDrawer.open()
                }

                PButton {
                    text: "Right Drawer"
                    type: "outlined"
                    onClicked: _rightDrawer.open()
                }
            }
        },

        // PSelect 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingMd
            width: 400

            Text {
                text: "PSelect"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Basic"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PSelect {
                width: parent.width
                placeholder: "Select an option..."
                model: ["Option A", "Option B", "Option C", "Option D"]
            }

            Text {
                text: "With Default Selection"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PSelect {
                width: parent.width
                model: ["Small", "Medium", "Large", "Extra Large"]
                currentIndex: 1
                accentColor: PTheme.colorAccentBlue
            }

            Text {
                text: "Disabled"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PSelect {
                width: parent.width
                placeholder: "Disabled select"
                model: ["A", "B", "C"]
                enabled: false
            }
        },

        // PList 展示
        Flickable {
            anchors.fill: parent
            contentWidth: width
            contentHeight: _listCol.height
            clip: true

            Column {
                id: _listCol
                width: parent.width
                padding: PTheme.spacingLg
                spacing: PTheme.spacingMd

                Text {
                    text: "PList"
                    font.pixelSize: PTheme.fontSizeXl
                    color: PTheme.colorTextPrimary
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Simple Text List"
                    font.pixelSize: PTheme.fontSizeSm
                    color: PTheme.colorTextSecondary
                }

                PCard {
                    width: Math.min(parent.width - PTheme.spacingLg * 2, 400)
                    anchors.horizontalCenter: parent.horizontalCenter
                    padding: 0

                    PList {
                        width: parent.width
                        model: ["Dashboard", "Analytics", "Reports", "Settings", "Help"]
                    }
                }

                Text {
                    text: "With Icons & Subtitles"
                    font.pixelSize: PTheme.fontSizeSm
                    color: PTheme.colorTextSecondary
                }

                PCard {
                    width: Math.min(parent.width - PTheme.spacingLg * 2, 400)
                    anchors.horizontalCenter: parent.horizontalCenter
                    padding: 0

                    PList {
                        width: parent.width
                        itemHeight: 48
                        model: [
                            { text: "Inbox", icon: "mail", subtitle: "3 new messages" },
                            { text: "Starred", icon: "star", subtitle: "12 items" },
                            { text: "Drafts", icon: "edit", subtitle: "2 drafts" },
                            { text: "Trash", icon: "delete", subtitle: "Empty" }
                        ]
                    }
                }

                Item { width: 1; height: PTheme.spacingLg }
            }
        },

        // PTable 展示
        Flickable {
            anchors.fill: parent
            contentWidth: width
            contentHeight: _tableCol.height
            clip: true

            Column {
                id: _tableCol
                width: parent.width
                padding: PTheme.spacingLg
                spacing: PTheme.spacingMd

                Text {
                    text: "PTable"
                    font.pixelSize: PTheme.fontSizeXl
                    color: PTheme.colorTextPrimary
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Basic Table"
                    font.pixelSize: PTheme.fontSizeSm
                    color: PTheme.colorTextSecondary
                }

                PTable {
                    width: Math.min(parent.width - PTheme.spacingLg * 2, 500)
                    anchors.horizontalCenter: parent.horizontalCenter
                    columns: [
                        { title: "Name", width: 150 },
                        { title: "Role", width: 120 },
                        { title: "Status" }
                    ]
                    rows: [
                        ["Alice", "Developer", "Active"],
                        ["Bob", "Designer", "Active"],
                        ["Charlie", "Manager", "Away"],
                        ["Diana", "Tester", "Offline"]
                    ]
                }

                Text {
                    text: "Striped Table"
                    font.pixelSize: PTheme.fontSizeSm
                    color: PTheme.colorTextSecondary
                }

                PTable {
                    width: Math.min(parent.width - PTheme.spacingLg * 2, 500)
                    anchors.horizontalCenter: parent.horizontalCenter
                    striped: true
                    columns: [
                        { title: "ID", width: 60 },
                        { title: "Component", width: 130 },
                        { title: "Category" },
                        { title: "Status" }
                    ]
                    rows: [
                        ["1", "PButton", "Basic", "Done"],
                        ["2", "PInput", "Data Entry", "Done"],
                        ["3", "PDialog", "Overlay", "Done"],
                        ["4", "PToast", "Feedback", "Done"],
                        ["5", "PTable", "Display", "Done"]
                    ]
                }

                Item { width: 1; height: PTheme.spacingLg }
            }
        },

        // PStack / PGrid 展示
        Flickable {
            anchors.fill: parent
            contentWidth: width
            contentHeight: _layoutCol.height
            clip: true

            Column {
                id: _layoutCol
                width: parent.width
                padding: PTheme.spacingLg
                spacing: PTheme.spacingLg

                Text {
                    text: "PStack & PGrid"
                    font.pixelSize: PTheme.fontSizeXl
                    color: PTheme.colorTextPrimary
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "PStack (Column with themed spacing)"
                    font.pixelSize: PTheme.fontSizeSm
                    color: PTheme.colorTextSecondary
                }

                PCard {
                    width: Math.min(parent.width - PTheme.spacingLg * 2, 400)
                    anchors.horizontalCenter: parent.horizontalCenter

                    PStack {
                        width: parent.width

                        PButton { text: "Item 1"; type: "primary"; width: parent.width }
                        PButton { text: "Item 2"; type: "outlined"; width: parent.width }
                        PButton { text: "Item 3"; type: "flat"; width: parent.width }
                    }
                }

                Text {
                    text: "PGrid (3 columns)"
                    font.pixelSize: PTheme.fontSizeSm
                    color: PTheme.colorTextSecondary
                }

                PGrid {
                    columns: 3
                    anchors.horizontalCenter: parent.horizontalCenter

                    Repeater {
                        model: 9

                        Rectangle {
                            width: 80
                            height: 80
                            radius: PTheme.radiusMd
                            color: PTheme.colorSurfaceAlt
                            border.width: 1
                            border.color: PTheme.colorBorder

                            Text {
                                anchors.centerIn: parent
                                text: (index + 1).toString()
                                font.pixelSize: PTheme.fontSizeLg
                                color: PTheme.colorTextSecondary
                            }
                        }
                    }
                }

                Text {
                    text: "PGrid (4 columns, small spacing)"
                    font.pixelSize: PTheme.fontSizeSm
                    color: PTheme.colorTextSecondary
                }

                PGrid {
                    columns: 4
                    spacing: PTheme.spacingSm
                    anchors.horizontalCenter: parent.horizontalCenter

                    Repeater {
                        model: 8

                        PTag {
                            text: "Tag " + (index + 1)
                            type: ["default", "primary", "success", "warning", "error"][index % 5]
                        }
                    }
                }

                Item { width: 1; height: PTheme.spacingLg }
            }
        },

        // PSlider 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingMd
            width: 400

            Text {
                text: "PSlider"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Basic"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PSlider {
                id: _sliderBasic
                width: parent.width
                from: 0; to: 100; value: 40
            }
            Text {
                text: "Value: " + Math.round(_sliderBasic.value)
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            Text {
                text: "With Value Label"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PSlider {
                width: parent.width
                from: 0; to: 100; value: 60
                showValue: true
            }

            Text {
                text: "Step Size"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PSlider {
                id: _sliderStep
                width: parent.width
                from: 0; to: 100; value: 50
                stepSize: 10
                showValue: true
            }
            Text {
                text: "Step value: " + _sliderStep.value
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            Text {
                text: "Colors"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PSlider { width: parent.width; from: 0; to: 100; value: 70; accentColor: PTheme.colorAccentBlue }
            PSlider { width: parent.width; from: 0; to: 100; value: 50; accentColor: PTheme.colorSuccess }
            PSlider { width: parent.width; from: 0; to: 100; value: 30; accentColor: PTheme.colorError }

            Text {
                text: "Disabled"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PSlider { width: parent.width; from: 0; to: 100; value: 40; enabled: false }
        },

        // PAvatar 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: "PAvatar"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Sizes"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter

                PAvatar { size: PTheme.avatarSizeSm; text: "A" }
                PAvatar { size: PTheme.avatarSizeMd; text: "BC" }
                PAvatar { size: PTheme.avatarSizeLg; text: "DE" }
                PAvatar { size: PTheme.avatarSizeXl; text: "FG" }
            }

            Text {
                text: "Text Initials"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter

                PAvatar { text: "Alice Baker" }
                PAvatar { text: "John Doe"; bgColor: PTheme.colorAccent; textColor: PTheme.colorOnAccent }
                PAvatar { text: "Mary"; bgColor: PTheme.colorAccentBlue; textColor: PTheme.colorOnAccent }
            }

            Text {
                text: "Icon Mode"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter

                PAvatar { iconName: "person" }
                PAvatar { iconName: "settings"; bgColor: PTheme.colorSuccess; textColor: PTheme.colorOnAccent }
                PAvatar { iconName: "star"; bgColor: PTheme.colorWarning; textColor: PTheme.colorOnAccent }
            }

            Text {
                text: "Fallback (no props)"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingMd
                anchors.horizontalCenter: parent.horizontalCenter
                PAvatar { }
                PAvatar { size: PTheme.avatarSizeLg }
            }
        },

        // PSpinner 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: "PSpinner"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Sizes"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingXl
                anchors.horizontalCenter: parent.horizontalCenter

                Column {
                    spacing: PTheme.spacingXs
                    PSpinner { size: PTheme.spinnerSizeSm; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: "Small"; font.pixelSize: PTheme.fontSizeXs; color: PTheme.colorTextSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                }
                Column {
                    spacing: PTheme.spacingXs
                    PSpinner { size: PTheme.spinnerSizeMd; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: "Medium"; font.pixelSize: PTheme.fontSizeXs; color: PTheme.colorTextSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                }
                Column {
                    spacing: PTheme.spacingXs
                    PSpinner { size: PTheme.spinnerSizeLg; anchors.horizontalCenter: parent.horizontalCenter }
                    Text { text: "Large"; font.pixelSize: PTheme.fontSizeXs; color: PTheme.colorTextSecondary; anchors.horizontalCenter: parent.horizontalCenter }
                }
            }

            Text {
                text: "Colors"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingXl
                anchors.horizontalCenter: parent.horizontalCenter

                PSpinner { size: PTheme.spinnerSizeLg; color: PTheme.colorAccent }
                PSpinner { size: PTheme.spinnerSizeLg; color: PTheme.colorAccentBlue }
                PSpinner { size: PTheme.spinnerSizeLg; color: PTheme.colorSuccess }
                PSpinner { size: PTheme.spinnerSizeLg; color: PTheme.colorError }
            }

            Text {
                text: "With Text"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Row {
                spacing: PTheme.spacingSm
                anchors.horizontalCenter: parent.horizontalCenter
                PSpinner { size: PTheme.spinnerSizeMd; anchors.verticalCenter: parent.verticalCenter }
                Text { text: "Loading..."; font.pixelSize: PTheme.fontSizeMd; color: PTheme.colorTextSecondary; anchors.verticalCenter: parent.verticalCenter }
            }
        },

        // PPagination 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg

            Text {
                text: "PPagination"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Basic"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            PPagination {
                id: _pag1
                anchors.horizontalCenter: parent.horizontalCenter
                totalPages: 5
                currentPage: 1
                onPageClicked: function(page) { _pag1.currentPage = page }
            }

            Text {
                text: "Many Pages (with ellipsis)"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            PPagination {
                id: _pag2
                anchors.horizontalCenter: parent.horizontalCenter
                totalPages: 20
                currentPage: 8
                onPageClicked: function(page) { _pag2.currentPage = page }
            }

            Text {
                text: "Colors"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            PPagination {
                id: _pag3
                anchors.horizontalCenter: parent.horizontalCenter
                totalPages: 10
                currentPage: 3
                accentColor: PTheme.colorAccentBlue
                onPageClicked: function(page) { _pag3.currentPage = page }
            }
        },

        // PBreadcrumb 展示
        Column {
            anchors.centerIn: parent
            spacing: PTheme.spacingLg
            width: 500

            Text {
                text: "PBreadcrumb"
                font.pixelSize: PTheme.fontSizeXl
                color: PTheme.colorTextPrimary
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Text {
                text: "Basic"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PBreadcrumb {
                model: [
                    { text: "Home" },
                    { text: "Components" },
                    { text: "PBreadcrumb" }
                ]
            }

            Text {
                text: "With Icons"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PBreadcrumb {
                model: [
                    { text: "Home", icon: "home" },
                    { text: "Settings", icon: "settings" },
                    { text: "Profile", icon: "person" }
                ]
            }

            Text {
                text: "Long Path"
                font.pixelSize: PTheme.fontSizeSm
                color: PTheme.colorTextSecondary
            }

            PBreadcrumb {
                model: [
                    { text: "Root", icon: "folder" },
                    { text: "Projects", icon: "folder" },
                    { text: "PigeonUI", icon: "folder" },
                    { text: "Components" },
                    { text: "PBreadcrumb" }
                ]
            }
        },

        // PScrollBar 展示
        Flickable {
            anchors.fill: parent
            contentWidth: width
            contentHeight: _scrollCol.height
            clip: true

            ScrollBar.vertical: PScrollBar {
                parent: _scrollCol.parent.parent  // attach to Flickable
            }

            Column {
                id: _scrollCol
                width: parent.width
                padding: PTheme.spacingLg
                spacing: PTheme.spacingLg

                Text {
                    text: "PScrollBar"
                    font.pixelSize: PTheme.fontSizeXl
                    color: PTheme.colorTextPrimary
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    text: "Vertical (auto-hide, scroll this page)"
                    font.pixelSize: PTheme.fontSizeSm
                    color: PTheme.colorTextSecondary
                }

                // 长内容让滚动条可见
                Repeater {
                    model: 6

                    PCard {
                        width: Math.min(parent.width - PTheme.spacingLg * 2, 400)
                        anchors.horizontalCenter: parent.horizontalCenter
                        title: "Card " + (index + 1)
                        subtitle: "Scroll to see PScrollBar in action"

                        Column {
                            width: parent.width
                            spacing: PTheme.spacingSm

                            Text {
                                text: "This demo page intentionally has enough content to enable scrolling. The PScrollBar auto-hides when idle and expands on hover."
                                font.pixelSize: PTheme.fontSizeMd
                                color: PTheme.colorTextSecondary
                                wrapMode: Text.WordWrap
                                width: parent.width
                            }

                            PProgressBar {
                                width: parent.width
                                value: (index + 1) / 6
                            }
                        }
                    }
                }

                Text {
                    text: "Always Visible"
                    font.pixelSize: PTheme.fontSizeSm
                    color: PTheme.colorTextSecondary
                }

                Rectangle {
                    width: Math.min(parent.width - PTheme.spacingLg * 2, 400)
                    height: 160
                    anchors.horizontalCenter: parent.horizontalCenter
                    radius: PTheme.radiusMd
                    color: PTheme.colorSurfaceAlt
                    clip: true

                    Flickable {
                        id: _innerFlick
                        anchors.fill: parent
                        contentHeight: _innerCol.height
                        clip: true

                        ScrollBar.vertical: PScrollBar {
                            autoHide: false
                        }

                        Column {
                            id: _innerCol
                            width: parent.width
                            padding: PTheme.spacingSm

                            Repeater {
                                model: 15

                                Text {
                                    text: "Item " + (index + 1)
                                    font.pixelSize: PTheme.fontSizeMd
                                    color: PTheme.colorTextPrimary
                                    height: 28
                                    verticalAlignment: Text.AlignVCenter
                                    leftPadding: PTheme.spacingSm
                                }
                            }
                        }
                    }
                }

                Item { width: 1; height: PTheme.spacingLg }
            }
        },

        // Settings
        Flickable {
            anchors.fill: parent
            contentWidth: width
            contentHeight: _settingsCol.height
            clip: true

            Column {
                id: _settingsCol
                width: parent.width
                padding: PTheme.spacingLg
                spacing: PTheme.spacingMd

                Text {
                    text: "Settings"
                    font.pixelSize: PTheme.fontSizeXl
                    color: PTheme.colorTextPrimary
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                PCard {
                    title: "Appearance"
                    subtitle: "Customize look and feel"
                    width: Math.min(parent.width - PTheme.spacingLg * 2, 400)
                    anchors.horizontalCenter: parent.horizontalCenter

                    Column {
                        width: parent.width
                        spacing: PTheme.spacingSm

                        Row {
                            width: parent.width
                            Text { text: "Dark Mode"; font.pixelSize: PTheme.fontSizeMd; color: PTheme.colorTextPrimary; anchors.verticalCenter: parent.verticalCenter }
                            Item { width: parent.width - 140; height: 1 }
                            PSwitch { checked: true; anchors.verticalCenter: parent.verticalCenter }
                        }

                        Row {
                            width: parent.width
                            Text { text: "Animations"; font.pixelSize: PTheme.fontSizeMd; color: PTheme.colorTextPrimary; anchors.verticalCenter: parent.verticalCenter }
                            Item { width: parent.width - 140; height: 1 }
                            PSwitch { checked: true; anchors.verticalCenter: parent.verticalCenter }
                        }
                    }
                }

                PCard {
                    title: "Account"
                    subtitle: "Manage your profile"
                    width: Math.min(parent.width - PTheme.spacingLg * 2, 400)
                    anchors.horizontalCenter: parent.horizontalCenter

                    Column {
                        width: parent.width
                        spacing: PTheme.spacingSm

                        Text { text: "Username"; font.pixelSize: PTheme.fontSizeSm; color: PTheme.colorTextSecondary }
                        PInput {
                            placeholderText: "Enter username"
                            prefixIcon: "person"
                            clearable: true
                            width: parent.width
                        }

                        Text { text: "Email"; font.pixelSize: PTheme.fontSizeSm; color: PTheme.colorTextSecondary }
                        PInput {
                            placeholderText: "Enter email"
                            prefixIcon: "mail"
                            clearable: true
                            width: parent.width
                        }
                    }
                }

                PCard {
                    title: "Notifications"
                    width: Math.min(parent.width - PTheme.spacingLg * 2, 400)
                    anchors.horizontalCenter: parent.horizontalCenter

                    Column {
                        width: parent.width
                        spacing: PTheme.spacingSm

                        Row {
                            width: parent.width
                            Text { text: "Email Alerts"; font.pixelSize: PTheme.fontSizeMd; color: PTheme.colorTextPrimary; anchors.verticalCenter: parent.verticalCenter }
                            Item { width: parent.width - 140; height: 1 }
                            PSwitch { anchors.verticalCenter: parent.verticalCenter }
                        }
                        Row {
                            width: parent.width
                            Text { text: "Push Notifications"; font.pixelSize: PTheme.fontSizeMd; color: PTheme.colorTextPrimary; anchors.verticalCenter: parent.verticalCenter }
                            Item { width: parent.width - 140; height: 1 }
                            PSwitch { checked: true; anchors.verticalCenter: parent.verticalCenter }
                        }
                    }
                }

                Item { width: 1; height: PTheme.spacingLg }
            }
        }
    ]

    // ── 全局弹窗 ──
    GalleryDialogs {
        id: _dialogs
    }

    // ── 全局 Drawer ──
    PDrawer {
        id: _leftDrawer
        edge: Qt.LeftEdge

        Column {
            width: parent.width
            spacing: PTheme.spacingMd

            Text {
                text: "Left Drawer"
                font.pixelSize: PTheme.fontSizeLg
                font.bold: true
                color: PTheme.colorTextPrimary
            }

            PDivider { width: parent.width }

            PList {
                width: parent.width
                model: [
                    { text: "Profile", icon: "person" },
                    { text: "Settings", icon: "settings" },
                    { text: "Help", icon: "info" }
                ]
            }
        }
    }

    PDrawer {
        id: _rightDrawer
        edge: Qt.RightEdge

        Column {
            width: parent.width
            spacing: PTheme.spacingMd

            Text {
                text: "Right Drawer"
                font.pixelSize: PTheme.fontSizeLg
                font.bold: true
                color: PTheme.colorTextPrimary
            }

            PDivider { width: parent.width }

            Text {
                text: "Drawer content goes here."
                font.pixelSize: PTheme.fontSizeMd
                color: PTheme.colorTextSecondary
                wrapMode: Text.WordWrap
                width: parent.width
            }
        }
    }

    // ── 全局 Toast / Snackbar ──
    PToast {
        id: _toast
        parent: root.contentArea || root
    }

    PSnackbar {
        id: _snackbar
        parent: root.contentArea || root
    }
}
