let
  config = {
    # Ideally we would limit this to just lamdera
    # but I couldn't get that to work...
    allowUnfree = true;
  };
in
with import <nixpkgs> { inherit config; };
mkShell {
  buildInputs = [
    # Required for normal readline behavior
    # https://github.com/nix-community/nix-direnv/issues/384
    bashInteractive
    elmPackages.elm
    elmPackages.elm-language-server
    elmPackages.lamdera
    nodejs_18
  ];
  shellHook = ''
    export ELM_HOME="$PWD/.elm"
    export PATH="$PWD/node_modules/.bin:$PATH"
  '';
}
