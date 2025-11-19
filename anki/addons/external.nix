# External addon configurations
#
# This file defines configurations for external addons added via flake inputs.
# Each key should match the input name (e.g., "addon-dev-my-plugin").
#
# Available options for each addon:
#   - pname: Package name (default: derived from input name)
#   - version: Version string (default: "dev")
#   - config: Addon configuration passed to .withConfig
#   - overrideAttrs: Function to override derivation attributes
#
# Example:
# {
#   addon-dev-my-plugin = {
#     pname = "my-plugin";
#     version = "1.0.0";
#     config = {
#       "Enable Feature" = true;
#       "Theme" = "dark";
#     };
#     overrideAttrs = oldAttrs: {
#       nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [ python3 ];
#       buildPhase = ''
#         # Custom build commands
#       '';
#     };
#   };
#
#   addon-dev-simple-addon = {
#     # Minimal config - just use defaults
#   };
# }
{ }
