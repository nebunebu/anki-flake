{
  description = "Anki Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # External addons for development
    # Add multiple addons using the "addon-dev-" prefix:
    #
    # addon-dev-my-plugin = {
    #   url = "path:/home/user/my-plugin";
    #   flake = false;
    # };
    #
    # addon-dev-another-addon = {
    #   url = "path:/home/user/another-addon";
    #   flake = false;
    # };
    #
    # Configure each addon in anki/addons/external.nix
  };

  outputs = inputs: {
    checks = import ./nix/checks.nix { inherit inputs; };
    devShells = import ./nix/shell.nix { inherit inputs; };
    formatter = import ./nix/formatter.nix { inherit inputs; };
    packages = import ./anki { inherit inputs; };
  };
}
