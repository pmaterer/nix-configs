# Secrets

This directory is *not* used directly by the root flake, but rather the [`agenix`](https://github.com/ryantm/agenix) CLI.

To create a new secret run: `agenix -i ~/.ssh/nix-configs -e <secret-name>.age`.

Then configure the secret's encryption key in `secrets.nix`:

```nix
...
"<secret-name>.age".publicKeys = [<user or system>];
...
```
