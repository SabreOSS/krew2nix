{
  description =
    "Makes kubectl plug-ins from the Krew repository accessible to Nix";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        krewPluginsList = pkgs.callPackage ./krew-plugins-list.nix { };
        krewPlugins = pkgs.callPackage ./krew-plugins.nix { krewPluginsList = krewPluginsList; };
        kubectl = pkgs.callPackage ./kubectl.nix { krewPlugins = krewPlugins; };
      in
      { packages = krewPlugins // { inherit kubectl; }; });
}
