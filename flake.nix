{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    nixvim,
    flake-parts,
    self,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      perSystem = {
        pkgs,
        system,
        ...
      }: let
        nixvimLib = nixvim.lib.${system};
        nixvim' = nixvim.legacyPackages.${system};
        nixvimModule = {...}@args: {
          inherit pkgs;
          module = import ./nixvim-config args;
        };
        nvim-no-copilot = nixvim'.makeNixvimWithModule (nixvimModule {enable-copilot = false;});
        nvim-with-copilot = nixvim'.makeNixvimWithModule (nixvimModule {enable-copilot = true;});
      in {
        _module.args.pkgs = import self.inputs.nixpkgs {
          inherit system;
          config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
             "copilot.vim"
          ];
        };
        checks = {
          default = nixvimLib.check.mkTestDerivationFromNixvimModule (nixvimModule { enable-copilot=true; });
        };    
        packages = {
          inherit nvim-no-copilot nvim-with-copilot;
          nvim = nvim-with-copilot;
        };
      };
    };
}
