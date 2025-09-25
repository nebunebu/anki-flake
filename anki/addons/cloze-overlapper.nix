{ pkgs, ... }:

(pkgs.anki-utils.buildAnkiAddon rec {
  pname = "cloze_overlapper";
  version = "1.0.2";
  src = pkgs.fetchFromGitHub {
    owner = "saiyr";
    repo = "cloze-overlapper";
    rev = "v${version}";
    hash = "sha256-1j5kmlFcrUtZgTuajgcFKaRXCMdVTKz9hq2v3FlnnXQ=";
  };
}).overrideAttrs
  (old: {
    sourceRoot = ".";

    nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.python3Packages.pyqt6 ];

    buildPhase = ''
      runHook preBuild

      # Dynamically find the key directories
      UI_DIR=$(find . -type d -name "designer" -print -quit)
      FORMS_DIR=$(find . -type d -name "forms" -print -quit)

      if [ -z "$UI_DIR" ]; then echo "ERROR: Could not find 'designer' directory."; exit 1; fi
      if [ -z "$FORMS_DIR" ]; then echo "ERROR: Could not find 'forms' directory."; exit 1; fi

      TARGET_PY_FILE="$FORMS_DIR/qt6.py"
      # Ensure the target file is empty before we start
      > "$TARGET_PY_FILE"

      # Loop through each .ui file, compile it, and append to the target file
      for ui_file in $(find "$UI_DIR" -name "*.ui"); do
        echo "Compiling and appending $ui_file..."
        pyuic6 "$ui_file" >> "$TARGET_PY_FILE"
        # Add a newline for better separation between compiled forms
        echo "" >> "$TARGET_PY_FILE"
      done

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      PYTHON_SRC_DIR=$(find . -type d -name "cloze_overlapper" -print -quit)
      if [ -z "$PYTHON_SRC_DIR" ]; then echo "ERROR: Could not find 'cloze_overlapper' source directory."; exit 1; fi

      ADDON_DEST="$out/share/anki/addons/${old.pname}"
      install -d "$ADDON_DEST"
      cp -r $PYTHON_SRC_DIR/* "$ADDON_DEST/"

      runHook postInstall
    '';
  })
