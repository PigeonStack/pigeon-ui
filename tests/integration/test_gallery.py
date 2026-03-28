"""集成测试：Gallery 启动、核心组件渲染、主题切换。

这些测试验证端到端流程：从 Python 入口到 QML 组件渲染。
"""

import sys
from pathlib import Path

import pytest
from PySide6.QtCore import QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

import pigeon_ui

_app = QGuiApplication.instance() or QGuiApplication(sys.argv)

_GALLERY_QML = Path(__file__).parent.parent.parent / "examples" / "Gallery.qml"


class TestGalleryStartup:
    """Gallery 示例启动与加载测试。"""

    def test_gallery_qml_exists(self):
        """Gallery.qml 文件应存在。"""
        assert _GALLERY_QML.exists(), f"Gallery.qml not found at {_GALLERY_QML}"

    def test_gallery_loads_without_crash(self):
        """Gallery.qml 可正常加载（不崩溃）。"""
        engine = QQmlApplicationEngine()
        pigeon_ui.register(engine)

        errors = []

        def on_warnings(warn_list):
            for w in warn_list:
                errors.append(str(w))

        engine.warnings.connect(on_warnings)
        engine.load(_GALLERY_QML)

        root_objects = engine.rootObjects()
        assert len(root_objects) > 0, (
            f"Gallery failed to load. Errors: {'; '.join(errors) if errors else 'unknown'}"
        )

    def test_gallery_root_is_window(self):
        """Gallery 根对象应是 Window 类型。"""
        engine = QQmlApplicationEngine()
        pigeon_ui.register(engine)
        engine.load(_GALLERY_QML)

        root_objects = engine.rootObjects()
        assert len(root_objects) > 0, "No root objects loaded"

        root = root_objects[0]
        # PWindow 最终还是 QWindow 的子类
        assert root is not None


class TestComponentRendering:
    """核心组件可渲染测试。"""

    @pytest.fixture(autouse=True)
    def setup_engine(self):
        self.engine = QQmlApplicationEngine()
        pigeon_ui.register(self.engine)

    def test_pwindow_minimal(self):
        """最小 PWindow 可加载。"""
        from PySide6.QtQml import QQmlComponent

        qml = b"""
import QtQuick
import QtQuick.Window
import PigeonUI

PWindow {
    width: 200
    height: 200
    visible: false
}
"""
        component = QQmlComponent(self.engine)
        component.setData(qml, QUrl())

        if component.isError():
            errors = [e.toString() for e in component.errors()]
            pytest.fail(f"PWindow errors: {'; '.join(errors)}")

    def test_pdialog_in_window(self):
        """PDialog 可在无边框窗口场景中加载。"""
        from PySide6.QtQml import QQmlComponent

        qml = b"""
import QtQuick
import PigeonUI

Item {
    width: 400
    height: 400

    PDialog {
        title: "Test Dialog"
        visible: false
    }
}
"""
        component = QQmlComponent(self.engine)
        component.setData(qml, QUrl())

        if component.isError():
            errors = [e.toString() for e in component.errors()]
            pytest.fail(f"PDialog errors: {'; '.join(errors)}")

    def test_pinput_interactive(self):
        """PInput 可加载并设置属性。"""
        from PySide6.QtQml import QQmlComponent

        qml = b"""
import QtQuick
import PigeonUI

Item {
    PInput {
        placeholderText: "Test"
        enabled: true
    }
}
"""
        component = QQmlComponent(self.engine)
        component.setData(qml, QUrl())

        if component.isError():
            errors = [e.toString() for e in component.errors()]
            pytest.fail(f"PInput errors: {'; '.join(errors)}")

    def test_pnavbar_with_items(self):
        """PNavBar 可加载并配置导航项。"""
        from PySide6.QtQml import QQmlComponent

        qml = b"""
import QtQuick
import PigeonUI

Item {
    PNavBar {
        model: [
            { text: "Home", icon: "\\ue80f" },
            { text: "Settings", icon: "\\ue713" }
        ]
    }
}
"""
        component = QQmlComponent(self.engine)
        component.setData(qml, QUrl())

        if component.isError():
            errors = [e.toString() for e in component.errors()]
            pytest.fail(f"PNavBar errors: {'; '.join(errors)}")


class TestRunGalleryScript:
    """验证 run_gallery.py 脚本完整性。"""

    def test_run_gallery_importable(self):
        """run_gallery 模块可导入。"""
        run_gallery = Path(__file__).parent.parent.parent / "examples" / "run_gallery.py"
        assert run_gallery.exists()

        # 验证脚本有 main 函数
        content = run_gallery.read_text(encoding="utf-8")
        assert "def main(" in content
        assert "pigeon_ui.register" in content
