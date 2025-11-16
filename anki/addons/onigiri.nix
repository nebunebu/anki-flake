{ pkgs, ... }:

(pkgs.anki-utils.buildAnkiAddon {
  pname = "onigiri";
  version = "1.0.3-beta";
  src = pkgs.fetchFromGitHub {
    owner = "thepeacemonk";
    repo = "Onigiri";
    rev = "8ddff7c183962c0d0f43c05c055a8e86744e6026";
    hash = "sha256-xhA0pC6S4PuNppOQku+h35xwc4XcDGW1fWgqmE3ub8g=";
  };
}).withConfig
  {
    userFiles =
      pkgs.runCommand "anki-user-files"
        {
          pfpBlue = ../../assets/pfp-blue.png;
          bkg = ../../assets/rose_pine_maze.png;
          sbkg = ../../assets/rose_pine_shape.png;
          pfpBkg = ../../assets/rose_pine_circle.png;
        }
        ''
          # mkdir -p $out/fonts
          mkdir -p $out/main_bg
          mkdir -p $out/profile
          mkdir -p $out/profile_bg
          mkdir -p $out/sidebar_bg
          # mkdir -p $out/user_themes
          cp "$pfpBlue" "$out/profile/pfp-blue.png"
          cp "$bkg" "$out/main_bg/rose_pine_maze.png"
          cp "$sbkg" "$out/sidebar_bg/rose_pine_shape.png"
          cp "$bkg" "$out/profile_bg/rose_pine_maze.png"
        '';
    config = {
      "userName" = "nebu";
      "statsTitle" = "Today's Stats";
      "studyNowText" = "Study Now";
      "hideProfileBar" = false;
      "hideWelcomeMessage" = false;
      "hideDeckCounts" = false;
      "hideNativeHeaderAndBottomBar" = true;
      "proHide" = false;
      "maxHide" = false;
      "sidebarCollapsed" = false;
      "showCongratsProfileBar" = true;
      "congratsMessage" = "Congratulations! You have finished this deck for now.";
      "showWelcomePopup" = false;
      "heatmapShape" = ../../assets/check.svg;
      "heatmapShowStreak" = true;
      "heatmapShowMonths" = true;
      "heatmapShowWeekdays" = true;
      "heatmapShowWeekHeader" = true;
      "onigiriWidgetLayout" = {
        "grid" = {
          "studied" = {
            "pos" = 0;
            "row" = 1;
            "col" = 1;
            "display_name" = "Studied Card";
          };
          "time" = {
            "pos" = 1;
            "row" = 1;
            "col" = 1;
            "display_name" = "Time Card";
          };
          "pace" = {
            "pos" = 2;
            "row" = 1;
            "col" = 1;
            "display_name" = "Pace Card";
          };
          "retention" = {
            "pos" = 3;
            "row" = 1;
            "col" = 1;
            "display_name" = "Retention Card";
          };
          "heatmap" = {
            "pos" = 4;
            "row" = 2;
            "col" = 4;
            "display_name" = "Heatmap";
          };
        };
        "archive" = { };
      };
      "externalWidgetLayout" = {
        "grid" = {
          "691162538.add_clock_to_deck_browser" = {
            "grid_position" = 0;
            "row_span" = 1;
            "column_span" = 1;
            "display_name" = "Hours";
          };
          "643961895.add_battery_widget" = {
            "grid_position" = 1;
            "row_span" = 1;
            "column_span" = 1;
            "display_name" = "Power";
          };
          "629799722.add_sticky_to_deck_browser" = {
            "grid_position" = 2;
            "row_span" = 1;
            "column_span" = 1;
            "display_name" = "Sticky";
          };
          "519723565.add_weather_to_deck_browser" = {
            "grid_position" = 3;
            "row_span" = 1;
            "column_span" = 1;
            "display_name" = "Global";
          };
        };
        "archive" = {
          "Neview Cards Farm by Shige.review_cards_heatmap.add_new_count_to_bottom" = {
            "display_name" = "Neview Cards Farm by Shige";
          };
          "73838120.add_Berry_widget" = {
            "display_name" = "Berry";
          };
          "1771074083.views.on_deckbrowser_will_render_content" = {
            "display_name" = "OG Heatmap";
          };
          "1971437351.on_deck_browser_render" = {
            "display_name" = "Accumulated Retention";
          };
        };
      };
      "onigiri_reviewer_bg_mode" = "color";
      "onigiri_reviewer_bg_main_blur" = 0;
      "onigiri_reviewer_bg_main_opacity" = 100;
      "onigiri_reviewer_bg_light_color" = "#faf4ed";
      "onigiri_reviewer_bg_dark_color" = "#191724";
      "onigiri_reviewer_bg_image_light" = "";
      "onigiri_reviewer_bg_image_dark" = "";
      "onigiri_reviewer_bg_image_mode" = "single";
      "onigiri_reviewer_bg_blur" = 0;
      "onigiri_reviewer_bg_opacity" = 100;
      "onigiri_reviewer_bottom_bar_bg_mode" = "main";
      "onigiri_reviewer_bottom_bar_bg_light_color" = "#faf4ed";
      "onigiri_reviewer_bottom_bar_bg_dark_color" = "#1f1d2e";
      "onigiri_reviewer_bottom_bar_bg_image" = "";
      "onigiri_reviewer_bottom_bar_bg_blur" = 0;
      "onigiri_reviewer_bottom_bar_bg_opacity" = 100;
      "onigiri_reviewer_bottom_bar_match_main_blur" = 5;
      "onigiri_reviewer_bottom_bar_match_main_opacity" = 90;
      "onigiri_profile_page_bg_mode" = "image";
      "onigiri_profile_page_bg_light_color1" = "#faf4ed";
      "onigiri_profile_page_bg_dark_color1" = "#191724";
      "onigiri_profile_page_bg_light_color2" = "#f2e9e1";
      "onigiri_profile_page_bg_dark_color2" = "#1f1d2e";
      "modern_menu_profile_bg_mode" = "accent";
      "modern_menu_profile_bg_color_light" = "#faf4ed";
      "modern_menu_profile_bg_color_dark" = "#191724";
      "modern_menu_profile_bg_image" = ../../assets/pfp-blue.png;
      "showHeatmapOnProfile" = true;
      "colors" = {
        "light" = {
          "--accent-color" = "#907aa9";
          "--bg" = "#faf4ed";
          "--fg" = "#575279";
          "--icon-color" = "#797593";
          "--icon-color-filtered" = "#907aa9";
          "--fg-subtle" = "#9893a5";
          "--border" = "#dfdad9";
          "--highlight-bg" = "#f2e9e1";
          "--canvas-inset" = "#fffaf3";
          "--button-primary-bg" = "#907aa9";
          "--button-primary-gradient-start" = "#907aa9";
          "--button-primary-gradient-end" = "#907aa9";
          "--new-count-bubble-bg" = "#56949f";
          "--new-count-bubble-fg" = "#faf4ed";
          "--learn-count-bubble-bg" = "#b4637a";
          "--learn-count-bubble-fg" = "#faf4ed";
          "--review-count-bubble-bg" = "#286983";
          "--review-count-bubble-fg" = "#faf4ed";
          "--heatmap-color" = "#907aa9";
          "--heatmap-color-zero" = "#f2e9e1";
          "--star-color" = "#ea9d34";
          "--empty-star-color" = "#dfdad9";
          "--stats-fg" = "#575279";
        };
        "dark" = {
          "--accent-color" = "#c4a7e7";
          "--bg" = "#191724";
          "--fg" = "#e0def4";
          "--icon-color" = "#403d52";
          "--icon-color-filtered" = "#524f67";
          "--fg-subtle" = "#908caa";
          "--border" = "#31748f";
          "--highlight-bg" = "#21202e";
          "--canvas-inset" = "#1f1d2e";
          "--button-primary-bg" = "#393552";
          "--button-primary-gradient-start" = "#c4a7e7";
          "--button-primary-gradient-end" = "#c4a7e7";
          "--new-count-bubble-bg" = "#68a0d9";
          "--new-count-bubble-fg" = "#13375b";
          "--learn-count-bubble-bg" = "#ea9a97";
          "--learn-count-bubble-fg" = "#eb6f92";
          "--review-count-bubble-bg" = "#9ccfd8";
          "--review-count-bubble-fg" = "#3eC8fb0";
          "--heatmap-color" = "#9ccfd8";
          "--heatmap-color-zero" = "#393552";
          "--star-color" = "#f6c177";
          "--empty-star-color" = "#2a283e";
          "--stats-fg" = "#e0def4";
        };
      };
    };
  }
