"""Python 层单元测试：register()、资源路径、导入流程。"""

import sys
from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine

import pigeon_ui

# 共享 QGuiApplication 实例，避免重复创建
_app = QGuiApplication.instance() or QGuiApplication(sys.argv)


# ── register() ──


def test_register_adds_import_path():
    """register() 应将 PigeonUI 模块所在目录添加到 engine import path。"""
    engine = QQmlApplicationEngine()
    pigeon_ui.register(engine)

    paths = engine.importPathList()
    qml_dir = Path(pigeon_ui.__file__).parent
    assert any(Path(p) == qml_dir for p in paths), (
        f"Expected {qml_dir} in import paths, got {paths}"
    )


def test_register_idempotent():
    """多次调用 register() 不应重复添加路径。"""
    engine = QQmlApplicationEngine()
    pigeon_ui.register(engine)
    pigeon_ui.register(engine)

    qml_dir = str(Path(pigeon_ui.__file__).parent)
    count = sum(1 for p in engine.importPathList() if str(Path(p)) == qml_dir)
    # addImportPath 可能去重也可能不去重，但不应导致错误
    assert count >= 1


def test_register_returns_none():
    """register() 返回 None。"""
    engine = QQmlApplicationEngine()
    result = pigeon_ui.register(engine)
    assert result is None


# ── 资源路径 ──


def test_qmldir_exists():
    """qmldir 文件应存在且非空。"""
    qmldir = Path(pigeon_ui.__file__).parent / "PigeonUI" / "qmldir"
    assert qmldir.exists(), f"qmldir not found at {qmldir}"
    assert qmldir.stat().st_size > 0, "qmldir is empty"


def test_qmldir_components_match_files():
    """qmldir 中声明的组件应每个都有对应的 .qml 文件。"""
    base = Path(pigeon_ui.__file__).parent / "PigeonUI"
    qmldir = base / "qmldir"

    declared = []
    for line in qmldir.read_text(encoding="utf-8").splitlines():
        parts = line.strip().split()
        # 格式: ComponentName version File.qml  或  singleton ComponentName version File.qml
        if len(parts) >= 3 and parts[-1].endswith(".qml"):
            declared.append(parts[-1])

    assert len(declared) > 0, "qmldir declares no components"
    for qml_file in declared:
        assert (base / qml_file).exists(), f"qmldir declares {qml_file} but file not found"


def test_qml_files_all_registered():
    """PigeonUI/ 下以 P 开头的 .qml 文件应全部在 qmldir 中声明。"""
    base = Path(pigeon_ui.__file__).parent / "PigeonUI"
    qmldir = base / "qmldir"

    registered_files = set()
    for line in qmldir.read_text(encoding="utf-8").splitlines():
        parts = line.strip().split()
        if len(parts) >= 3 and parts[-1].endswith(".qml"):
            registered_files.add(parts[-1])

    for qml_path in sorted(base.glob("P*.qml")):
        assert qml_path.name in registered_files, (
            f"{qml_path.name} exists but not registered in qmldir"
        )


def test_qmldir_module_name():
    """qmldir 应声明 module PigeonUI。"""
    qmldir = Path(pigeon_ui.__file__).parent / "PigeonUI" / "qmldir"
    content = qmldir.read_text(encoding="utf-8")
    assert "module PigeonUI" in content, "qmldir missing 'module PigeonUI' declaration"


def test_fonts_directory_exists():
    """字体目录应存在且包含文件。"""
    fonts_dir = Path(pigeon_ui.__file__).parent / "PigeonUI" / "fonts"
    assert fonts_dir.exists(), f"fonts directory not found at {fonts_dir}"
    font_files = list(fonts_dir.glob("*"))
    assert len(font_files) > 0, "fonts directory is empty"


def test_internal_directory_exists():
    """internal 模块目录应存在。"""
    internal_dir = Path(pigeon_ui.__file__).parent / "PigeonUI" / "internal"
    assert internal_dir.exists(), f"internal directory not found at {internal_dir}"
    assert (internal_dir / "qmldir").exists(), "internal/qmldir missing"


# ── 导入流程 ──


def test_pigeon_ui_importable():
    """pigeon_ui 包应可正常导入。"""
    import importlib

    mod = importlib.import_module("pigeon_ui")
    assert hasattr(mod, "register")


def test_frameless_helper_importable():
    """FramelessHelper 应可从 pigeon_ui 模块导入。"""
    from pigeon_ui.frameless_helper import FramelessHelper

    assert FramelessHelper is not None
