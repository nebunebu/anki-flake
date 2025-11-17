{ pkgs, ... }:
let
  buttons = import ./buttons.nix;
  canvas = import ./canvas.nix;
  card_states = import ./card_states.nix;
  flags = import ./flags.nix;
  scrollbar = import ./scrollbar.nix;
in
pkgs.ankiAddons.recolor.withConfig {
  config = {
    colors =
      flags
      // canvas
      // scrollbar
      // buttons
      // card_states
      // {
        ACCENT_CARD = [
          "Card mode"
          "#585b70"
          "#585b70"
          "--accent-card"
        ];
        ACCENT_NOTE = [
          "Note mode"
          "#585b70"
          "#585b70"
          "--accent-note"
        ];
        ACCENT_DANGER = [
          "Danger"
          "#eb6f92"
          "#eb6f92"
          "--accent-danger"
        ];
        # BORDER = [
        #   "Border"
        #   "#26233a"
        #   "#26233a"
        #   "--border"
        # ];
        BORDER_FOCUS = [
          "Border (focused input)"
          "#f6c177"
          "#f6c177"
          "--border-focus"
        ];
        BORDER_STRONG = [
          "Border (strong)"
          "#585b70"
          "#585b70"
          "--border-strong"
        ];
        BORDER_SUBTLE = [
          "Border (subtle)"
          "#313244"
          "#313244"
          "--border-subtle"
        ];
        FG = [
          "Text"
          "#e0def4"
          "#e0def4"
          # "#39FF14"
          # "#39FF14"
          [
            "--fg"
            "--bs-body-color"
          ]
        ];
        FG_DISABLED = [
          "Text (disabled)"
          "#6e6a86"
          "#6e6a86"
          "--fg-disabled"
        ];
        FG_FAINT = [
          "Text (faint)"
          "#585b70"
          "#585b70"
          "--fg-faint"
        ];
        FG_LINK = [
          "Text (link)"
          "#c4a7e7"
          "#c4a7e7"
          "--fg-link"
        ];
        FG_SUBTLE = [
          "Text (subtle)"
          "#585b70"
          "#585b70"
          "--fg-subtle"
        ];
        HIGHLIGHT_BG = [
          "Highlight background"
          "#585b70"
          "#585b70"
          "--highlight-bg"
        ];
        HIGHLIGHT_FG = [
          "Highlight text"
          "#e0def4"
          "#e0def4"
          "--highlight-fg"
        ];
        # NOTE: Good
        SELECTED_BG = [
          "Selected Bg"
          "#f6c177"
          "#f6c177"
          "--selected-bg"
        ];
        # NOTE: Good
        SELECTED_FG = [
          "Selected Fg"
          "#191724"
          "#191724"
          "--selected-fg"
        ];
        SHADOW = [
          "Shadow"
          "#21202e"
          "#21202e"
          "--shadow"
        ];
        SHADOW_FOCUS = [
          "Shadow  =focused input)"
          "#585b70"
          "#585b70"
          "--shadow-focus"
        ];
        SHADOW_INSET = [
          "Shadow (inset)"
          "#39FF14"
          "#39FF14"
          "--shadow-inset"
        ];
        SHADOW_SUBTLE = [
          "Shadow (subtle)"
          "#39FF14"
          "#39FF14"
          "--shadow-subtle"
        ];
      };
    version = {
      major = 3;
      minor = 1;
    };
  };
}
