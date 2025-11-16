{ pkgs, ... }:

let
  # small folder simulating user-supplied files (used by withConfig.userFiles)
  userFiles = pkgs.runCommand "anki-user-files" { } ''
    mkdir -p $out
    echo "This is a user-provided note." > $out/README.txt
    echo '{"user_setting":"user-value"}' > $out/settings.json
  '';

in
# Build the addon and immediately produce the configured variant.
(pkgs.anki-utils.buildAnkiAddon {
  pname = "example-addon";
  version = "0.0.1";

  # Replace these fetchFromGitHub fields with the real repo you want.
  src = pkgs.fetchFromGitHub {
    owner = "example";
    repo = "anki-example-addon";
    rev = "v0.0.1";
    # placeholder hash — replace with the real one for a real repo
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  # optional: where to find the files inside src (empty string means top-level)
  sourceRoot = "";

  # custom configure/build phases (kept minimal)
  configurePhase = ''
    echo "running configurePhase"
    runHook preConfigure
    runHook postConfigure
  '';

  buildPhase = ''
    echo "running buildPhase"
    runHook preBuild
    runHook postBuild
  '';

  # preserve ELF and symbols (defaults in your function were true; explicit here)
  dontPatchELF = true;
  dontStrip    = true;

  # build-time tools available to processUserFiles (jq used below)
  nativeBuildInputs = [ pkgs.jq ];

  # script that will run after user_files has been merged (runs inside withConfig postBuild)
  processUserFiles = ''
    echo "processUserFiles: mutating user_files if present"
    if [ -f user_files/settings.json ]; then
      jq '.processed = true' user_files/settings.json > user_files/settings.processed.json || true
    fi

    # append a marker to any README in user_files so we can tell it ran
    if [ -f user_files/README.txt ]; then
      echo "Processed by build at $(date -u +%Y-%m-%dT%H:%M:%SZ)" >> user_files/README.txt
    fi
  '';

  meta = with pkgs.lib; {
    description = "Minimal, straightforward example Anki add-on demonstrating all buildAnkiAddon attributes";
    license     = licenses.mit;
    platforms   = platforms.all;
  };
}).withConfig
{
  # addon configuration that will be turned into meta.json
  config = {
    "Date Format" = "%Y-%m-%d";
    "Enable Example" = true;
    "Max Items" = 100;
  };

  # a path to a folder that will be merged into the add-on's user_files (lndir used by the builder)
  userFiles = userFiles;
}
