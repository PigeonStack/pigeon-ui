import QtQuick
import PigeonUI

Item {
    id: root

    // ── 供外部绑定结果的属性 ──
    property string resultText: ""

    // ── 公开方法 ──
    function openBasic()   { _basicDialog.open() }
    function openConfirm() { _confirmDialog.open() }
    function openAlert()   { _alertDialog.open() }
    function openWide()    { _wideDialog.open() }

    PDialog {
        id: _basicDialog
        title: "Hello"
        message: "This is a basic PDialog."
        closeOnOverlay: true
        onConfirmed: root.resultText = "Basic confirmed."
        onCancelled: root.resultText = "Basic cancelled."
    }

    PDialog {
        id: _confirmDialog
        title: "Confirm Action"
        message: "Are you sure you want to proceed? This action cannot be undone."
        confirmText: "Proceed"
        cancelText: "Go Back"
        accentColor: PTheme.colorError
        onConfirmed: root.resultText = "Confirmed!"
        onCancelled: root.resultText = "Cancelled."
    }

    PDialog {
        id: _alertDialog
        title: "Notice"
        message: "This is an alert dialog with no cancel button."
        showCancel: false
        confirmText: "Got it"
        accentColor: PTheme.colorAccentBlue
        onConfirmed: root.resultText = "Alert acknowledged."
    }

    PDialog {
        id: _wideDialog
        title: "Custom Width Dialog"
        message: "This dialog uses dialogWidth: 480 to demonstrate the new API."
        dialogWidth: 480
        closeOnOverlay: true

        body: [
            PProgressBar {
                width: parent.width
                value: 0.65
                accentColor: PTheme.colorSuccess
            }
        ]
    }
}
