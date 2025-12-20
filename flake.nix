{
  description = "Rahul's NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    
    # Hyprland
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    # Illogical Impulse dotfiles
    illogical-impulse = {
      url = "github:xBLACKICEx/end-4-dots-hyprland-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };    
   

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, hyprland, illogical-impulse, zen-browser, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit hyprland illogical-impulse zen-browser; }; 
      modules = [ 
        ./configuration.nix 
      ];
    };
  };
}
