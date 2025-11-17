{ pkgs, ... }:

(pkgs.anki-utils.buildAnkiAddon {
  pname = "ankiw";
  version = "11-16-2025";
  src = pkgs.fetchFromGitHub {
    owner = "hikaru-y";
    repo = "anki21-addon-ankiwebview-inspector";
    rev = "f93954e485cce825bd547549127b6192788d9005";
    hash = "sha256-E6wlVDMhrmcVLezaEy7OOYX0kYWd86/IUwxoC386Llc=";
  };
}).withConfig
  {
    config = {
    };
  }
