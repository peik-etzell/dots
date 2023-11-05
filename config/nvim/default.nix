let pkgs = import <nixpkgs> { };
in {

  openscad-lsp = pkgs.callPackage ./openscad-language-server.nix { };
}
