{ pkgs, ... }:

(
  (pkgs.anki-utils.buildAnkiAddon {
    pname = "global-card-css";
    version = "0.1";
    src =
      pkgs.writeTextDir "global-card-css/__init__.py" # python
        ''
          from aqt import gui_hooks
          from aqt.reviewer import Reviewer

          CSS = r"""
          :root { color-scheme: dark; }
          html, body, .card, #qa {
            background: var(--canvas-elevated, #1f1d2e) !important;
            color: var(--fg, #e0def4) !important;
          }
          """

          def add_css(web_content, context):
              if isinstance(context, Reviewer):
                  web_content.head += f"<style>{CSS}</style>"

          gui_hooks.webview_will_set_content.append(add_css)
        '';
  }).withConfig
  { config = { }; }
)
