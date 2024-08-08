# https://nix-community.github.io/home-manager/options.xhtml#opt-programs.vscode.enable
{pkgs, ...}: {
  enable = true;
  extensions = with pkgs.vscode-extensions;
    [
      bbenoist.nix
      christian-kohler.path-intellisense
      dbaeumer.vscode-eslint
      editorconfig.editorconfig
      emmanuelbeziat.vscode-great-icons
      esbenp.prettier-vscode
      golang.go
      hashicorp.terraform
      jnoortheen.nix-ide
      ms-azuretools.vscode-docker
      redhat.vscode-yaml
      ms-vscode.makefile-tools
      catppuccin.catppuccin-vsc-icons
      bradlc.vscode-tailwindcss
      streetsidesoftware.code-spell-checker
    ]
    ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      # use pkgs.lib.fakeSha256 to get sha256
      {
        name = "vscode-openapi";
        publisher = "42crunch";
        version = "4.25.3";
        sha256 = "sha256-1kz/M2od2gLSFgqW6LsPHgtm+BwXA+0+7z3HyqNmsOg=";
      }
      {
        name = "vscode-backstage";
        publisher = "intility";
        version = "0.0.4";
        sha256 = "sha256-Yf8ut64EHMK5pUGThyRjWy8VCs7k9Eqe8fHmdS/W21I=";
      }
      {
        name = "vscode-typescript-next";
        publisher = "ms-vscode";
        version = "5.5.20240505";
        sha256 = "sha256-sAiYNbsUGIDWBpmCA5Ogf1AUPqz6DM3aK4j8u07O3hY=";
      }
      {
        name = "spaceduck";
        publisher = "youssefbouzekri";
        version = "1.5.0";
        sha256 = "sha256-WDkQ9XhfTYg/8et85LWZYIBejeNeMi3ZT4qTnEuMdOg=";
      }
      {
        name = "aura-theme";
        publisher = "DaltonMenezes";
        version = "2.1.2";
        sha256 = "sha256-r6pPpvJ1AZsM0RYF+xHsZ4b4QTszN+wELr1SENsUDFA=";
      }
      {
        name = "packer";
        publisher = "4ops";
        version = "0.3.0";
        sha256 = "sha256-aYvTxdd+6ESSEDFtb8hwITVjLdbwTV5ZabpwAywGwVc=";
      }
      {
        name = "vscode-packer-powertools";
        publisher = "sztheory";
        version = "0.3.0";
        sha256 = "sha256-onWnEfZmJztjY8ALt85T0gm7JQOp+4IAdnmkHvYm2iY=";
      }
      {
        name = "nix-env-selector";
        publisher = "arrterian";
        version = "1.0.11";
        sha256 = "sha256-dK0aIH8tkG/9UGblNO0WwxJABBEEKEy4nSmIwdDpf4Q=";
      }
    ];
  userSettings = {
    "workbench.colorTheme" = "Catppuccin Mocha";
    "git.autofetch" = true;
    "git.confirmSync" = false;
    "explorer.confirmDelete" = false;
    "nixfmt.path" = "${pkgs.nixfmt-classic}/bin/nixfmt";
    "[nix]" = {"editor.defaultFormatter" = "jnoortheen.nix-ide";};
    "editor.fontFamily" = "Iosevka Nerd Font Mono";
    "editor.fontSize" = 12;
    "[json]" = { "editor.defaultFormatter" = "vscode.json-language-features"; };
    "[typescript]" = { "editor.defaultFormatter" = "esbenp.prettier-vscode"; };
    "terminal.integrated.sendKeybindingsToShell" = true;
  };
}
