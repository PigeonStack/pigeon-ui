---
applyTo: "src/pigeon_ui/PigeonUI/**/*.qml"
---

# PigeonUI QML 组件编码规范

## PTheme 单例引用

所有 `.qml` 组件文件必须通过 `PTheme` 单例引用视觉常量，**禁止内联硬编码任何颜色、字体大小、圆角半径或间距值**。

```qml
// ✅ 正确
Rectangle {
    color: PTheme.colorSurface
    radius: PTheme.radiusMd
}

// ❌ 错误
Rectangle {
    color: "#161b27"
    radius: 8
}
```

## 组件命名

- **所有对外公开的组件（含主题单例）统一以 `P` 前缀**：`PTheme.qml`、`PWindow.qml`、`PText.qml`、`PButton.qml` 等
- 内部辅助组件放入 `internal/`，不在 `qmldir` 中注册，**不使用 `P` 前缀**

## 文件结构顺序

1. `import` 语句（QtQuick 优先）
2. 根元素 + `id: root`
3. 公开属性（`property`）
4. 公开信号（`signal`）
5. 私有状态（`QtObject { id: _p }`）
6. 尺寸默认值（`implicitWidth` / `implicitHeight`）
7. `contentItem` / `background`
8. 动画（`Behavior on`）
9. 子组件
10. 事件处理

## 动画

- 属性过渡用 `Behavior on`
- 时长引用 `PTheme.animFast`（150ms）/ `PTheme.animNormal`（300ms）/ `PTheme.animSlow`（500ms）
- 默认缓动 `Easing.OutCubic`

## 禁止事项

- 禁止硬编码颜色、字体大小、圆角、间距
- 禁止在组件中写业务逻辑
- 禁止使用 `eval()`、`XMLHttpRequest`
- 禁止组件间直接引用 id

## 可访问性（Accessibility）

- 所有可交互组件必须设置 `Accessible.role`（如 `Accessible.Button`、`Accessible.CheckBox`）。
- 所有可交互组件必须设置 `Accessible.name`（描述组件用途，通常绑定到 `text` 属性）。
- 可交互组件应设置 `activeFocusOnTab: true`，确保 Tab 键导航可达。
- 提供 `visualFocus` 焦点环反馈的组件使用 `PTheme.colorFocusRing`。

```qml
// ✅ 正确
PButton {
    text: "Submit"
    Accessible.role: Accessible.Button
    Accessible.name: text
    activeFocusOnTab: true
}
```

## 国际化（i18n）

- 组件内所有用户可见硬编码文本必须使用 `qsTr()` 包裹。
- 布局应兼容 RTL（避免绝对定位假设从左到右顺序）。

```qml
// ✅ 正确
Text { text: qsTr("No data") }

// ❌ 错误
Text { text: "No data" }
```
