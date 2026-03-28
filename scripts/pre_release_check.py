"""Release 前自动化检查脚本。

整合所有 pre-release checklist 项目，一键执行完整的发布前验证。

用法:
    python scripts/pre_release_check.py
"""

import subprocess
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent


def _run(label: str, cmd: list[str], cwd: Path | None = None) -> bool:
    """运行子命令，返回是否成功。"""
    print(f"\n{'=' * 60}")
    print(f"  {label}")
    print(f"{'=' * 60}")
    result = subprocess.run(cmd, cwd=cwd or ROOT)
    if result.returncode == 0:
        print("  -> PASS")
    else:
        print(f"  -> FAIL (exit code {result.returncode})")
    return result.returncode == 0


def main() -> int:
    checks: list[tuple[str, bool]] = []

    # 1. 版本号 / CHANGELOG 一致性
    ok = _run(
        "Version / CHANGELOG check",
        [sys.executable, "scripts/check_version.py"],
    )
    checks.append(("Version / CHANGELOG", ok))

    # 2. qmldir 与文件同步
    ok = _run(
        "qmldir sync check",
        [sys.executable, "scripts/check_qmldir.py"],
    )
    checks.append(("qmldir sync", ok))

    # 3. Python lint
    ok = _run(
        "Python lint (ruff)",
        [sys.executable, "-m", "ruff", "check", "src/", "tests/", "examples/"],
    )
    checks.append(("Python lint", ok))

    # 4. QML lint
    ok = _run(
        "QML lint (qmllint)",
        [sys.executable, "scripts/check_qmllint.py"],
    )
    checks.append(("QML lint", ok))

    # 5. Type check
    ok = _run(
        "Type check (mypy)",
        [sys.executable, "-m", "mypy", "src/pigeon_ui/"],
    )
    checks.append(("Type check", ok))

    # 6. 全部测试（含回归）
    ok = _run(
        "Tests (all, including regression)",
        [sys.executable, "-m", "pytest", "tests/", "-v", "--tb=short"],
    )
    checks.append(("Tests", ok))

    # 7. 覆盖率检查
    ok = _run(
        "Coverage threshold",
        [
            sys.executable,
            "-m",
            "pytest",
            "tests/",
            "--cov=pigeon_ui",
            "--cov-report=term-missing",
            "--cov-fail-under=60",
            "-q",
            "--no-header",
        ],
    )
    checks.append(("Coverage", ok))

    # 8. 构建 wheel
    ok = _run(
        "Build wheel",
        [sys.executable, "-m", "hatch", "build"],
    )
    checks.append(("Build", ok))

    # 9. Wheel 内容检查
    if ok:
        ok = _run(
            "Wheel asset check",
            [sys.executable, "scripts/check_assets.py"],
        )
        checks.append(("Wheel assets", ok))
    else:
        checks.append(("Wheel assets", False))

    # ── 汇总 ──
    print(f"\n{'=' * 60}")
    print("  RELEASE CHECKLIST SUMMARY")
    print(f"{'=' * 60}")
    failed = 0
    for name, passed in checks:
        status = "PASS" if passed else "FAIL"
        icon = "[+]" if passed else "[-]"
        print(f"  {icon} {name}: {status}")
        if not passed:
            failed += 1

    print(f"\n  Total: {len(checks)} checks, {len(checks) - failed} passed, {failed} failed")

    if failed:
        print("\n  RELEASE BLOCKED: Fix failing checks before release.\n")
        return 1
    else:
        print("\n  ALL CHECKS PASSED: Ready to release.\n")
        return 0


if __name__ == "__main__":
    sys.exit(main())
