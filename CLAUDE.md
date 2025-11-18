# CLAUDE.md - AI Assistant Guide for anki-flake

This document provides comprehensive guidance for AI assistants working with the anki-flake codebase.

## Project Overview

**anki-flake** is a Nix flake for declaratively configuring Anki (spaced repetition software) with custom addons, themes, and configurations. It provides a reproducible, version-controlled way to manage your complete Anki setup.

**Key Features:**
- Declarative addon management using Nix
- Custom theme configurations (Rose Pine color scheme)
- Reproducible builds with pinned dependencies
- Qt6 integration with proper environment wrapping
- Development environment with formatting and linting tools

**Quick Start:**
```sh
nix run github:nebunebu/anki-flake
```

## Repository Structure

```
anki-flake/
├── flake.nix              # Main flake configuration (inputs/outputs)
├── flake.lock             # Locked dependency versions
├── README.md              # Basic project documentation
├── CLAUDE.md              # AI assistant guide (this file)
├── EXTERNAL_ADDON_EXAMPLE.md  # Guide for Pattern 4 (external addons)
├── LICENSE                # MIT License
├── .gitignore             # Excludes build artifacts (/result, .direnv/, etc.)
│
├── anki/                  # Core Anki package and addon definitions
│   ├── default.nix        # Main package builder with Qt6 wrapping
│   └── addons/            # Addon configurations
│       ├── default.nix    # Central addon registry (list of all enabled addons)
│       ├── *.nix          # Individual addon configurations
│       └── recolor/       # Modular theme addon (split into multiple files)
│
├── nix/                   # Development infrastructure
│   ├── shell.nix          # Development shell configuration
│   ├── checks.nix         # Code quality checks (treefmt)
│   ├── formatter.nix      # Formatter wrapper
│   └── treefmt.nix        # Formatting tool configuration
│
└── assets/                # User-facing assets (images, icons)
    ├── *.png              # Profile pictures and theme assets
    └── *.svg              # Vector graphics for UI customization
```

## Core Concepts

### Flake Architecture

The flake provides four main outputs:

1. **packages.${system}.default**: Built Anki with all configured addons
2. **devShells.${system}.default**: Development environment with tools
3. **checks.${system}.formatting**: Code quality validation
4. **formatter.${system}**: Code formatter (nixfmt + linters)

**Important Files:**
- `flake.nix:20` - Package output points to `./anki`
- `anki/default.nix:1-27` - Main package builder

### Addon System

Four addon patterns are supported:

#### 1. Prebaked Addons (from nixpkgs)

```nix
pkgs.ankiAddons.adjust-sound-volume
```

These are maintained by the nixpkgs community and require no configuration.

#### 2. Simple Custom Addons

```nix
(pkgs.anki-utils.buildAnkiAddon {
  pname = "addon-name";
  version = "1.0.0";
  src = pkgs.fetchFromGitHub {
    owner = "author";
    repo = "repo-name";
    rev = "v1.0.0";
    hash = "sha256-...";
  };
}).withConfig {
  config = {
    "Setting Name" = "value";
  };
}
```

**Example:** `anki/addons/more-overview-stats.nix:1-36`

#### 3. Complex Modular Addons

```nix
# anki/addons/recolor/default.nix
let
  buttons = import ./buttons.nix;
  canvas = import ./canvas.nix;
  # ... more modules
in
pkgs.ankiAddons.recolor.withConfig {
  config = {
    colors = buttons // canvas // { /* additional colors */ };
  };
}
```

**Example:** `anki/addons/recolor/default.nix:1-152`

#### 4. External Addon (Development Pattern)

```nix
# flake.nix
inputs = {
  # ... other inputs ...

  external-addon = {
    url = "path:/path/to/your/addon";
    flake = false;
  };
};
```

This pattern allows you to develop addons outside of the repository without git submodules. Simply provide a file path to your addon directory, and it will be automatically included in the build.

**How it works:**
1. Uncomment the `external-addon` input in `flake.nix`
2. Point it to your addon directory (absolute path)
3. The addon is automatically built and included via `anki/addons/default.nix:15-26`

