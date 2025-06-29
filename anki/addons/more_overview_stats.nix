{ pkgs, ... }:

(pkgs.anki-utils.buildAnkiAddon {
  pname = "anki-more-overview-stats";
  version = "2.1.36";
  src = pkgs.fetchFromGitHub {
    owner = "patrick-mahnkopf";
    repo = "Anki_More_Overview_Stats";
    rev = "v2.1.36";
    hash = "sha256-Mt6EqFmQChgOf7Y/JufFoL/fgpl5yBoqiyULlAbLqrE=";
  };
}).withConfig
  {
    config = {
      "Date Format" = "us";
      "Note Correction Factors" = {
        "Test" = 1;
      };
      "Show table for finished decks" = true;
      "Stat Colors" = {
        "Days until done" = "#e0def4";
        "Done on Date" = "#e0def4";
        "Learned" = "#31748f";
        "Learning" = "#eb6f92";
        "Mature" = "#c4a7e7";
        "New" = "#ebbcba";
        "Percent" = "#908caa";
        "Review" = "#31748f";
        "Suspended" = "#f6c177";
        "Total" = "#e0def4";
        "Unseen" = "#eb6f92";
        "Young" = "#9ccfd8";
      };
    };
  }
