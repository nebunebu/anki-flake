# anki-flake

A Nix flake for declaratively configuring [Anki](https://apps.ankiweb.net/) with custom addons, themes, and configurations. Manage your complete Anki setup as code with reproducible builds and version control.

## Features

- **Declarative addon management** - Define addons in Nix with pinned versions
- **Custom theming** - Rose Pine color scheme with full customization
- **Reproducible builds** - Same setup on any machine with Nix
- **Qt6 integration** - Proper environment wrapping for reliable GUI rendering
- **Development tools** - Integrated formatters, linters, and checks
- **External addon development** - Develop addons locally without git submodules

## Quick Start

Run Anki with this configuration directly from GitHub:

```sh
nix run github:nebunebu/anki-flake
```

Or build locally:

```sh
git clone https://github.com/nebunebu/anki-flake
cd anki-flake
nix build
./result/bin/anki
```

## Usage

### As a Flake Input

Add to your own flake:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    anki-flake.url = "github:nebunebu/anki-flake";
  };

  outputs = { self, nixpkgs, anki-flake }: {
    # Use in your configuration
  };
}
```

### Development Shell

Enter a development environment with Anki and tools:

```sh
nix develop
```

Inside the shell you have access to:

- `anki` - The configured Anki installation
- `treefmt` - Code formatter
- Development tools (nixfmt, deadnix, statix, mdformat)

## Configuration

### Adding Addons

This flake supports four addon patterns:

#### 1. Prebaked Addons (from nixpkgs)

```nix
# anki/addons/default.nix
[
  pkgs.ankiAddons.adjust-sound-volume
  # ... more addons
]
```

#### 2. Custom Addons from GitHub

```nix
# Create anki/addons/my-addon.nix
{ pkgs }:
(pkgs.anki-utils.buildAnkiAddon {
  pname = "my-addon";
  version = "1.0.0";
  src = pkgs.fetchFromGitHub {
    owner = "author";
    repo = "addon-repo";
    rev = "v1.0.0";
    hash = "sha256-...";
  };
}).withConfig {
  config = {
    "Setting Name" = "value";
  };
}
```

Then add to `anki/addons/default.nix`:

```nix
[
  (import ./my-addon.nix { inherit pkgs; })
  # ... other addons
]
```

#### 3. Complex Modular Addons

For addons with extensive configuration, split into multiple files:

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

#### 4. External Addon Development

Develop addons outside this repository:

```nix
# flake.nix
inputs = {
  external-addon = {
    url = "path:/absolute/path/to/your/addon";
    flake = false;
  };
};
```

The addon is automatically built and included - perfect for rapid iteration.

### Customizing Colors

Colors are defined in `anki/addons/recolor/` using the Rose Pine theme:

```nix
# anki/addons/recolor/buttons.nix
{
  BORDER = [
    "Border"
    "#e0def4"  # Light mode
    "#e0def4"  # Dark mode
    "--border"  # CSS variable
  ];
}
```

Edit the appropriate file and rebuild to see changes.

## Development

### Formatting

Format all Nix and Markdown files:

```sh
nix fmt
```

### Checks

Run all quality checks:

```sh
nix flake check
```

### Updating Dependencies

Update all flake inputs:

```sh
nix flake update
```

Update specific input:

```sh
nix flake lock --update-input nixpkgs
```

### Project Structure

```
anki-flake/
├── flake.nix              # Main flake configuration
├── anki/                  # Core package and addons
│   ├── default.nix        # Package builder with Qt6 wrapping
│   └── addons/            # Addon configurations
│       ├── default.nix    # Addon registry
│       └── *.nix          # Individual addons
├── nix/                   # Development infrastructure
│   ├── shell.nix          # Dev shell
│   ├── treefmt.nix        # Formatter config
│   └── checks.nix         # Quality checks
└── assets/                # Images and icons
```

## Why Nix?

- **Reproducible**: Same build on any machine, every time
- **Declarative**: Configuration as code, version controlled
- **Isolated**: No conflicts with system packages
- **Multi-system**: Works on Linux, macOS, and more

## Color Scheme

This configuration uses the [Rose Pine](https://rosepinetheme.com/) color palette throughout:

| Color | Hex | Usage |
|-------|-----|-------|
| Base | `#191724` | Primary background |
| Surface | `#26233a` | Secondary background |
| Text | `#e0def4` | Primary text |
| Iris | `#c4a7e7` | Links, accents |
| Foam | `#9ccfd8` | Info, young cards |
| Rose | `#eb6f92` | Danger, unseen cards |
| Gold | `#f6c177` | Warning, suspended |
| Pine | `#31748f` | Success, learning |

## Contributing

Contributions welcome! Please:

1. Run checks with `nix flake check`
1. Test builds with `nix build`
1. Use descriptive commit messages

## License

MIT License - see [LICENSE](LICENSE) for details.

## Resources

- [Anki](https://apps.ankiweb.net/) - Spaced repetition software
- [Nix Flakes](https://nixos.wiki/wiki/Flakes) - Nix flakes documentation
- [nixpkgs Anki Addons](https://github.com/NixOS/nixpkgs/tree/master/pkgs/games/anki/addons) - Community addons
- [Rose Pine Theme](https://rosepinetheme.com/) - Color scheme

## AI Assistant Guide

For AI assistants working with this codebase, see [CLAUDE.md](CLAUDE.md) for comprehensive technical documentation, conventions, and workflows.
