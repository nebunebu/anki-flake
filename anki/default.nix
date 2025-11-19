{ inputs }:

inputs.nixpkgs.legacyPackages
|> builtins.mapAttrs (
  _system: pkgs:
  let
    # Collect all external addon inputs (those starting with "addon-dev-")
    externalAddonInputs =
      inputs
      |> builtins.attrNames
      |> builtins.filter (name: builtins.match "addon-dev-.*" name != null)
      |> map (name: {
        inherit name;
        src = inputs.${name};
      });

    # External addon configurations (optional configs and overrides)
    externalAddonConfigs = import ./addons/external.nix;

    addons = import ./addons/default.nix {
      inherit pkgs externalAddonInputs externalAddonConfigs;
    };
    anki-with-addons = pkgs.anki.withAddons addons;
  in
  {
    default = pkgs.symlinkJoin {
      name = "anki";
      paths = [ anki-with-addons ];
      nativeBuildInputs = [ pkgs.qt6.wrapQtAppsHook ];
      buildInputs = [
        pkgs.qt6.qtbase
        pkgs.qt6.qtsvg
        pkgs.qt6.qtdeclarative
        pkgs.qt6.qtwayland
      ];
      postBuild = ''
        wrapQtApp "$out/bin/anki"
      '';
    };
  }
)
