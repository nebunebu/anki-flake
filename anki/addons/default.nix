{
  pkgs,
  externalAddonInputs ? [ ],
  externalAddonConfigs ? { },
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

  # Build external addons from path inputs with optional configs and overrides
  buildExternalAddon =
    { name, src }:
    let
      # Get config for this addon (if any)
      addonConfig = externalAddonConfigs.${name} or { };

      # Extract pname from config or derive from input name
      pname = addonConfig.pname or (builtins.replaceStrings [ "addon-dev-" ] [ "" ] name);
      version = addonConfig.version or "dev";

      # Build the base addon
      baseAddon = pkgs.anki-utils.buildAnkiAddon {
        inherit pname version src;
      };

      # Apply overrides if specified
      addonWithOverrides =
        if addonConfig ? overrideAttrs then
          baseAddon.overrideAttrs addonConfig.overrideAttrs
        else
          baseAddon;

      # Apply config if specified
      addonWithConfig =
        if addonConfig ? config then
          addonWithOverrides.withConfig { inherit (addonConfig) config; }
        else
          addonWithOverrides;
    in
    addonWithConfig;

  externalAddonList = map buildExternalAddon externalAddonInputs;
in
coreAddons ++ externalAddonList
