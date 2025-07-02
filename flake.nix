{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs = {
    self,
    nixpkgs,
  }: {
    #packages.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.hello;
    apps.x86_64-linux.foo = {
      type = "app";
      program = builtins.toString (nixpkgs.legacyPackages.x86_64-linux.writeShellScript "foo" ''
        #!/usr/bin/env bash
        # Get the path to the submodule
        SUBMODULE_PATH="SpotX-Bash"

        if [ ! -d "$SUBMODULE_PATH/.git" ] && [ ! -f "$SUBMODULE_PATH/.git" ]; then
          echo "Submodule not initialized. Run: git submodule update --init"
          exit 1
        fi

        HASH=$(git rev-parse HEAD:"$SUBMODULE_PATH")
        echo "$HASH"
      '');
    };

    defaultApp = self.apps.foo;
  };
}
