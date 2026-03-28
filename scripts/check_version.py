"""检查 pyproject.toml 版本号是否在 CHANGELOG.md 中有对应记录。"""

import re
import sys
from pathlib import Path

try:
    import tomllib
except ModuleNotFoundError:
    import tomli as tomllib  # type: ignore[no-redef]


def main() -> int:
    root = Path(__file__).resolve().parent.parent

    # 读取 pyproject.toml 版本
    with open(root / "pyproject.toml", "rb") as f:
        version = tomllib.load(f)["project"]["version"]

    # 检查 CHANGELOG.md 中是否含有该版本号
    changelog = root / "CHANGELOG.md"
    if not changelog.exists():
        print("ERROR: CHANGELOG.md not found")
        return 1

    content = changelog.read_text(encoding="utf-8")
    pattern = re.compile(rf"##\s+\[{re.escape(version)}\]")
    if pattern.search(content):
        print(f"OK: version {version} found in CHANGELOG.md")
        return 0
    else:
        print(f"ERROR: version {version} not found in CHANGELOG.md")
        return 1


if __name__ == "__main__":
    sys.exit(main())
