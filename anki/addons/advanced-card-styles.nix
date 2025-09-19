{ pkgs, ... }:

(pkgs.anki-utils.buildAnkiAddon {
  pname = "advanced-card-styles";
  version = "0.7";
  src = pkgs.fetchFromGitHub {
    owner = "AnKing-VIP";
    repo = "Advanced-Card-Styles";
    rev = "v0.7";
    # replace after prefetch:
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
}).withConfig
  {
    # This add-on is UI-driven; it doesn’t really expose
    # a meaningful JSON config surface. Keep it empty.
    config = { };
  }
