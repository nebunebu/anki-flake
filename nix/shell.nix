{ inputs, ... }:
inputs.nixpkgs.legacyPackages
|> builtins.mapAttrs (
  system: pkgs:
  let
    anki = inputs.self.packages.${system}.default;
    eval = inputs.treefmt-nix.lib.evalModule pkgs {
      imports = [ ./treefmt.nix ];
    };
  in
  {
    default = pkgs.mkShell {
      name = "anki-shell";
      packages = [
        pkgs.cowsay
        eval.config.build.wrapper
        anki
      ];
      shellHook = ''
        echo "welcome to your anki dev shell" | cowsay
      '';
    };
  }
)