**Use cases:**
- Developing new addons locally
- Testing modifications to existing addons
- Rapid iteration without committing to the repository

**Important notes:**
- Path must be absolute (e.g., `/home/user/addon`)
- Only one external addon supported at a time
- This is for **development only** - use Pattern 2 or 3 for production
- See `EXTERNAL_ADDON_EXAMPLE.md` for detailed usage guide

**Example:** `anki/addons/default.nix:15-26`, `flake.nix:15-20`

### Qt6 Integration

The main package uses `symlinkJoin` with `wrapQtAppsHook` to ensure Qt6 libraries are properly available at runtime:

```nix
# anki/default.nix:11-24
pkgs.symlinkJoin {
  name = "anki";
  paths = [ anki-with-addons ];
  nativeBuildInputs = [ pkgs.qt6.wrapQtAppsHook ];
  buildInputs = [ qt6.qtbase qt6.qtwayland qt6.qtsvg qt6.qtdeclarative ];
  postBuild = ''
    wrapQtApp "$out/bin/anki"
  '';
}
```

This is **critical** - without proper wrapping, Anki may fail to find Qt libraries at runtime.

## Development Workflows

### Building the Package

```sh
nix build                # Build default package
nix build .#default      # Explicit target
```

Result will be symlinked at `./result/bin/anki`.

### Running Anki

```sh
nix run                  # Run from local flake
nix run .                # Same as above
nix run github:nebunebu/anki-flake  # Run from GitHub
```

### Development Shell

```sh
nix develop              # Enter development shell
# Inside shell:
- `anki` is available
- `treefmt` for formatting
- `cowsay` for fun
```

### Formatting Code

```sh
nix fmt                  # Format all Nix and Markdown files
```

Tools used (configured in `nix/treefmt.nix:1-18`):
- **nixfmt**: Nix code formatting
- **deadnix**: Remove unused variable bindings (with `--no-lambda-pattern-names`)
- **statix**: Nix linter
- **mdformat**: Markdown formatting

### Running Checks

```sh
nix flake check          # Run all checks (formatting validation)
```

## Code Conventions

### Nix Style

1. **Use the pipe operator** (`|>`) for readability:
   ```nix
   # Good (used in anki/default.nix:3-4)
   inputs.nixpkgs.legacyPackages
   |> builtins.mapAttrs (...)

   # Avoid
   builtins.mapAttrs (...) inputs.nixpkgs.legacyPackages
   ```

2. **Import patterns**:
   ```nix
   # Module entry point
   { pkgs, ... }:

   # Or with inputs
   { inputs }:
   ```

