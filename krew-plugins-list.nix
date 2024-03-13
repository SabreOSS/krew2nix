{ autoPatchelfHook
, buildPackages
, fetchFromGitHub
, go
, lib
, stdenv
, targetPlatform
, unzip
}:
let
  inherit (builtins) filter length elem any replaceStrings;
  inherit (lib)
    head nameValuePair assertMsg filesystem id listToAttrs concatStringsSep
    licenses;
  krewIndex = fetchFromGitHub {
    owner = "kubernetes-sigs";
    repo = "krew-index";
    rev = "400c05bc0e4e64a287a8773435d5d4f45dd615d2";
    sha256 = "sha256-fIgenKymQO9qD1GQRysB1GRWfdGiMVp88X/MVks8ClE=";
  };
  allPluginDefinitions = filesystem.listFilesRecursive "${krewIndex}/plugins";
in {
  allPluginDefinitions = allPluginDefinitions;
}