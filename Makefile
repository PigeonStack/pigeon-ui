.PHONY: lint lint-qml format typecheck test build run-gallery clean check

# ---------- 开发命令 ----------

## 运行全部检查（lint + qmllint + typecheck + test）
check: lint lint-qml typecheck test

## 代码风格检查
lint:
	python -m ruff check src/ tests/ examples/

## QML 静态检查
lint-qml:
	python scripts/check_qmllint.py

## 代码格式化
format:
	python -m ruff format src/ tests/ examples/
	python -m ruff check --fix src/ tests/ examples/

## 类型检查
typecheck:
	python -m mypy src/pigeon_ui/

## 运行测试
test:
	python -m pytest tests/ -v

## 运行测试（带覆盖率）
test-cov:
	python -m pytest tests/ -v --cov=pigeon_ui --cov-report=term-missing

# ---------- 构建与运行 ----------

## 构建 wheel
build:
	python -m hatch build

## 启动 Gallery 示例
run-gallery:
	python examples/run_gallery.py

## 发布前全量检查
pre-release-check:
	python scripts/pre_release_check.py

# ---------- 工具管理 ----------

## 安装开发依赖
install-dev:
	pip install -e ".[dev]"
	python -m pre_commit install

## 清理构建产物
clean:
	rm -rf dist/ build/ src/*.egg-info
