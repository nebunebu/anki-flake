{ pkgs, ... }:

(pkgs.ankiAddons.recolor.withConfig {
  config = {
    colors = {
      ACCENT_CARD = [
        "Card mode"
        "#585b70"
        "#585b70"
        "--accent-card"
      ];
      ACCENT_DANGER = [
        "Danger"
        "#eb6f92"
        "#eb6f92"
        "--accent-danger"
      ];
      ACCENT_NOTE = [
        "Note mode"
        "#585b70"
        "#585b70"
        "--accent-note"
      ];
      BORDER = [
        "Border"
        "#26233a"
        "#26233a"
        "--border"
      ];
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
      BUTTON_BG = [
        "Button background"
        "#313244"
        "#313244"
        "--button-bg"
      ];
      BUTTON_DISABLED = [
        "Button background (disabled)"
        "#313244"
        "#313244"
        "--button-disabled"
      ];
      BUTTON_HOVER = [
        "Button background (hover)"
        "#45475a"
        "#45475a"
        [
          "--button-gradient-start"
          "--button-gradient-end"
        ]
      ];
      BUTTON_HOVER_BORDER = [
        "Button border (hover)"
        "#585b70"
        "#585b70"
        "--button-hover-border"
      ];
      BUTTON_PRIMARY_BG = [
        "Button Primary Bg"
        "#403d52"
        "#403d52"
        "--button-primary-bg"
      ];
      BUTTON_PRIMARY_DISABLED = [
        "Button Primary Disabled"
        "#4484ed"
        "#4484ed"
        "--button-primary-disabled"
      ];
      BUTTON_PRIMARY_GRADIENT_END = [
        "Button Primary Gradient End"
        "#2544a8"
        "#2544a8"
        "--button-primary-gradient-end"
      ];
      BUTTON_PRIMARY_GRADIENT_START = [
        "Button Primary Gradient Start"
        "#2f67e1"
        "#2f67e1"
        "--button-primary-gradient-start"
      ];
      CANVAS = [
        "Background"
        "#191724"
        "#191724"
        [
          "--canvas"
          "--bs-body-bg"
        ]
      ];
      CANVAS_CODE = [
        "Code editor background"
        "##585b70"
        "##585b70"
        "--canvas-code"
      ];
      CANVAS_ELEVATED = [
        "Review"
        "#1f1d2e"
        "#1f1d2e"
        "--canvas-elevated"
      ];
      CANVAS_GLASS = [
        "Background (transparent text surface)"
        "##585b7066"
        "##585b7066"
        "--canvas-glass"
      ];
      CANVAS_INSET = [
        "Background (inset)"
        "#21202e"
        "#21202e"
        "--canvas-inset"
      ];
      CANVAS_OVERLAY = [
        "Background (menu & tooltip)"
        "#26233a"
        "#26233a"
        "--canvas-overlay"
      ];
      FG = [
        "Text"
        "#e0def4"
        "#191724"
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
        "##585b70"
        "##585b70"
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
        "##585b70"
        "##585b70"
        "--fg-subtle"
      ];
      FLAG_1 = [
        "Flag 1"
        "##585b70"
        "##585b70"
        "--flag-1"
      ];
      FLAG_2 = [
        "Flag 2"
        "##585b70"
        "##585b70"
        "--flag-2"
      ];
      FLAG_3 = [
        "Flag 3"
        "##585b70"
        "##585b70"
        "--flag-3"
      ];
      FLAG_4 = [
        "Flag 4"
        "##585b70"
        "##585b70"
        "--flag-4"
      ];
      FLAG_5 = [
        "Flag 5"
        "##585b70"
        "##585b70"
        "--flag-5"
      ];
      FLAG_6 = [
        "Flag 6"
        "##585b70"
        "##585b70"
        "--flag-6"
      ];
      FLAG_7 = [
        "Flag 7"
        "#c9cbff"
        "#c9cbff"
        "--flag-7"
      ];
      HIGHLIGHT_BG = [
        "Highlight background"
        "##585b70"
        "##585b70"
        "--highlight-bg"
      ];
      HIGHLIGHT_FG = [
        "Highlight text"
        "##585b70"
        "##585b70"
        "--highlight-fg"
      ];
      SCROLLBAR_BG = [
        "Scrollbar background"
        "#1e1e2e"
        "#1e1e2e"
        "--scrollbar-bg"
      ];
      SCROLLBAR_BG_ACTIVE = [
        "Scrollbar background (active)"
        "#313244"
        "#313244"
        "--scrollbar-bg-active"
      ];
      SCROLLBAR_BG_HOVER = [
        "Scrollbar background (hover)"
        "##585b70"
        "##585b70"
        "--scrollbar-bg-hover"
      ];
      SELECTED_BG = [
        "Selected Bg"
        "#313244"
        "#313244"
        "--selected-bg"
      ];
      SELECTED_FG = [
        "Selected Fg"
        "##585b70"
        "##585b70"
        "--selected-fg"
      ];
      SHADOW = [
        "Shadow"
        "#1e1e2e"
        "#1e1e2e"
        "--shadow"
      ];
      SHADOW_FOCUS = [
        "Shadow  =focused input)"
        "##585b70"
        "##585b70"
        "--shadow-focus"
      ];
      SHADOW_INSET = [
        "Shadow (inset)"
        "#11111b"
        "#11111b"
        "--shadow-inset"
      ];
      SHADOW_SUBTLE = [
        "Shadow (subtle)"
        "#181825"
        "#181825"
        "--shadow-subtle"
      ];
      STATE_BURIED = [
        "Buried"
        "#7f849c"
        "#7f849c"
        "--state-buried"
      ];
      STATE_LEARN = [
        "Learn"
        "##585b70"
        "##585b70"
        "--state-learn"
      ];
      STATE_MARKED = [
        "Marked"
        "##585b70"
        "##585b70"
        "--state-marked"
      ];
      STATE_NEW = [
        "New"
        "##585b70"
        "##585b70"
        "--state-new"
      ];
      STATE_REVIEW = [
        "Review"
        "##585b70"
        "##585b70"
        "--state-review"
      ];
      STATE_SUSPENDED = [
        "Suspended"
        "##585b70"
        "##585b70"
        "--state-suspended"
      ];
    };
    version = {
      major = 3;
      minor = 1;
    };
  };
})
