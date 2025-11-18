# External Addon Pattern (Pattern 4)

This document explains how to use external addons for development with anki-flake.

## Purpose

The external addon pattern allows you to develop Anki addons outside of this repository without dealing with git submodules. You simply provide a file path to your addon directory, and it gets automatically included in your Anki build.

## How to Use

### Step 1: Uncomment the External Addon Input

Edit `flake.nix` and uncomment the external addon input:

```nix
inputs = {
  # ... other inputs ...

  # External addon for development (Pattern 4)
  external-addon = {
    url = "path:/path/to/your/addon";
    flake = false;
  };
};
```

Replace `/path/to/your/addon` with the actual path to your addon directory.

### Step 2: Build or Run

That's it! The addon will be automatically included:

```sh
nix build    # Build Anki with your external addon
nix run      # Run Anki with your external addon
```

## Example

Let's say you're developing an addon at `/home/user/my-anki-addon/`:

```nix
# flake.nix
inputs = {
  nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  # ... other inputs ...

  external-addon = {
    url = "path:/home/user/my-anki-addon";
    flake = false;
  };
};
```

Now when you run `nix build` or `nix run`, your addon at `/home/user/my-anki-addon/` will be included in Anki.

## Development Workflow

1. Make changes to your addon source code
2. Rebuild with `nix build` (Nix will detect changes and rebuild)
3. Test with `nix run` or `./result/bin/anki`
4. Iterate!

## Disabling the External Addon

To disable the external addon:

1. Comment out the `external-addon` input in `flake.nix`
2. Rebuild: `nix build`

Or simply point to a different addon directory by changing the path.

## Multiple External Addons

Currently, the pattern supports one external addon at a time. If you need to develop multiple addons simultaneously, you can:

1. Create a directory that combines both addons
2. Point the `external-addon` input to that directory
3. Or add them to the repository using Pattern 2 or 3 (see CLAUDE.md)

## Addon Structure

Your external addon directory should follow standard Anki addon structure:

```
my-addon/
├── __init__.py          # Main addon code
├── manifest.json        # Optional manifest
├── config.json          # Optional config
└── ...                  # Other addon files
```

The addon will be built using `pkgs.anki-utils.buildAnkiAddon` with:
- `pname`: "external-addon"
- `version`: "dev"
- `src`: Your addon directory

## Notes

- The path must be absolute (e.g., `/home/user/addon`, not `~/addon` or `../addon`)
- Changes to your addon source will trigger rebuilds automatically
- This pattern is designed for **development only** - for production use, add the addon to the repository using Pattern 2 or 3
- `flake = false` is required because we're importing a directory, not a flake

## See Also

- [CLAUDE.md](./CLAUDE.md) - Complete guide to all addon patterns
- [anki/addons/](./anki/addons/) - Example addon configurations
