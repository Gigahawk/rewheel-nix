{ inputs, ... }:
{
  perSystem =
    {
      self',
      pkgs,
      ...
    }:
    {
      devShells = {
        default = pkgs.mkShell {
          packages = [
            self'.packages.default
            pkgs.yarn-berry_3
            pkgs.yarn-berry_3.yarn-berry-fetcher
          ];
        };
      };
    };
}
