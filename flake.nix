{
  description = "Rahul's NixOS Configuration";

  inputs = {
    # Use nixos-25.11 to match your system.stateVersion
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    
    # Optional: Add unstable for newer packages
    # nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ 
        ./configuration.nix 
      ];
    };
  };
}
