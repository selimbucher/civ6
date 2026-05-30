{
  description = "civ6.ch";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        web = pkgs.stdenv.mkDerivation (finalAttrs: {
          pname = "civ6-web";
          version = "0.0.1";
          src = ./web;

          nativeBuildInputs = [
            pkgs.nodejs
            pkgs.pnpmConfigHook
            pkgs.pnpm
          ];

          pnpmDeps = pkgs.fetchPnpmDeps {
            inherit (finalAttrs) pname version src;
            fetcherVersion = 3;
            hash = "sha256-i9GYU9YkDWo2KhJGkK1HvgCRLs+m2wjA7a/TCUfw5p8=";
          };

          buildPhase = "pnpm run build";
          installPhase = "cp -r build $out";
        });

        server = pkgs.buildGoModule {
          pname = "civ6-server";
          version = "0.0.1";
          src = ./.;
          vendorHash = null;
        };

      in
      {
        packages.web = web;
        packages.server = server;
        packages.default = web;

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs
            pnpm
            go
          ];
        };
      }
    ) // {
      nixosModules.default = { config, lib, pkgs, ... }:
        let
          cfg = config.services.civ6;
          system = pkgs.stdenv.hostPlatform.system;
          web = self.packages.${system}.web;
          server = self.packages.${system}.server;
        in {
          options.services.civ6.enable = lib.mkEnableOption "civ6.ch";

          config = lib.mkIf cfg.enable {
            services.postgresql = {
              enable = true;
              ensureDatabases = [ "civ6" ];
              ensureUsers = [{
                name = "civ6";
                ensureDBOwnership = true;
              }];
            };

            systemd.services.civ6-server = {
              description = "civ6.ch Go API server";
              wantedBy = [ "multi-user.target" ];
              after = [ "network.target" "postgresql.service" ];
              serviceConfig = {
                ExecStart = "${server}/bin/server";
                Restart = "on-failure";
                DynamicUser = true;
                Environment = "DATABASE_URL=postgres://civ6@localhost/civ6?sslmode=disable";
              };
            };

            systemd.services.civ6-web = {
              description = "civ6.ch SvelteKit server";
              wantedBy = [ "multi-user.target" ];
              after = [ "network.target" "civ6-server.service" ];
              serviceConfig = {
                ExecStart = "${pkgs.nodejs}/bin/node ${web}/index.js";
                Restart = "on-failure";
                DynamicUser = true;
                Environment = "PORT=3000";
              };
            };

            services.caddy = {
              enable = true;
              virtualHosts."civ6.ch".extraConfig = ''
                reverse_proxy localhost:3000
              '';
            };
          };
        };
    };
}