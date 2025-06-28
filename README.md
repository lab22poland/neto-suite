# NETo Project Suite

**NETo** (Network Engineer Tools) is a comprehensive suite of tools and applications designed for network engineers, providing essential utilities for network management, troubleshooting, and documentation.

## Project Architecture

This repository serves as the main project hub, containing three independent components as git submodules:

### 🚀 [neto/](./neto) - SwiftUI Application
- **Description**: Multiplatform SwiftUI application for iOS, iPadOS, and macOS
- **Features**: Ping, Traceroute, WHOIS (RFC 3912 compliant, FreeBSD compatible)
- **Technologies**: Swift, SwiftUI, SwiftData, Network Framework
- **Platforms**: iPhone, iPad, macOS
- **Repository**: https://github.com/lab22poland/neto.git

### 📚 [netolib/](./netolib) - Core Library
- **Description**: Core networking library and utilities
- **Technologies**: TBD
- **Repository**: https://github.com/lab22poland/netolib.git

### 📚 [netoman/](./netoman) - Documentation & Manual
- **Description**: Comprehensive documentation, manuals, and user guides
- **Technologies**: Markdown, Documentation generators
- **Repository**: https://github.com/lab22poland/netoman.git

## Getting Started

### Clone with Submodules

```bash
# Clone the main repository with all submodules
git clone --recursive https://github.com/lab22poland/neto-suite.git

# Or if you already cloned, initialize submodules
git submodule update --init --recursive
```

### Project Scripts

The repository includes several utility scripts to maintain project standards:

- **`setup-submodules.sh`**: Initial setup script for configuring submodules
- **`validate-branches.sh`**: Validates all repositories follow git standards
- **`.gitconfig-neto`**: Standardized git configuration for the project

### Working with Submodules

```bash
# Update all submodules to latest commits
git submodule update --remote

# Update a specific submodule
git submodule update --remote neto

# Pull latest changes from all submodules
git submodule foreach git pull origin main
```

## Development Workflow

Each component can be developed independently:

1. **neto/**: Swift/Xcode development
2. **netolib/**: Library development
3. **netoman/**: Documentation and manual creation

### Branch Naming Convention

All repositories in the NETo project suite use **`main`** as the default branch name:
- **Consistency**: All components follow the same branch naming convention
- **Modern Standard**: Following GitHub's updated default branch naming
- **Auto-Configuration**: Git is configured to use `main` for all new repositories

```bash
# Verify git configuration
git config --global init.defaultBranch
# Should return: main
```

### Git Configuration Standards

The project includes a standardized Git configuration (`.gitconfig-neto`) that ensures consistency across all developers and repositories. To apply these settings:

```bash
# Option 1: Include the project config in your global Git config
git config --global include.path "$(pwd)/.gitconfig-neto"

# Option 2: Apply settings manually
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global push.default simple
```

**Key Configuration Standards:**
- **Default Branch**: `main` (never `master`)
- **Submodule Aliases**: Convenient shortcuts for submodule operations
- **Line Endings**: Consistent handling across platforms
- **Merge Style**: Enhanced conflict resolution with diff3

**Validation**: Use the provided validation script to ensure compliance:
```bash
./validate-branches.sh
```

### Making Changes

1. Work in the individual submodule directories
2. Commit changes to the respective component repository
3. Update the main repository to point to new submodule commits

```bash
# After making changes in a submodule
cd neto
git add .
git commit -m "Your changes"
git push origin main

# Update main repository
cd ..
git add neto
git commit -m "Update neto submodule"
git push origin main
```

## License

© 2025 Lab22 Poland Sp. z o.o.

See individual component licenses for specific terms.
