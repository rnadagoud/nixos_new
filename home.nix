{ config, pkgs, illogical-flake, ... }:

{
  imports = [
    illogical-flake.homeManagerModules.default
  ];

  programs.illogical-impulse = {
    enable = true;
    dotfiles = {
      fish.enable = true;
      kitty.enable = true;
      starship.enable = true;
    };
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  gtk = {
    enable = true;
    
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
    
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
      size = 24;
    };
    
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };
  
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "adw-gtk3-dark";
      icon-theme = "Adwaita";
      cursor-theme = "Bibata-Modern-Classic";
    };
  };

  home.username = "rnadagoud";
  home.homeDirectory = "/home/rnadagoud";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  home.sessionVariables = {
    QML2_IMPORT_PATH = "${pkgs.qt6.qtdeclarative}/${pkgs.qt6.qtbase.qtQmlPrefix}";
    QML_IMPORT_PATH = "${pkgs.qt6.qtdeclarative}/${pkgs.qt6.qtbase.qtQmlPrefix}";
  };

  programs.fish = {
    enable = true;
    shellInit = ''
      set -g fish_greeting

      set -l color_file "$HOME/.local/state/quickshell/user/generated/terminal/sequences.txt"
      if test -f $color_file
        cat $color_file 2>/dev/null
      end
    '';
  };
  
  home.activation.fixColorScripts = config.lib.dag.entryAfter ["writeBoundary"] ''
    SCRIPT_DIR="$HOME/.config/quickshell/ii/scripts"
    if [ -d "$SCRIPT_DIR" ]; then
      $DRY_RUN_CMD find "$SCRIPT_DIR" -type f \( -name "*.sh" -o -name "*.py" \) -exec chmod +x {} \; 2>/dev/null || true
    fi
  '';
}