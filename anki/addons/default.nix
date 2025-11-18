{
  pkgs,
  externalAddon ? null,
  ...
}:
let
  # Core addons list
  coreAddons = [
    pkgs.ankiAddons.adjust-sound-volume
    pkgs.ankiAddons.anki-connect
    pkgs.ankiAddons.passfail2
    (import ./more-overview-stats.nix { inherit pkgs; })
    (import ./webview-inspector.nix { inherit pkgs; })
    (import ./recolor { inherit pkgs; })
    (import ./onigiri.nix { inherit pkgs; })
    # (import ./cloze-overlapper.nix { inherit pkgs; })
  ];

  # External addon (Pattern 4) - for development from external paths
  externalAddonList =
    if externalAddon != null then
      [
        (pkgs.anki-utils.buildAnkiAddon {
          pname = "external-addon";
          version = "dev";
          src = externalAddon;
        })
      ]
    else
      [ ];
in
coreAddons ++ externalAddonList
