{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    nix-linguist.url = "github:Convez/nix-linguist";
  };
  outputs = {self, nixpkgs, nix-linguist, ...}:
  let
      supportedArchitectures = [ "x86_64-linux" ];
      forEachArch = f: nixpkgs.lib.genAttrs supportedArchitectures (system: f {
        inherit system;
        pkgs = import nixpkgs { inherit system; };
      });
      devShells = forEachArch ({ pkgs, system }: {
        default = pkgs.mkShellNoCC {
          inputsFrom = [nix-linguist.devShells.${system}.default];
          packages = with pkgs; [
            gcc
            nixd
            gleam
            erlang
            rebar3
          ];
        };
      });
  in
  {
    inherit devShells;
  };
}
