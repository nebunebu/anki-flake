{
  pkgs,
  inputs,
  ...
}:
[
  pkgs.ankiAddons.adjust-sound-volume
  pkgs.ankiAddons.anki-connect
  pkgs.ankiAddons.passfail2

  # (import ./bury-after-fail-streak.nix { inherit pkgs; })
  (import ./more-overview-stats.nix { inherit pkgs; })
  (import ./recolor { inherit pkgs; })
  (import ./webview-inspector.nix { inherit pkgs; })
  # (import ./onigiri.nix { inherit pkgs; })
  # (import ./cloze-overlapper.nix { inherit pkgs; })
]
