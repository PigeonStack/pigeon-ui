"""检查 qmldir 中声明的组件与实际 .qml 文件是否一致。"""

import sys
from pathlib import Path


def main() -> int:
    base = Path(__file__).resolve().parent.parent / "src" / "pigeon_ui" / "PigeonUI"
    qmldir = base / "qmldir"

    if not qmldir.exists():
        print(f"ERROR: qmldir not found at {qmldir}")
        return 1

    # 解析 qmldir 中声明的 .qml 文件
    declared_files: list[str] = []
    for line in qmldir.read_text(encoding="utf-8").splitlines():
        parts = line.strip().split()
        if not parts or parts[0].startswith("#"):
            continue
        if len(parts) >= 3 and parts[-1].endswith(".qml"):
            declared_files.append(parts[-1])

    # 实际存在的 .qml 文件（排除 internal/）
    actual_files = {f.name for f in base.glob("*.qml")}

    errors = 0

    # 检查 qmldir 声明但文件不存在
    for f in declared_files:
        if f not in actual_files:
            print(f"ERROR: qmldir declares '{f}' but file not found")
            errors += 1

    # 检查文件存在但未在 qmldir 声明（P 前缀的公开组件）
    declared_set = set(declared_files)
    for f in sorted(actual_files):
        if f.startswith("P") and f not in declared_set:
            print(f"WARNING: '{f}' exists but not declared in qmldir")
            errors += 1

    if errors == 0:
        print("OK: qmldir and .qml files are in sync")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
