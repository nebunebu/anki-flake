{ inputs }:

inputs.nixpkgs.legacyPackages
|> builtins.mapAttrs (
  _system: pkgs:
  let
    addons = import ./addons/default.nix { inherit pkgs; };
  in
  {
    default = pkgs.anki.withAddons addons;
  }
)
