# NixOS Configuration

A comprehensive NixOS system configuration for a development-focused setup with Hyprland window manager, integrated dotfiles management, and extensive development tools.

## Overview

This repository contains a complete NixOS configuration for user `rnadagoud` running on an AMD x86_64-linux system. The setup uses **Flakes** for reproducible builds and integrates **Home Manager** for user-level configuration management.

## Directory Structure

- **`configuration.nix`** - System-level NixOS configuration including hardware, services, and system packages
- **`flake.nix`** - Flake configuration defining all inputs and outputs for reproducible builds
- **`flake.lock`** - Lock file for deterministic dependency resolution
- **`home.nix`** - Home Manager configuration for user environment, programs, and theming
- **`hardware-configuration.nix`** - Auto-generated hardware configuration (AMD system with NVMe, SATA, USB)
- **`background/`** - Directory containing background images
- **`my-dots/`** - Dotfiles repository containing configuration files for shell, terminal, and other tools (100s of files)

## Flake Inputs

The flake depends on the following inputs:

- **nixpkgs** - NixOS Unstable channel
- **home-manager** - User configuration management
- **dotfiles-src** - Local dotfiles from `my-dots/` directory
- **illogical-flake** - Integration with illogical-impulse for dotfile management (Fish, Kitty, Starship)
- **zen-browser** - Zen Browser flake for the system

## System Configuration Details

### Hardware

- **CPU**: AMD processor with KVM virtualization support
- **Storage**: NVMe, SATA (AHCI), and USB storage support
- **Filesystem**: ext4 root, vfat boot partition
- **Platform**: x86_64-linux

### Display & GUI

- **Display Manager**: GDM (GNOME Display Manager) with Wayland support
- **Window Manager**: Hyprland with custom configuration
- **Desktop Portal**: XDG Desktop Portal with GTK and Hyprland backends
- **Theme**: adw-gtk3-dark with Adwaita icons and Bibata Modern Classic cursors
- **Plymouth**: Enabled with "owl" theme for boot animation

### GPU & Graphics

- **Graphics**: NVIDIA GPU support (stable branch, open drivers, modesetting enabled)
- **Libraries**: Full Qt5 and Qt6 support, GStreamer plugins for multimedia
- **Wayland Optimization**: OZONE_WL=1 for Chromium-based apps

### Audio & Hardware

- **Audio**: PipeWire with PulseAudio compatibility and ALSA support (32-bit)
- **Bluetooth**: BlueZ and Blueman service enabled
- **Printing**: CUPS printing service enabled
- **Geolocation**: Geoclue2 enabled for location-aware services

### Udev Rules

Custom udev rules configured for:
- Logitech G304 mouse (disable power management)
- Logitech G304 scroll fix via libinput quirks

### Network

- **Hostname**: nixos
- **Network Management**: NetworkManager enabled
- **Firewall**: Disabled
- **SSH**: OpenSSH enabled for remote access

### Time & Locale

- **Timezone**: Asia/Kolkata
- **Locale**: en_US.UTF-8

## User Configuration

- **Username**: rnadagoud
- **Description**: Rahul Nadagoud
- **Groups**: networkmanager, wheel, docker, libvirtd, input

## System Services & Features

### Virtualization

- **libvirtd**: Enabled for KVM virtualization
- **QEMU**: Full QEMU installation for virtual machines
- **Virt-Manager**: GUI for managing virtual machines
- **Docker**: Enabled for containerization

### Shell & Terminal

- **Shell**: Fish with custom initialization and quickshell color integration
- **Terminal**: Kitty and Alacritty
- **Prompt**: Starship
- **Utilities**: direnv with nix-direnv support

### Development Tools

- **Languages**: Python3, Node.js, Rust, Go, GCC
- **Build Tools**: gnumake, mold linker
- **Package Managers**: Yarn, cargo
- **IDEs/Editors**: VSCode, Android Studio, Neovim

### Development Utilities

