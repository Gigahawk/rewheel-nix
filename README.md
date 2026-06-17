## Adding Forks

> For details, see
> https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/javascript.section.md#yarn-berry-v3v4-javascript-yarn-v3-v4

1. Enter this flake's devshell with `nix develop`
2. Navigate to a local clone of the fork (ensure you have the target commit
   checked out)
3. Run
   `yarn-berry-fetcher missing-hashes {path-to-repo}/yarn.lock > packages/missing-hashes_{owner-name}.json`
4. Run
   `yarn-berry-fetcher prefetch {path-to-repo}/yarn.lock packages/missing-hashes_{owner-name}.json`.
   Copy the hash that it prints to stdout
5. Add an entry to `modules/packages.nix`
