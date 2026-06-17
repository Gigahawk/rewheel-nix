{ inputs, ... }:
{
  perSystem =
    {
      self',
      pkgs,
      ...
    }:
    {
      packages = rec {
        rewheel_Gigahawk = pkgs.callPackage ../packages/rewheel.nix {
          src' = pkgs.fetchFromGitHub {
            owner = "Gigahawk";
            repo = "rewheel";
            rev = "dc606961fc2621cd45087f3dea226828bf2f1f4f";
            hash = "sha256-O6aUjhKDR4s6StnLZG9MpNqvKSajxS2jIBemRB6GDRY=";
          };
          missingHashes = ../packages/missing-hashes_Gigahawk.json;
          offlineCacheHash = "sha256-IYhMD27JPmyWpqMjgJ3zLt2GE0679WEoIzi8gafjus4=";
          patches = [ ];
        };
        rewheel_non-bin = pkgs.callPackage ../packages/rewheel.nix {
          src' = pkgs.fetchFromGitHub {
            owner = "non-bin";
            repo = "rewheel";
            rev = "59bc4346eddfe5ebc7e25d7a955227db2e16a21f";
            hash = "sha256-F0HuwlVS2IKHgQ+5hgfw9jHW8scdpDYlhd/PQorlc5o=";
          };
          missingHashes = ../packages/missing-hashes_non-bin.json;
          offlineCacheHash = "sha256-HtbYV4sbnF9QbyVhuUHkSVuIEauKSsm+uyV9+X1qURM=";
        };

        rewheel_bwees = pkgs.callPackage ../packages/rewheel.nix {
          src' = pkgs.fetchFromGitHub {
            owner = "bwees";
            repo = "rewheel";
            rev = "f537ec976824ca02db953330043c16e0474b81c2";
            hash = "sha256-dDRh6XaXhvUDjW/oP0cMTg0LuKoaC/R5n34Px0yuBLU=";
          };
          missingHashes = ../packages/missing-hashes_bwees.json;
          offlineCacheHash = "sha256-HtbYV4sbnF9QbyVhuUHkSVuIEauKSsm+uyV9+X1qURM=";
        };

        rewheel_fromeijn = pkgs.callPackage ../packages/rewheel.nix {
          src' = pkgs.fetchFromGitHub {
            owner = "fromeijn";
            repo = "rewheel-main";
            rev = "c101b9a279d4e3a6119820e07db76a77fa6ed574";
            hash = "sha256-KIgi1alk7qyYHP4sDEpUIdL6JdHh8+C2WRAkTnNK5EE=";
          };
          missingHashes = ../packages/missing-hashes_fromeijn.json;
          offlineCacheHash = "sha256-HtbYV4sbnF9QbyVhuUHkSVuIEauKSsm+uyV9+X1qURM=";
        };

        rewheel_wiredquill = pkgs.callPackage ../packages/rewheel.nix {
          src' = pkgs.fetchFromGitHub {
            owner = "wiredquill";
            repo = "rewheel";
            rev = "785f1cafc86de716df9d4daeb486020441dd9574";
            hash = "sha256-D4AiFzQzR0iOHdRDucn2o7tdqGdmfQmM2z4Eva993TY=";
          };
          missingHashes = ../packages/missing-hashes_wiredquill.json;
          offlineCacheHash = "sha256-HtbYV4sbnF9QbyVhuUHkSVuIEauKSsm+uyV9+X1qURM=";
        };

        default = rewheel_Gigahawk;
      };
    };
}
