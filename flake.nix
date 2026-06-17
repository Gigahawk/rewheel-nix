{
  description = "A generic flake-parts based flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    # Last commit with nodejs_18
    nixpkgs_old.url = "nixpkgs/e6031a0";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
