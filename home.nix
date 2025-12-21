{ config, pkgs, illogical-impulse, ... }:

{
  imports = [
    illogical-impulse.homeManagerModules.default
  ];

  programs.illogical-impulse = {
    enable = true;

    dotfiles = {
      fish.enable = true;
      kitty.enable = true;
      starship.enable = true;
    };
  };

  home.username = "rnadagoud";
  home.homeDirectory = "/home/rnadagoud";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
  ];

  programs.home-manager.enable = true;
}
