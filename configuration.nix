{ config, pkgs, zen-browser, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  hardware.graphics.enable = true;
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

  networking.hostName = "nixos";
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

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
    displayManager = {
      sddm.enable = false;
      gdm = {
        enable = true;
        wayland = true;
      };
    };
  };

  services.desktopManager.plasma6.enable = false;

  # Required by illogical-impulse
  programs.hyprland.enable = true;
  services.geoclue2.enable = true;
  
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
  };

  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  # Recommended fonts for illogical-impulse
  fonts.packages = with pkgs; [
    rubik
    nerd-fonts.ubuntu
    nerd-fonts.jetbrains-mono
    noto-fonts
    hack-font
    twemoji-color-font
  ];

  environment.systemPackages = with pkgs; [
    vim wget git
    discord slack zoom-us
    vlc spotify obs-studio cava easyeffects
    tor tor-browser
    zen-browser.packages."${pkgs.system}".twilight
    vscode android-studio docker docker-compose neovim
    kitty alacritty
    virt-manager qemu_full
    nautilus btop htop rsync aria2
    libreoffice-still obsidian anki-bin foliate
    steam lutris heroic qbittorrent
    blender gimp imagemagick inkscape
    brightnessctl dunst fuzzel wofi grim slurp
    wl-clipboard cliphist playerctl pavucontrol
    python3 nodejs yarn rustup go
    bat eza fish starship ripgrep ripgrep-all tree-sitter jq fzf
    postman cameractrls nwg-displays translate-shell mold
    pkgs.bibata-cursors
  ];

  virtualisation.docker.enable = true;
  services.openssh.enable = true;
  networking.firewall.enable = false;

  system.stateVersion = "25.11";
}
