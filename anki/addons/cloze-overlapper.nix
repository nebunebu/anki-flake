{ pkgs, ... }:

(pkgs.anki-utils.buildAnkiAddon rec {
  pname = "cloze-overlapper";
  version = "1.0.2";
  src = pkgs.fetchFromGitHub {
    owner = "saiyr";
    repo = "cloze-overlapper";
    rev = "v${version}";
    hash = "sha256-1j5kmlFcrUtZgTuajgcFKaRXCMdVTKz9hq2v3FlnnXQ=";
  };
}).withConfig
  {
    config = {
    };
  }
