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
      # Remove the path line - it's handled at the flake level
    };
  };

  xdg.configFile."hypr/userconfigs.conf".text = ''
    # Monitor configuration
    monitor = Virtual-1,1920x1080,0x0,1

    # Input settings
    input {
      natural_scroll = yes
      touchpad {
        natural_scroll = yes
      }
      sensitivity = 0
    }

    # Cursor theme (End-4 dots usually handle this, but you can force it)
    exec-once = hyprctl setcursor Bibata-Modern-Ice 24
  '';

  home.username = "rnadagoud";
  home.homeDirectory = "/home/rnadagoud";
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;
}
