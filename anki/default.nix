{ inputs }:

inputs.nixpkgs.legacyPackages
|> builtins.mapAttrs (
  system: pkgs:
  let
    # Allow unsupported and broken packages on Darwin since Anki is not fully supported on macOS
    pkgs' =
      if pkgs.stdenv.isDarwin then
        import inputs.nixpkgs {
          inherit system;
          config = {
            allowUnsupportedSystem = true;
            allowBroken = true;
          };
        }
      else
        pkgs;

    addons = import ./addons/default.nix {
      pkgs = pkgs';
      externalAddon = inputs.external-addon or null;
    };
    anki-with-addons = pkgs'.anki.withAddons addons;
  in
  {
    default = pkgs'.symlinkJoin {
      name = "anki";
      paths = [ anki-with-addons ];
      nativeBuildInputs = [ pkgs'.qt6.wrapQtAppsHook ];
      buildInputs = [
        pkgs'.qt6.qtbase
        pkgs'.qt6.qtsvg
        pkgs'.qt6.qtdeclarative
      ]
      ++ pkgs'.lib.optionals pkgs'.stdenv.isLinux [
        pkgs'.qt6.qtwayland
      ];
      postBuild = ''
        wrapQtApp "$out/bin/anki"
      '';
    };
  }
)
