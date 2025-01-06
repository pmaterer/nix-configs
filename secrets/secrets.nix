let
  patrick =
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGswahBFnag7+DL+yW3i74lkrJqEXAJYFWt+HBa8/PU1 nix-configs";
  users = [ patrick ];
in {
  "environment.age".publicKeys = users;
  "certs.age".publicKeys = users;
  "tailscale.age".publicKeys = users;
}
