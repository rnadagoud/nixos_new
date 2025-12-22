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
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
};

  services.xserver = {
    enable = true;
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.displayManager = {
    sddm.enable = false;
    gdm = {
     enable = true;
     wayland = true;
    };
  };

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  
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

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  users.users.rnadagoud = {
    isNormalUser = true;
    description = "Rahul Nadagoud";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
  };

  nixpkgs.config.allowUnfree = true;

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
    zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".twilight   
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
    adw-gtk3
    adwaita-icon-theme    
    (python3.withPackages (ps: with ps; [
      material-color-utilities
      pillow
    ]))
    hyprcursor
    hyprpicker
    hyprlock
    hypridle
    hyprpaper
    hyprshot
    qt6.qtbase
    qt6.qtdeclarative
    qt6.qtwayland
    qt6.qtsvg
    qt6.qtmultimedia
    qt6.qt5compat
    qt6.qttools
    qt6.qttranslations    
    kdePackages.kdeclarative    
    qt5.qtbase
    qt5.qtdeclarative
    qt5.qtwayland
    qt5.qtgraphicaleffects
    qt5.qtquickcontrols
    qt5.qtquickcontrols2
    qt5.qtsvg    
    kdePackages.polkit-kde-agent-1 
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav    
    bluez
    bluez-tools    
    networkmanagerapplet
    xdg-utils
    xwayland
    proton-pass
    protonvpn-gui
    protonmail-desktop
    ente-auth
    notion-app
  ];

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QML2_IMPORT_PATH = "${pkgs.qt6.qtdeclarative}/${pkgs.qt6.qtbase.qtQmlPrefix}";
    QML_IMPORT_PATH = "${pkgs.qt6.qtdeclarative}/${pkgs.qt6.qtbase.qtQmlPrefix}";
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;

  virtualisation.docker.enable = true;
  services.openssh.enable = true;
  networking.firewall.enable = false;

  system.stateVersion = "25.11";
}
