"""QML Lint 检查脚本：使用 PySide6 自带的 qmllint 对所有 QML 文件执行静态分析。

用法:
    python scripts/check_qmllint.py          # 检查所有 QML 文件
    python scripts/check_qmllint.py --info   # 同时显示 info 级别提示
"""

import subprocess
import sys
from pathlib import Path


def main() -> int:
    show_info = "--info" in sys.argv

    # 定位 qmllint
    try:
        import PySide6

        pyside_dir = Path(PySide6.__file__).parent
    except ImportError:
        print("ERROR: PySide6 not installed", file=sys.stderr)
        return 1

    qmllint = pyside_dir / "qmllint.exe"
    if not qmllint.exists():
        print(f"ERROR: qmllint not found at {qmllint}", file=sys.stderr)
        return 1

    # 收集 QML 文件
    project_root = Path(__file__).parent.parent
    qml_dir = project_root / "src" / "pigeon_ui" / "PigeonUI"
    import_path = project_root / "src" / "pigeon_ui"

    qml_files = sorted(qml_dir.glob("*.qml"))
    if not qml_files:
        print("No QML files found")
        return 0

    # 运行 qmllint
    cmd = [str(qmllint), "-I", str(import_path)] + [str(f) for f in qml_files]
    result = subprocess.run(cmd, capture_output=True, text=True)

    # 过滤输出
    output = result.stdout + result.stderr
    lines = output.splitlines()

    warnings = [ln for ln in lines if ln.startswith("Warning:")]
    infos = [ln for ln in lines if ln.startswith("Info:")]

    if warnings:
        print(f"FAIL: {len(warnings)} warning(s) found:\n")
        for w in warnings:
            print(f"  {w}")
        print()

    if show_info and infos:
        print(f"INFO: {len(infos)} info(s):\n")
        for i in infos:
            print(f"  {i}")
        print()

    if not warnings:
        print(f"OK: qmllint passed ({len(qml_files)} files, {len(infos)} info)")

    return result.returncode


if __name__ == "__main__":
    sys.exit(main())
