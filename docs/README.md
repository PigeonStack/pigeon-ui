# PigeonUI 文档

## 目录结构

```
docs/
├── components/          # 各组件 API 文档
├── theme/               # 主题系统规范
├── migration/           # 版本迁移说明
├── adr/                 # 架构决策记录（ADR）
├── development-workflow.md  # 开发工作流程（日常开发 / 发布 / CI）
├── i18n.md              # 国际化（i18n）与 RTL 指南
└── overlay-strategy.md  # 叠层定位与焦点管理策略
```

## 组件文档模板

每个组件文档应包含：

1. **概述**：组件用途与使用场景
2. **导入方式**：`import PigeonUI`
3. **属性列表**：属性名、类型、默认值、说明
4. **信号列表**：信号名、参数、触发时机
5. **状态说明**：normal / hovered / pressed / disabled
6. **示例代码**：最小可运行示例
7. **注意事项**：与其他组件配合使用的约束
