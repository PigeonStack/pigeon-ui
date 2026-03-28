"""检查 wheel 打包是否包含必需的资源文件。"""

import sys
import zipfile
from pathlib import Path

REQUIRED_PATTERNS = [
    "pigeon_ui/__init__.py",
    "pigeon_ui/frameless_helper.py",
    "pigeon_ui/PigeonUI/qmldir",
    "pigeon_ui/PigeonUI/PTheme.qml",
    "pigeon_ui/PigeonUI/fonts/FluentSystemIcons-Filled.ttf",
    "pigeon_ui/PigeonUI/fonts/FluentSystemIcons-Regular.ttf",
    "pigeon_ui/PigeonUI/internal/qmldir",
]


def main() -> int:
    dist = Path(__file__).resolve().parent.parent / "dist"
    wheels = sorted(dist.glob("*.whl"))

    if not wheels:
        print("ERROR: No .whl files found in dist/. Run `hatch build` first.")
        return 1

    whl_path = wheels[-1]  # 取最新的 wheel
    print(f"Checking: {whl_path.name}")

    with zipfile.ZipFile(whl_path) as whl:
        names = set(whl.namelist())

    errors = 0
    for pattern in REQUIRED_PATTERNS:
        if pattern in names:
            print(f"  OK: {pattern}")
        else:
            print(f"  MISSING: {pattern}")
            errors += 1

    # 检查至少有 10 个 .qml 文件
    qml_count = sum(1 for n in names if n.endswith(".qml"))
    if qml_count < 10:
        print(f"  WARNING: Only {qml_count} .qml files (expected >= 10)")
        errors += 1
    else:
        print(f"  OK: {qml_count} .qml files")

    if errors == 0:
        print("OK: wheel contents verified")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