- **Postman** - API development
- **Tree-sitter** - Syntax parsing
- **ripgrep** & **ripgrep-all** - Fast file searching
- **fzf** - Fuzzy finder
- **jq** - JSON processor
- **bat** - Cat replacement
- **eza** - ls replacement
- **btop** & **htop** - System monitoring

### Media & Entertainment

- **Discord, Slack, Zoom** - Communication
- **VLC, Spotify** - Media
- **OBS Studio, Cava** - Recording & visualization
- **Steam, Lutris, Heroic** - Gaming
- **Blender, GIMP, Inkscape, ImageMagick** - Graphics
- **EasyEffects** - Audio effects

### Productivity

- **LibreOffice** - Office suite
- **Obsidian** - Note taking
- **Anki** - Flashcards
- **Foliate** - E-book reader
- **Notion App Enhanced** - Project management

### Security & Privacy

- **Tor & Tor Browser** - Anonymous browsing
- **ProtonVPN GUI** - VPN client
- **ProtonMail Desktop** - Encrypted email
- **Proton Pass** - Password manager
- **GNOME Keyring & Seahorse** - Credential management
- **Ente Auth** - 2FA authenticator

### System Utilities

- **Hyprland Tools**: hyprlock, hypridle, hyprpaper, hyprshot, hyprpicker, hyprcursor
- **Brightness Control**: brightnessctl
- **Notifications**: dunst
- **Launcher**: fuzzel & wofi
- **Clipboard**: wl-clipboard, cliphist
- **Audio Control**: pavucontrol, playerctl
- **Display Management**: nwg-displays
- **Mouse Control**: libratbag, piper (for Logitech G304)
- **USB Tools**: usbutils, evtest
- **Screenshot**: grim, slurp
- **Misc**: translate-shell, cameractrls

### Fonts

- Rubik, Ubuntu Nerd Font, JetBrains Mono Nerd Font
- Noto Fonts, Hack Font, Twemoji Color Font

## Systemd Services & Timers

### Video Journal Automation

Two systemd services handle video journal management:

1. **journal-folder-create** - Creates daily journal folders
   - Runs at 06:00 AM daily
   - Executes: `/home/rnadagoud/bin/create-journal-folder.sh`

2. **journal-video-stitch** - Stitches video journal clips
   - Runs every 5 minutes
   - Executes: `/home/rnadagoud/bin/stitch-videos.sh`

## Package Management

- **Unfree Packages**: Allowed in nixpkgs config
- **Nix GC**: Automatic weekly garbage collection (keeps 7 days of generations)
- **Store Optimization**: Enabled

## System Version

- **NixOS**: 25.11
- **Home Manager**: 25.11

## Usage

### Building the System

```bash
sudo nixos-rebuild switch --flake .
```

### Updating Flake Inputs

```bash
nix flake update
```

### Rebuilding Home Manager

```bash
home-manager switch --flake .
```

## Features Highlights

✨ **Hyprland Wayland Setup** - Modern tiling window manager with Wayland support  
🎮 **Gaming Ready** - Steam, Lutris, Proton support with NVIDIA driver  
🔧 **Developer Friendly** - Comprehensive dev tools, languages, and environments  
🎨 **Themed & Customized** - GTK dark theme, cursor customization, custom shell configuration  
🔐 **Security Focused** - Encryption tools, VPN, 2FA, Tor integration  
🤖 **AI/Coding Tools** - Claude, Cursor, Gemini CLI integration  
📹 **Automation** - Systemd timers for video journal automation  
🐳 **Container Ready** - Docker and virtualization support included

## Notes

- Hardware configuration is auto-generated by NixOS and may be overwritten during system generation
- Dotfiles in `my-dots/` are managed separately through the illogical-flake integration
- The Zen Browser is available but currently commented out in the system packages
- Custom udev rules are configured for optimal Logitech G304 mouse performance

## License

Configuration as code - customize freely for your needs
