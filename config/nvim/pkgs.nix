with import <nixpkgs> { }; [
  neovim
  fzf
  ripgrep
  git
  lazygit
  gnumake

  # sh
  nodePackages.bash-language-server
  shfmt
  shellcheck

  prettierd
  eslint_d

  # nix
  statix
  nixfmt
  rnix-lsp

  # C/C++
  cpplint
  cppcheck
  clang-tools
  cmake-language-server

  texlab
  typst-lsp
  proselint

  omnisharp-roslyn

  openscad-lsp

  nodePackages.typescript-language-server

  yaml-language-server
  xmlformat

  nodePackages.dockerfile-language-server-nodejs
  docker-compose-language-service

  buf-language-server

  (lua5_1.withPackages (ps: with ps; [ ]))
  lua-language-server
  stylua

  # python
  (python3.withPackages (ps: with ps; [ python-lsp-server debugpy ]))
  pylint
  black
]
