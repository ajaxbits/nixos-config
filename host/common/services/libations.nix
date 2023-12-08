{ config, pkgs, inputs, ... }:
let
  # Fetch the libations recipes from a private repository. Note that there must be a
  # valid SSH key either in the agent of the user executing the `nix` command, or in
  # `/root/.ssh` or this will fail.
  recipes = builtins.fetchGit {
    url = "git@github.com:jnsgruk/libations-recipes";
    rev = "9bd7e4ebe23f9421c3ccec5db20b4bdae2344ace";
  };

  libations = pkgs.buildGoModule {
    pname = "libations";
    version = "unstable-2023-12-08";
    src = pkgs.fetchFromGitHub {
      owner = "jnsgruk";
      repo = "libations";
      rev = "c1d968fdd87e6214ac5c9d50019749d5c05aa939";
      hash = "sha256-Eu0LLQZ4ZB2fdedmpFjlRbJIzoA7ow1LGQtVdoyP2xM=";
    };
    vendorHash = "sha256-Ep3nBl9WZm7skk1cmMS9KI019ZSRSxofbLs2Nrj6HM8=";
    nativeBuildInputs = with pkgs; [ hugo ];
    postConfigure = ''
      # Patch the recipes that were fetched above into the app before building
      cp ${recipes}/recipes.json ./webui/data/drinks.json
      # Generate the Hugo site that's embedded in the app
      go generate
    '';
  };
in
{
  age.secrets = {
    libations-auth-key = {
      file = ../../../secrets/thor-libations-tskey.age;
      owner = "root";
      group = "root";
      mode = "400";
    };
  };

  services.libations = {
    enable = true;
    package = libations;
    tailscaleKeyFile = config.age.secrets.libations-auth-key.path;
  };
}

