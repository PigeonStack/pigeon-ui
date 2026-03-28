<#
.SYNOPSIS
    PigeonUI 开发任务脚本（Windows PowerShell 替代 Makefile）
.EXAMPLE
    .\make.ps1 lint
    .\make.ps1 check
    .\make.ps1 run-gallery
#>
param(
    [Parameter(Position = 0)]
    [ValidateSet("lint", "lint-qml", "format", "typecheck", "test", "test-cov", "check", "build", "run-gallery", "pre-release-check", "install-dev", "clean")]
    [string]$Task = "check"
)

$ErrorActionPreference = "Stop"

function Invoke-Lint {
    Write-Host "=== Lint ===" -ForegroundColor Cyan
    python -m ruff check src/ tests/ examples/
}

function Invoke-LintQml {
    Write-Host "=== QML Lint ===" -ForegroundColor Cyan
    python scripts/check_qmllint.py
}

function Invoke-Format {
    Write-Host "=== Format ===" -ForegroundColor Cyan
    python -m ruff format src/ tests/ examples/
    python -m ruff check --fix src/ tests/ examples/
}

function Invoke-Typecheck {
    Write-Host "=== Typecheck ===" -ForegroundColor Cyan
    python -m mypy src/pigeon_ui/
}

function Invoke-Test {
    Write-Host "=== Test ===" -ForegroundColor Cyan
    python -m pytest tests/ -v
}

function Invoke-TestCov {
    Write-Host "=== Test (coverage) ===" -ForegroundColor Cyan
    python -m pytest tests/ -v --cov=pigeon_ui --cov-report=term-missing
}

function Invoke-Check {
    Invoke-Lint
    Invoke-LintQml
    Invoke-Typecheck
    Invoke-Test
}

function Invoke-Build {
    Write-Host "=== Build ===" -ForegroundColor Cyan
    python -m hatch build
}

function Invoke-RunGallery {
    python examples/run_gallery.py
}

function Invoke-PreReleaseCheck {
    Write-Host "=== Pre-Release Check ===" -ForegroundColor Cyan
    python scripts/pre_release_check.py
}

function Invoke-InstallDev {
    Write-Host "=== Install Dev ===" -ForegroundColor Cyan
    pip install -e ".[dev]"
    python -m pre_commit install
}

function Invoke-Clean {
    Write-Host "=== Clean ===" -ForegroundColor Cyan
    foreach ($dir in @("dist", "build", "src\pigeon_ui.egg-info")) {
        if (Test-Path $dir) { Remove-Item $dir -Recurse -Force }
    }
    Write-Host "Cleaned."
}

switch ($Task) {
    "lint"        { Invoke-Lint }
    "lint-qml"    { Invoke-LintQml }
    "format"      { Invoke-Format }
    "typecheck"   { Invoke-Typecheck }
    "test"        { Invoke-Test }
    "test-cov"    { Invoke-TestCov }
    "check"       { Invoke-Check }
    "build"       { Invoke-Build }
    "run-gallery" { Invoke-RunGallery }
    "pre-release-check" { Invoke-PreReleaseCheck }
    "install-dev" { Invoke-InstallDev }
    "clean"       { Invoke-Clean }
}
