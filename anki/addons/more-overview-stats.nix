{ pkgs, ... }:

(
  (pkgs.anki-utils.buildAnkiAddon {
    pname = "anki-more-overview-stats";
    version = "dev";
    src = pkgs.fetchFromGitHub {
      owner = "patrick-mahnkopf";
      repo = "Anki_More_Overview_Stats";
      rev = "239dccd68e2cc9e845b78947f6426b47a05582ea";
      hash = "sha256-I5FjE7h2CaHzUuPFSK8DA91CJB+ngBs8ZF1UJo9gdNM=";
    };
  }).overrideAttrs
  (oldAttrs: {
    # use raw string
    postPatch = (oldAttrs.postPatch or "") + ''
      sed -i "147s/'/r'/" data.py
    '';
  })
).withConfig
  {
    config = {
      "Date Format" = "us";
      "Note Correction Factors" = {
        "Test" = 1;
      };
      "Show table for finished decks" = true;
      "Stat Colors" = {
        "Days until done" = "#31748f";
        "Done on Date" = "#c4a7e7";
        "Learned" = "#31748f";
        "Learning" = "#eb6f92";
        "Mature" = "#c4a7e7";
        "New" = "#ebbcba";
        "Percent" = "#908caa";
        "Review" = "#31748f";
        "Suspended" = "#f6c177";
        "Buried" = "#f6c177";
        "Total" = "#31748f";
        "Unseen" = "#eb6f92";
        "Young" = "#9ccfd8";
      };
    };
  }
