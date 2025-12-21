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

  # Override Hyprland settings
  wayland.windowManager.hyprland = {
    enable = true;
    
    settings = {
      # Monitor configuration
      monitor = [
        "Virtual-1,1920x1080,0x0,1"
        # or "DP-1,preferred,auto,1"
      ];
      
      # Input settings (inverted scrolling)
      input = {
        touchpad = {
          natural_scroll = true;  # Inverted/natural scrolling
        };
        sensitivity = 0;
      };
      
      # Cursor theme
      exec-once = [
        "hyprctl setcursor Bibata-Modern-Ice 24"
      ];
    };
    
    # Additional custom config that doesn't fit in settings
    extraConfig = ''
      # Any raw Hyprland config here
      input {
        natural_scroll = yes
      }
    '';
  };


  home.username = "rnadagoud";
  home.homeDirectory = "/home/rnadagoud";
  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
}
