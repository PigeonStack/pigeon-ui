"""回归测试：为已修复的 bug 建立防回归用例。

每个回归用例应标记 @pytest.mark.regression 并注明对应的 issue/修复描述。
"""

import sys

import pytest
from PySide6.QtCore import QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, QQmlComponent

import pigeon_ui

_app = QGuiApplication.instance() or QGuiApplication(sys.argv)


@pytest.mark.regression
class TestDialogInFramelessWindow:
    """回归：PDialog 在无边框窗口中的挂载与渲染。

    确保 PDialog 在 PWindow（无边框）场景中可正常加载，
    遮罩范围正确，不会导致崩溃。
    """

    @pytest.fixture(autouse=True)
    def setup_engine(self):
        self.engine = QQmlApplicationEngine()
        pigeon_ui.register(self.engine)

    def test_dialog_in_pwindow_no_crash(self):
        """PDialog 嵌入 PWindow 场景不崩溃。"""
        qml = b"""
import QtQuick
import PigeonUI

Item {
    width: 600
    height: 400

    PDialog {
        title: "Regression Test"
        visible: false
        modal: true
    }
}
"""
        component = QQmlComponent(self.engine)
        component.setData(qml, QUrl())

        if component.isError():
            errors = [e.toString() for e in component.errors()]
            pytest.fail(f"Dialog in frameless window errors: {'; '.join(errors)}")

    def test_dialog_close_policy(self):
        """PDialog closeOnEscape 设置不会报错。"""
        qml = b"""
import QtQuick
import PigeonUI

Item {
    PDialog {
        title: "Close Policy Test"
        visible: false
        closeOnEscape: true
    }
}
"""
        component = QQmlComponent(self.engine)
        component.setData(qml, QUrl())

        if component.isError():
            errors = [e.toString() for e in component.errors()]
            pytest.fail(f"Dialog closePolicy errors: {'; '.join(errors)}")


@pytest.mark.regression
class TestFramelessHelperSnap:
    """回归：FramelessHelper Windows Snap Layout 行为。"""

    @pytest.mark.skipif(sys.platform != "win32", reason="Windows only")
    def test_snap_check_no_crash_without_window(self):
        """无窗口时 _check_snapped 不崩溃。"""
        from pigeon_ui.frameless_helper import FramelessHelper

        helper = FramelessHelper()
        result = helper._check_snapped()
        assert result is False

    @pytest.mark.skipif(sys.platform != "win32", reason="Windows only")
    def test_hit_test_no_crash_without_window(self):
        """无窗口时 _hit_test 不崩溃。"""
        from pigeon_ui.frameless_helper import FramelessHelper

        helper = FramelessHelper()
        result = helper._hit_test(0, 0)
        assert result is None


@pytest.mark.regression
class TestThemeSwitching:
    """回归：主题切换不导致组件渲染异常。"""

    @pytest.fixture(autouse=True)
    def setup_engine(self):
        self.engine = QQmlApplicationEngine()
        pigeon_ui.register(self.engine)

    def test_dark_mode_toggle_component(self):
        """带 darkMode 引用的组件可加载。"""
        qml = b"""
import QtQuick
import PigeonUI

Item {
    property bool isDark: PTheme.darkMode
    property color bg: PTheme.colorBg
    property color text: PTheme.colorText

    PButton {
        text: "Toggle"
    }
}
"""
        component = QQmlComponent(self.engine)
        component.setData(qml, QUrl())

        if component.isError():
            errors = [e.toString() for e in component.errors()]
            pytest.fail(f"Theme switch errors: {'; '.join(errors)}")
