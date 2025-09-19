{ pkgs }:
[
  pkgs.ankiAddons.adjust-sound-volume
  pkgs.ankiAddons.anki-connect
  pkgs.ankiAddons.passfail2
  (import ./more_overview_stats.nix { inherit pkgs; })
  (import ./recolor { inherit pkgs; })
  (import ./review-heatmap.nix { inherit pkgs; })
]
