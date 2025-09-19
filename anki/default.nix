{ inputs }:

inputs.nixpkgs.legacyPackages
|> builtins.mapAttrs (
  _system: pkgs:
  let
    addons = import ./addons/default.nix { inherit pkgs; };
    anki-with-addons = pkgs.anki.withAddons addons;
  in
  {
    default = pkgs.symlinkJoin {
      name = "anki";
      paths = [ anki-with-addons ];
      nativeBuildInputs = [ pkgs.qt6.wrapQtAppsHook ];
      buildInputs = [
        pkgs.qt6.qtbase
        pkgs.qt6.qtwayland
        pkgs.qt6.qtsvg
        pkgs.qt6.qtdeclarative
      ];
      postBuild = ''
        wrapQtApp "$out/bin/anki"
      '';
    };
  }
)
