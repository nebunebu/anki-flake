{ pkgs, ... }:

(pkgs.anki-utils.buildAnkiAddon {
  pname = "bury-after-fail-steak";
  version = "dev";
  src = pkgs.fetchFromGitHub {
    owner = "benjaminhottell";
    repo = "anki-bury-after-fail-streak";
    rev = "862ec70ffda51fe19ca6569af9a200e0fe9cfe78";
    hash = "sha256-LcisOuQb1n2+RmRSnj2LeldjbwgtdgxzuV9rV7ddhOI=";
  };
  sourceRoot = "source/bury_after_fail_streak";
}).withConfig
  {
    config = {
      fail_on_hard = true;
      paused = false;
      streak = 3;
    };
  }
