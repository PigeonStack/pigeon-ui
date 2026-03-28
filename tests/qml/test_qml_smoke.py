"""QML 层冒烟测试：通过最小 App 加载核心组件验证 QML 语法和基础渲染。"""

import sys
from pathlib import Path

import pytest
from PySide6.QtCore import QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, QQmlComponent

import pigeon_ui

_app = QGuiApplication.instance() or QGuiApplication(sys.argv)

# PigeonUI 组件目录
_PIGEON_UI_DIR = Path(pigeon_ui.__file__).parent / "PigeonUI"


# 从 qmldir 中解析所有已注册组件名
def _get_registered_components() -> list[str]:
    """从 qmldir 读取所有注册的组件名。"""
    qmldir = _PIGEON_UI_DIR / "qmldir"
    components = []
    for line in qmldir.read_text(encoding="utf-8").splitlines():
        parts = line.strip().split()
        if not parts or parts[0] in ("module", "#"):
            continue
        if parts[0] == "singleton":
            # singleton ComponentName version File.qml
            if len(parts) >= 4:
                components.append(parts[1])
        elif len(parts) >= 3 and parts[-1].endswith(".qml"):
            # ComponentName version File.qml
            components.append(parts[0])
    return components


# 不需要额外参数就能实例化的基础组件
_SIMPLE_COMPONENTS = [
    "PButton",
    "PIconButton",
    "PBadge",
    "PTag",
    "PCard",
    "PDivider",
    "PInput",
    "PSwitch",
    "PCheckbox",
    "PRadio",
    "PTextarea",
    "PSlider",
    "PProgressBar",
    "PSpinner",
    "PAvatar",
    "PBanner",
    "PTooltip",
    "PBreadcrumb",
    "PStack",
    "PGrid",
]


def _create_engine() -> QQmlApplicationEngine:
    engine = QQmlApplicationEngine()
    pigeon_ui.register(engine)
    return engine


class TestQmlComponentSyntax:
    """验证每个 QML 组件文件语法无错误。"""

    @pytest.fixture(autouse=True)
    def setup_engine(self):
        self.engine = _create_engine()

    @pytest.mark.parametrize("component_name", _SIMPLE_COMPONENTS)
    def test_component_loads_without_error(self, component_name: str):
        """组件可通过 QQmlComponent 加载且无错误。"""
        qml_code = f"""
import QtQuick
import PigeonUI

{component_name} {{
}}
"""
        component = QQmlComponent(self.engine)
        component.setData(qml_code.encode(), QUrl())

        if component.isError():
            errors = [e.toString() for e in component.errors()]
            pytest.fail(f"{component_name} load errors: {'; '.join(errors)}")

        assert component.isReady() or component.isLoading(), (
            f"{component_name} status: {component.status()}"
        )


class TestQmlRegistration:
    """验证 QML 模块注册完整性。"""

    def test_all_components_registered(self):
        """所有 P*.qml 文件应在 qmldir 中注册。"""
        registered = set(_get_registered_components())
        qml_files = {p.stem for p in _PIGEON_UI_DIR.glob("P*.qml")}

        missing = qml_files - registered
        assert not missing, f"Components not registered in qmldir: {missing}"

    def test_registered_count(self):
        """至少应注册 20 个组件。"""
        components = _get_registered_components()
        assert len(components) >= 20, f"Expected >= 20 registered components, got {len(components)}"

    def test_ptheme_is_singleton(self):
        """PTheme 应声明为 singleton。"""
        qmldir = _PIGEON_UI_DIR / "qmldir"
        content = qmldir.read_text(encoding="utf-8")
        assert "singleton PTheme" in content, "PTheme should be declared as singleton"


class TestQmlTheme:
    """验证 PTheme 单例可加载。"""

    @pytest.fixture(autouse=True)
    def setup_engine(self):
        self.engine = _create_engine()

    def test_ptheme_loadable(self):
        """PTheme 单例可通过 QML 引用。"""
        qml_code = b"""
import QtQuick
import PigeonUI

Item {
    property color bg: PTheme.colorBg
    property bool dark: PTheme.darkMode
}
"""
        component = QQmlComponent(self.engine)
        component.setData(qml_code, QUrl())

        if component.isError():
            errors = [e.toString() for e in component.errors()]
            pytest.fail(f"PTheme load errors: {'; '.join(errors)}")

    def test_ptheme_dark_mode_tokens(self):
        """PTheme 应包含 darkMode 相关的核心 token。"""
        qml_code = b"""
import QtQuick
import PigeonUI

Item {
    property color c1: PTheme.colorBg
    property color c2: PTheme.colorSurface
    property color c3: PTheme.colorText
    property color c4: PTheme.colorBorder
    property color c5: PTheme.colorPrimary
}
"""
        component = QQmlComponent(self.engine)
        component.setData(qml_code, QUrl())

        if component.isError():
            errors = [e.toString() for e in component.errors()]
            pytest.fail(f"PTheme token errors: {'; '.join(errors)}")
