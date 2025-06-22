# NETo Project Cursor Rules Structure

This directory contains the modern Cursor rules configuration following the [official Cursor documentation](https://docs.cursor.com/context/rules) recommendations.

## Rule Organization

### Main Project Rules (`.cursor/rules/`)

| File | Type | Description | Triggers |
|------|------|-------------|----------|
| `project-overview.mdc` | Always | Core project information and structure | Always active |
| `swift-neto-app.mdc` | Auto Attached | Swift/iOS development guidelines | Swift files in neto/ |
| `testing-neto.mdc` | Auto Attached | Testing standards and practices | Test files |
| `documentation.mdc` | Auto Attached | Documentation standards | Markdown/doc files |
| `performance-security.mdc` | Auto Attached | Performance and security guidelines | Network/security related files |
| `deployment-cicd.mdc` | Auto Attached | Deployment and CI/CD practices | Build/deployment files |
| `submodule-management.mdc` | Auto Attached | Git submodule operations | Git/submodule files |

### Submodule-Specific Rules

Each submodule has its own context-aware rules:

- **`neto/.cursor/rules/neto-specific.mdc`**: SwiftUI application context
- **`netolib/.cursor/rules/netolib-specific.mdc`**: Core library development context  
- **`netoman/.cursor/rules/netoman-specific.mdc`**: Documentation repository context

## Rule Types Explained

- **Always**: Included in every AI conversation
- **Auto Attached**: Automatically included when working with matching file patterns
- **Agent Requested**: AI decides when to include based on context
- **Manual**: Only included when explicitly referenced with @ruleName

## Benefits of New Structure

1. **Performance**: Context-aware loading reduces token usage
2. **Organization**: Focused, specialized rule files
3. **Scalability**: Easy to add new domain-specific rules
4. **Team Collaboration**: Better visibility and version control
5. **Flexibility**: Support for different rule activation patterns

## Migration from Legacy

The legacy `.cursorrules` file has been completely migrated to the new structure and removed from the project. All rules are now organized in the modern `.cursor/rules/` format for better performance and maintainability.

**Historical Note**: The original `.cursorrules` content is preserved in git history (commits before migration) for reference if needed.

## Usage

Cursor automatically detects and applies these rules based on:
- File types being edited
- Directory context
- Explicit rule references (@ruleName)
- AI agent requests for relevant context

No manual configuration required - the rules activate intelligently based on your current work context. 