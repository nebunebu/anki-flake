{ inputs }:

inputs.nixpkgs.legacyPackages
|> builtins.mapAttrs (
  _system: pkgs:
  let
    addons = import ./addons { inherit pkgs inputs; };
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
