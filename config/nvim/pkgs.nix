with import <nixpkgs> { }; [
  neovim
  fzf
  ripgrep
  git
  lazygit

  # sh
  nodePackages.bash-language-server
  shfmt
  shellcheck

  prettierd
  eslint_d

  # nix
  statix
  nixfmt

  # C/C++
  cpplint
  cppcheck
  clang-tools
  cmake-language-server

  texlab
  typst-lsp
  proselint

  omnisharp-roslyn

  typescript

  yaml-language-server
  lemminx
  xmlformat

  dockerfile-language-server-nodejs
  docker-compose-language-service

  buf-language-server

  (lua5_1.withPackages (ps: with ps; [ luacheck ]))
  lua-language-server
  stylua

  # python
  (python3.withPackages (ps: with ps; [ python-lsp-server debugpy ]))
  pylint
  black
]
