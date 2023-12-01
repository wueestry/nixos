{
  config,
  pkgs,
  ...
}: let
  power-menu = pkgs.writeShellScriptBin "power-menu" ''
    #!/bin/sh

    uptime="`uptime -p | sed -e 's/up //g'`"
    host=`hostname`

    # Options
    shutdown=''
    reboot=''
    lock='󰌾'
    suspend='󰒲'
    logout='󰍃'
    yes=''
    no=""

    rofi_cmd() {
      rofi -dmenu -p "Uptime: $uptime" -mesg "Uptime: $uptime" -theme power
    }

    run_rofi() {
      echo -e "$shutdown\n$reboot\n$cancel" | rofi_cmd
    }

    case "$(run_rofi)" in
    	$shutdown)
    		systemctl poweroff
    		;;
    	$reboot)
    		systemctl reboot
    		;;
    esac
  '';
  launcher = pkgs.writeShellScriptBin "launcher" ''
    #!/bin/sh

    rofi -show drun theme launch

  '';
in {
  home.packages = with pkgs; [
    power-menu
    launcher
    wl-clipboard
    wtype
  ];

  xdg.configFile."rofi/colors.rasi".text = ''
    * {
        background:     #1E1D2FFF;
        background-alt: #282839FF;
        foreground:     #D9E0EEFF;
        selected:       #7AA2F7FF;
        active:         #ABE9B3FF;
        urgent:         #F28FADFF;
    }
  '';

  xdg.configFile."rofi/fonts.rasi".text = ''
    * {
        font: "MesloLGS NF 10";
    }
  '';

  xdg.configFile."rofi/launch.rasi".text = ''
    /*****----- Configuration -----*****/
    configuration {
        modi:                       "drun";
        show-icons:                 true;
        icon-theme: 				"WhiteSur";
        display-drun:               "";
        display-run:                "";
        display-filebrowser:        "";
        display-window:             "";
        display-emoji:              "󰞅";
        display-clipboard:          "";
        drun-display-format:        "{name}";
        window-format:              "{t}";
    }

    /*****----- Global Properties -----*****/
    @import                          "./colors.rasi"
    @import                          "./fonts.rasi"

    /*****----- Main Window -----*****/
    window {
        transparency:                "real";
        location:                    center;
        anchor:                      center;
        fullscreen:                  false;
        width:                       400px;
        x-offset:                    0px;
        y-offset:                    0px;

        enabled:                     true;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               12px;
        border-color:                @selected;
        background-color:            @background;
        cursor:                      "default";
    }

    /*****----- Main Box -----*****/
    mainbox {
        enabled:                     true;
        spacing:                     0px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px 0px 0px 0px;
        border-color:                @selected;
        background-color:            transparent;
        children:                    [ "inputbar", "listview" ];
    }

    /*****----- Inputbar -----*****/
    inputbar {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     15px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @selected;
        background-color:            @selected;
        text-color:                  @background;
        children:                    ["prompt", "entry" ];
    }

    prompt {
        enabled:                     true;
        background-color:            inherit;
        text-color:                  inherit;
    }
    textbox-prompt-colon {
        enabled:                     true;
        expand:                      false;
        str:                         "::";
        background-color:            inherit;
        text-color:                  inherit;
    }
    entry {
        enabled:                     true;
        background-color:            inherit;
        text-color:                  inherit;
        cursor:                      text;
        placeholder:                 "Search...";
        placeholder-color:           inherit;
    }

    /*****----- Listview -----*****/
    listview {
        enabled:                     true;
        columns:                     1;
        lines:                       6;
        cycle:                       true;
        dynamic:                     true;
        scrollbar:                   false;
        layout:                      vertical;
        reverse:                     false;
        fixed-height:                true;
        fixed-columns:               true;
        
        spacing:                     5px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @selected;
        background-color:            transparent;
        text-color:                  @foreground;
        cursor:                      "default";
    }
    scrollbar {
        handle-width:                5px ;
        handle-color:                @selected;
        border-radius:               0px;
        background-color:            @background-alt;
    }

    /*****----- Elements -----*****/
    element {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     8px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @selected;
        background-color:            transparent;
        text-color:                  @foreground;
        cursor:                      pointer;
    }
    element normal.normal {
        background-color:            @background;
        text-color:                  @foreground;
    }
    element selected.normal {
        background-color:            @background-alt;
        text-color:                  @foreground;
    }
    element-icon {
        background-color:            transparent;
        text-color:                  inherit;
        size:                        32px;
        cursor:                      inherit;
    }
    element-text {
        background-color:            transparent;
        text-color:                  inherit;
        highlight:                   inherit;
        cursor:                      inherit;
        vertical-align:              0.5;
        horizontal-align:            0.0;
    }

    /*****----- Message -----*****/
    error-message {
        padding:                     15px;
        border:                      2px solid;
        border-radius:               12px;
        border-color:                @selected;
        background-color:            @background;
        text-color:                  @foreground;
    }
    textbox {
        background-color:            @background;
        text-color:                  @foreground;
        vertical-align:              0.5;
        horizontal-align:            0.0;
        highlight:                   none;
    }
  '';

  xdg.configFile."rofi/power.rasi".text = ''
        /*****----- Configuration -----*****/
    configuration {
        show-icons:                 false;
    }

    /*****----- Global Properties -----*****/
    @import                          "./colors.rasi"
    @import                          "./fonts.rasi"

    /*
    USE_BUTTONS=YES
    */

    /*****----- Main Window -----*****/
    window {
        /* properties for window widget */
        transparency:                "real";
        location:                    east;
        anchor:                      east;
        fullscreen:                  false;
        width:                       115px;
        x-offset:                    -15px;
        y-offset:                    0px;

        /* properties for all widgets */
        enabled:                     true;
        margin:                      0px;
        padding:                     0px;
        border:                      3px solid;
        border-radius:               8px;
        border-color:                @selected;
        cursor:                      "default";
        background-color:            @background;
    }

    /*****----- Main Box -----*****/
    mainbox {
        enabled:                     true;
        spacing:                     15px;
        margin:                      0px;
        padding:                     15px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @selected;
        background-color:            transparent;
        children:                    [ "listview" ];
    }

    /*****----- Inputbar -----*****/
    inputbar {
        enabled:                     true;
        spacing:                     0px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px;
        border-radius:               0px;
        border-color:                @selected;
        background-color:            transparent;
        text-color:                  @foreground;
        children:                    [ "textbox-prompt-colon", "prompt"];
    }

    dummy {
        background-color:            transparent;
    }

    textbox-prompt-colon {
        enabled:                     true;
        expand:                      false;
        str:                         "";
        padding:                     12px 16px;
        border-radius:               0px;
        background-color:            @urgent;
        text-color:                  @background;
    }
    prompt {
        enabled:                     true;
        padding:                     12px;
        border-radius:               0px;
        background-color:            @active;
        text-color:                  @background;
    }

    /*****----- Message -----*****/
    message {
        enabled:                     true;
        margin:                      0px;
        padding:                     12px;
        border:                      0px solid;
        border-radius:               8px;
        border-color:                @selected;
        background-color:            @background-alt;
        text-color:                  @foreground;
    }
    textbox {
        background-color:            inherit;
        text-color:                  inherit;
        vertical-align:              0.5;
        horizontal-align:            0.5;
        placeholder-color:           @foreground;
        blink:                       true;
        markup:                      true;
    }
    error-message {
        padding:                     12px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @selected;
        background-color:            @background;
        text-color:                  @foreground;
    }

    /*****----- Listview -----*****/
    listview {
        enabled:                     true;
        columns:                     1;
        lines:                       5;
        cycle:                       true;
        dynamic:                     true;
        scrollbar:                   false;
        layout:                      vertical;
        reverse:                     false;
        fixed-height:                true;
        fixed-columns:               true;
        
        spacing:                     15px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @selected;
        background-color:            transparent;
        text-color:                  @foreground;
        cursor:                      "default";
    }

    /*****----- Elements -----*****/
    element {
        enabled:                     true;
        spacing:                     0px;
        margin:                      0px;
        padding:                     20px 0px;
        border:                      0px solid;
        border-radius:               8px;
        border-color:                @selected;
        background-color:            @background-alt;
        text-color:                  @foreground;
        cursor:                      pointer;
    }
    element-text {
        font:                        "feather bold 24";
        background-color:            transparent;
        text-color:                  inherit;
        cursor:                      inherit;
        vertical-align:              0.5;
        horizontal-align:            0.5;
    }
    element selected.normal {
        background-color:            var(selected);
        text-color:                  var(background);
    }
  '';
}
