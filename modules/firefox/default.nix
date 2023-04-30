{ config, inputs, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.firefox;
in
{
  options.modules.firefox.enable = mkEnableOption "firefox";
  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      profiles.default = {
        id = 0;
        name = "Default";
        isDefault = true;

        extensions = with pkgs.nur.repos.rycee.firefox-addons; [
          clearurls
          darkreader
          decentraleyes
          df-youtube
          enhancer-for-youtube
          firefox-translations
          image-search-options
          sponsorblock
          ublock-origin
          rust-search-extension
        ];

        settings = {
          # Telemetry
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.server" = "";
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "browser.tabs.crashReporting.sendReport" = false;
          "devtools.onboarding.telemetry.logged" = false;

          # Disable JS in PDFs
          "pdfjs.enableScripting" = false;

          # Make SSL more strict
          "security.ssl.require_safe_negotiation" = true;

          # Other stuff
          "browser.search.suggest.enabled" = true;
          "browser.urlbar.suggest.topsites" = false;
        };

        # Make it look nicer
        userChrome = "
          * {
            box-shadow: none !important;
            border: 0px solid !important;
          }

          #tabbrowser-tabs {
            --user-tab-rounding: 8px;
          }

          .tab-background {
            border-radius: var(--user-tab-rounding) var(--user-tab-rounding) 0px 0px !important;
            margin: 1px 0 !important;
          }

          #scrollbutton-up, #scrollbutton-down {
            border-top-width: 1px !important;
            border-bottom-width: 0 !important;
          }

          .tab-background:is([selected], [multiselected]):-moz-lwtheme {
                        --lwt-tabs-border-color: rgba(0, 0, 0, 0.5) !important;
                        border-bottom-color: transparent !important;
                    }
                    [brighttext='true'] .tab-background:is([selected], [multiselected]):-moz-lwtheme {
                        --lwt-tabs-border-color: rgba(255, 255, 255, 0.5) !important;
                        border-bottom-color: transparent !important;
                    }

                    /* Container color bar visibility */
                    .tabbrowser-tab[usercontextid] > .tab-stack > .tab-background > .tab-context-line {
                        margin: 0px max(calc(var(--user-tab-rounding) - 3px), 0px) !important;
                    }

                    #TabsToolbar, #tabbrowser-tabs {
                        --tab-min-height: 29px !important;
                    }
                    #main-window[sizemode='true'] #toolbar-menubar[autohide='true'] + #TabsToolbar,
                    #main-window[sizemode='true'] #toolbar-menubar[autohide='true'] + #TabsToolbar #tabbrowser-tabs {
                        --tab-min-height: 30px !important;
                    }
                    #scrollbutton-up,
                    #scrollbutton-down {
                        border-top-width: 0 !important;
                        border-bottom-width: 0 !important;
                    }

                    #TabsToolbar, #TabsToolbar > hbox, #TabsToolbar-customization-target, #tabbrowser-arrowscrollbox  {
                        max-height: calc(var(--tab-min-height) + 1px) !important;
                    }
                    #TabsToolbar-customization-target toolbarbutton > .toolbarbutton-icon,
                    #TabsToolbar-customization-target .toolbarbutton-text,
                    #TabsToolbar-customization-target .toolbarbutton-badge-stack,
                    #scrollbutton-up,#scrollbutton-down {
                        padding-top: 7px !important;
                        padding-bottom: 6px !important;
                    }
        ";
      };
    };
  };
}
