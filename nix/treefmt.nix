{
  projectRootFile = "flake.nix";
  programs = {
    # nix
    nixfmt.enable = true;
    deadnix.enable = true;
    statix.enable = true;
    # md
    mdformat.enable = true;
  };

  settings = {
    formatter.deadnix = {
      options = [ "--no-lambda-pattern-names" ];
    };
  };
}
