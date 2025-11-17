{ pkgs, ... }:

(pkgs.anki-utils.buildAnkiAddon {
  pname = "ankiwebview_inspector";
  version = "11-16-2025";
  src = pkgs.fetchFromGitHub {
    owner = "hikaru-y";
    repo = "anki21-addon-ankiwebview-inspector";
    rev = "f93954e485cce825bd547549127b6192788d9005";
    hash = "sha256-E6wlVDMhrmcVLezaEy7OOYX0kYWd86/IUwxoC386Llc=";
  };
}).overrideAttrs
  (_: {
    installPhase = ''
      runHook preInstall
      
      # 1. ORIGINAL COPY LOGIC from anki-utils.nix:
      mkdir -p "$out/$installPrefix/user_files"
      find . -mindepth 1 -maxdepth 1 | xargs -d'\n' mv -t "$out/$installPrefix/"
      
      # 2. FIX: Move files from nested 'src' up one level:
      # Use mv with a wildcard to move the *contents* of src to the addon root.
      # The `mv` command is safer here since the files are already inside the output path.
      mv "$out/$installPrefix/src/"* "$out/$installPrefix/"
      
      # 3. Clean up the now-empty nested 'src' directory.
      rmdir "$out/$installPrefix/src"
      
      runHook postInstall
    '';

  })

# { pkgs, ... }:
#
# pkgs.anki-utils.buildAnkiAddon {
#   pname = "wview";
#   version = "1.0.0";
#   src = ./anki21-addon-ankiwebview-inspector;
# }
