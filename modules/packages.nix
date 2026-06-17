{ inputs, ... }:
{
  perSystem =
    {
      self',
      pkgs,
      system,
      ...
    }:
    let
      pkgs_old = import inputs.nixpkgs_old { inherit system; };
    in
    {
      packages = {
        default = pkgs.callPackage ../packages/rewheel.nix { };
      };
    };
}
