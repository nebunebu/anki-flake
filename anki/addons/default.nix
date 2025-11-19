{
  pkgs,
  inputs,
  ...
}:
[
  # Prebaked addons from nixpkgs
  pkgs.ankiAddons.adjust-sound-volume
  pkgs.ankiAddons.anki-connect
  pkgs.ankiAddons.passfail2

  # Custom addons
  (import ./more-overview-stats.nix { inherit pkgs; })
  (import ./webview-inspector.nix { inherit pkgs; })
  (import ./recolor { inherit pkgs; })
  (import ./onigiri.nix { inherit pkgs; })
  # (import ./cloze-overlapper.nix { inherit pkgs; })

  # External addons (from flake inputs)
  # Add addon-dev-* inputs in flake.nix, then import them here:
  # (import ./my-addon.nix { inherit pkgs inputs; })
]