3. **Addon registry** (`anki/addons/default.nix:1-12`):
   - Always returns a list
   - Comment out disabled addons (don't delete)
   - Use `inherit pkgs` when importing
   ```nix
   [
     pkgs.ankiAddons.prebaked-addon
     (import ./custom-addon.nix { inherit pkgs; })
     # (import ./disabled-addon.nix { inherit pkgs; })
   ]
   ```

4. **Color definitions** (in recolor addon):
   - Use 4-element arrays: `[description light-color dark-color css-var]`
   - Descriptive names for color values
   - Comment colors under development
   ```nix
   FG = [
     "Text"
     "#e0def4"  # Light mode
     "#e0def4"  # Dark mode
     "--fg"     # CSS variable
   ];
   ```

5. **Modular organization**:
   - Split complex configurations into separate files
   - Use `import` and merge with `//` operator
   - Keep related configs together (e.g., `recolor/` directory)

### Git Conventions

1. **Commit messages**:
   - Short, imperative mood
   - Focus on what changed
   - Examples: "add recolor", "rm local-sources", "refactor recolor"

2. **Branch naming**:
   - Feature branches: `claude/<description>-<session-id>`
   - Always push to branches starting with `claude/`

3. **Build artifacts**:
   - Never commit `result/` (Nix build output)
   - Ignore `.direnv/`, `.cache/`, `*.envrc`

## Common Tasks for AI Assistants

### Adding a New Addon

1. **Create addon definition** (if not in nixpkgs):
   ```sh
   # Create anki/addons/new-addon.nix
   ```

2. **Add to registry**:
   ```nix
   # Edit anki/addons/default.nix
   [
     # ... existing addons
     (import ./new-addon.nix { inherit pkgs; })
   ]
   ```

3. **Test the build**:
   ```sh
   nix build
   ```

### Using External Addon for Development

For developing an addon outside this repository:

1. **Enable external addon input** in `flake.nix`:
   ```nix
   external-addon = {
     url = "path:/path/to/your/addon";
     flake = false;
   };
   ```

2. **Build and test**:
   ```sh
   nix build    # Addon is automatically included
   nix run      # Test your addon in Anki
   ```

3. **Iterate**:
   - Make changes to your addon
   - Rebuild to see changes
   - No need to commit or add to repository

See `EXTERNAL_ADDON_EXAMPLE.md` for detailed usage.

### Modifying Colors/Theme

Colors are defined in `anki/addons/recolor/`:
- `buttons.nix` - Button colors
- `canvas.nix` - Background colors
- `card_states.nix` - Card state colors (new, learning, review, etc.)
- `flags.nix` - Flag colors
- `scrollbar.nix` - Scrollbar styling

**Steps:**
1. Edit the appropriate color file
2. Follow the 4-element array format: `[description light dark css-var]`
3. Test with `nix build && ./result/bin/anki`

### Updating Dependencies

1. **Update flake inputs**:
   ```sh
   nix flake update          # Update all inputs
   nix flake lock --update-input nixpkgs  # Update specific input
   ```

2. **Update addon version**:
   ```nix
   # Edit the addon .nix file
   version = "2.1.37";  # Update version
   rev = "v2.1.37";     # Update git rev
   hash = "";           # Clear hash, Nix will tell you the correct one
   ```

3. **Get new hash**:
   ```sh
   nix build  # Will fail with correct hash
   # Copy the hash from error message and update the file
   ```

### Formatting Before Commit

**Always run before committing:**
```sh
nix fmt                  # Format all code
nix flake check          # Verify formatting
```

If checks fail, fix issues and re-run formatter.

### Troubleshooting Qt Issues

If Anki fails to start with Qt-related errors:

1. **Check Qt6 wrapper** in `anki/default.nix:14-23`
2. **Verify all Qt modules** are in `buildInputs`:
   - `qt6.qtbase`
   - `qt6.qtwayland`
   - `qt6.qtsvg`
   - `qt6.qtdeclarative`
3. **Ensure `wrapQtApp`** is called in `postBuild`

### Handling Addon Build Customization

Some addons need custom build phases (see `anki/addons/webview-inspector.nix` and `cloze-overlapper.nix`):

```nix
.overrideAttrs (_: {
  # Add build dependencies
  nativeBuildInputs = [ python3 pyqt6 ];

  # Custom build phase
  buildPhase = ''
    # Compile UI files, etc.
  '';

  # Custom install phase
  installPhase = ''
    # Custom installation logic
  '';
})
```

## Important Notes for AI Assistants

### DO:
- ✅ Always run `nix fmt` before committing
- ✅ Test builds with `nix build` after changes
- ✅ Comment out disabled addons instead of deleting
- ✅ Use descriptive commit messages
- ✅ Follow the pipe operator style (`|>`)
- ✅ Preserve color scheme consistency (Rose Pine theme)
- ✅ Pin addon versions with content hashes
- ✅ Use `inherit pkgs` when importing modules
- ✅ Use Pattern 4 (external addon) for development without submodules

### DON'T:
- ❌ Commit build artifacts (`result/`, `.direnv/`)
- ❌ Push to branches not starting with `claude/`
- ❌ Mix light/dark colors inconsistently
- ❌ Remove the Qt6 wrapper configuration
- ❌ Use mutable git revs (always use specific commits)
- ❌ Skip formatting checks
- ❌ Modify `flake.lock` manually (use `nix flake update`)
- ❌ Add dependencies without updating `buildInputs`/`nativeBuildInputs`

### Key Files to Review Before Changes:

| Task | Files to Review |
|------|----------------|
| Adding addon | `anki/addons/default.nix`, addon examples |
| External addon development | `flake.nix:15-20`, `EXTERNAL_ADDON_EXAMPLE.md` |
| Changing colors | `anki/addons/recolor/*.nix` |
| Package issues | `anki/default.nix`, `flake.nix` |
| Build problems | `anki/default.nix:11-24` (Qt wrapper) |
| Formatting | `nix/treefmt.nix` |
| Dependencies | `flake.nix:4-14`, `flake.lock` |

## Color Scheme Reference

This repository uses the **Rose Pine** color palette throughout:

| Color Name | Hex | Usage |
|------------|-----|-------|
| Base | `#191724` | Primary background |
| Surface | `#26233a` | Secondary background |
| Overlay | `#313244` | Tertiary background |
| Text | `#e0def4` | Primary text |
| Subtle | `#908caa` | Secondary text |
| Iris | `#c4a7e7` | Links, accents |
| Foam | `#9ccfd8` | Info, young cards |
| Rose | `#eb6f92` | Danger, unseen cards |
| Gold | `#f6c177` | Warning, suspended |
| Pine | `#31748f` | Success, learning |
| Love | `#eb6f92` | Alternative accent |

When adding new color definitions, maintain consistency with this palette.

## Architecture Decisions

### Why Nix Flakes?

- **Reproducibility**: Exact same build on any machine
- **Declarative**: Configuration as code
- **Version Control**: Track addon configurations in git
- **Multi-system**: Works on all Nix-supported platforms

### Why symlinkJoin for Qt6?

Direct use of `anki.withAddons` doesn't properly set up Qt6 environment variables. Using `symlinkJoin` with `wrapQtAppsHook` ensures:
- Qt6 libraries are found at runtime
- Wayland support works correctly
- SVG/QML rendering functions properly

See commit `c8bcc50` ("use wrapQtAppsHook") for context.

### Why Modular Recolor Addon?

The recolor addon has 100+ color definitions. Splitting into files:
- Improves maintainability
- Makes color changes easier to track in git
- Allows focused changes without merge conflicts
- Groups related colors logically

See commit `aebaea1` ("refactor recolor") for context.

## Debugging Tips

### Build Fails

```sh
nix build --show-trace    # Show full error trace
nix log                   # Show build log
```

### Addon Not Loading

1. Check addon is in `anki/addons/default.nix` (uncommented)
2. Verify addon builds: `nix build .#default`
3. Check for Python errors in Anki console

### Qt Runtime Errors

```sh
# Test with debug output
QT_DEBUG_PLUGINS=1 ./result/bin/anki
```

### Hash Mismatch

When adding/updating addons:
1. Set `hash = "";` in the addon definition
2. Run `nix build`
3. Copy the correct hash from error message
4. Update the addon file with correct hash

## Additional Resources

- [Nix Flakes Documentation](https://nixos.wiki/wiki/Flakes)
- [nixpkgs Anki Addons](https://github.com/NixOS/nixpkgs/tree/master/pkgs/games/anki/addons)
- [Anki Add-on Development](https://addon-docs.ankiweb.net/)
- [Rose Pine Theme](https://rosepinetheme.com/)

## Quick Reference Commands

```sh
# Build & Run
nix build                           # Build package
nix run                             # Run Anki
nix develop                         # Enter dev shell

# Formatting & Checks
nix fmt                             # Format code
nix flake check                     # Run checks

# Updates
nix flake update                    # Update all dependencies
nix flake lock --update-input nixpkgs  # Update nixpkgs only

# Debugging
nix build --show-trace              # Detailed error trace
nix log                             # Show build logs
nix-store --gc                      # Clean old builds

# Git (for AI assistants)
git status                          # Check working tree
git add .                           # Stage changes
git commit -m "description"         # Commit
git push -u origin <branch>         # Push to feature branch
```

---

**Last Updated:** 2025-11-18
**Repository:** github:nebunebu/anki-flake
**Maintained for:** AI assistant context and onboarding
