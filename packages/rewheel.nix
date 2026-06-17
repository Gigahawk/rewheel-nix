{
  lib,
  stdenv,
  fetchFromGitHub,
  yarn-berry_3,
  static-web-server,
  nodejs,
  makeWrapper,
  src' ? null,
  missingHashes ? ./missing-hashes_non-bin.json,
  offlineCacheHash ? "sha256-HtbYV4sbnF9QbyVhuUHkSVuIEauKSsm+uyV9+X1qURM=",
  ...
}:
let
  src =
    if src' != null then
      src'
    else
      fetchFromGitHub {
        owner = "non-bin";
        repo = "rewheel";
        rev = "59bc4346eddfe5ebc7e25d7a955227db2e16a21f";
        hash = "sha256-F0HuwlVS2IKHgQ+5hgfw9jHW8scdpDYlhd/PQorlc5o=";
      };

  yarn-berry = yarn-berry_3.override { inherit nodejs; };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "rewheel";
  version = "0_unstable_${finalAttrs.src.owner}";

  inherit src;

  nativeBuildInputs = [
    nodejs
    makeWrapper
    yarn-berry
    yarn-berry.yarnBerryConfigHook
  ];

  inherit missingHashes;
  offlineCache = yarn-berry.fetchYarnBerryDeps {
    inherit (finalAttrs) src missingHashes;
    hash = offlineCacheHash;
  };

  postPatch = ''
    substituteInPlace "common/src/utils/applyPatch.js" \
     --replace-fail \
      "@rewheel/common/src/utils/helpers" \
      "@rewheel/common/src/utils/helpers.js"
  '';

  buildPhase = ''
    yarn web:build
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/rewheel
    cp -r . $out/share/rewheel

    mkdir -p $out/bin

    makeWrapper ${nodejs}/bin/node $out/bin/rewheel-patcher \
      --set NODE_PATH "$out/share/rewheel/node_modules" \
      --add-flags "$out/share/rewheel/cli/src/index.js"

    makeWrapper ${static-web-server}/bin/static-web-server $out/bin/rewheel-web \
      --add-flags "--root=$out/share/rewheel/web/dist"

    runHook postInstall
  '';

  meta = {
    description = "OneWheel firmware modification tool";
    # Note: taken down, still available on archive.org
    homepage = "https://rewheel.app";
    license = lib.licenses.gpl3Only;
    platforms = lib.platforms.all;
  };
})
