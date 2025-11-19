# Example external addon template
#
# Copy this file and modify it for your external addon.
# External addons are configured just like other custom addons,
# but reference flake inputs for their source.
#
# Usage:
# 1. Add your addon input to flake.nix:
#    addon-dev-my-plugin = {
#      url = "path:/home/user/my-plugin";
#      flake = false;
#    };
#
# 2. Copy this file to your addon name (e.g., my-plugin.nix)
#
# 3. Import it in addons/default.nix:
#    (import ./my-plugin.nix { inherit pkgs inputs; })
{
  pkgs,
  inputs,
}:
let
  # Reference your flake input
  src = inputs.addon-dev-example;
in
# Simple addon (no config)
pkgs.anki-utils.buildAnkiAddon {
  pname = "example";
  version = "dev";
  inherit src;
}

# With configuration:
# (pkgs.anki-utils.buildAnkiAddon {
#   pname = "example";
#   version = "dev";
#   inherit src;
# }).withConfig {
#   config = {
#     "Enable Feature" = true;
#     "Theme" = "dark";
#   };
# }

# With build customization:
# (pkgs.anki-utils.buildAnkiAddon {
#   pname = "example";
#   version = "dev";
#   inherit src;
# }).overrideAttrs (oldAttrs: {
#   nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ pkgs.python3 ];
#   buildPhase = ''
#     # Custom build commands
#   '';
# })
