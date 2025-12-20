{ config, pkgs, hyprland, illogical-impulse, zen-browser, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      illogical-impulse.nixosModules.default
    ];

  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {

    modesetting.enable = true;

    powerManagement.enable = false;

    powerManagement.finegrained = false;

    open = true;

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };  

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.xserver.enable = true;

  services.xserver.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
  
  programs.hyprland = {
    enable = true;
    package = hypr.hyprland;
    xwayland.enable = true;
  };



  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.rnadagoud = {
    isNormalUser = true;
    description = "Rahul Nadagoud";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  illogical-impulse = {
    enable = true;
    
    hyprland = {
      monitor = [ ",preferred,auto,1" ];
      package = hypr.hyprland;
      xdgPortalPackage = hypr.xdg-desktop-portal-hyprland;
      ozoneWayland.enable = true;
    };
    
    theme = {
      cursor = {
        package = pkgs.bibata-cursors;
        theme = "Bibata-Modern-Ice";
      };
    };
    
    dotfiles = {
      fish.enable = true;
      kitty.enable = true;
    };
  };



  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
   vim 
   wget
   git
   # comms and social
   discord
   slack
   zoom
   # media & Entertainment
   vlc
   spotify
   obs-studio
   cava
   easyeffects
   # Browsers & Web
   tor
   tor-browser
   zen-browser.packages."${pkgs.system}".twilight
   # development Tools
   vscode
   android-studio
   docker
   docker-compose
   neovim
   kitty
   alacritty
   mold
   # Virtualization
   virt-manager
   qemu_full
   # File Management & Utilities
   kdePackages.dolphin
   nautilus
   btop
   rsync
   aria2
   # Office & Productivity
   libreoffice-still
   obsidian
   anki
   foliate
   # gaming
   steam
   lutris
   heroic
   qbittorrent
   # Graphics & Design
   blender
   gimp
   imagemagick
   inkscape
   # System Utilities
   brightnessctl
   dunst
   fuzzel
   wofi
   hyprshot
   wl-clipboard
   cliphist
   playerctl
   pavucontrol
   # Fonts
   noto-fonts
   nerd-fonts.jetbrains-mono
   hack-font
   twemoji-color-font
   # Development Languages/Runtimes
   python315
   nodejs_24
   yarn
   rustup
   go
   # CLI Tools
   bat
   eza
   fish
   starship
   ripgrep
   ripgrep-all
   tree-sitter
   jq
   fzf
   # Other Applications
   postman
   cameractrls
   nwg-displays
   translate-shell
  ];


  virtualisation.docker.enable = true;

  services.openssh.enable = true;

  networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11"; # Did you read the comment?

}
