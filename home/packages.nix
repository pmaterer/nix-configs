{ pkgs, agenix, system, ... }: {
  home.packages = with pkgs;
    [
      go-migrate
      sqlc
      air

      # admin tools
      coreutils
      neofetch
      colordiff
      ripgrep
      tree
      yq
      gnutar
      gnumake
      gnused
      unzip
      sd

      dnsmasq

      zoxide

      step-cli
      step-ca

      ffmpeg

      agenix.packages.${system}.default

      oils-for-unix

      just

      csvlens

      # etc
      imagemagick
      nerdfonts
      cowsay
      ponysay
      fortune
      lolcat
      gmailctl
      graphviz

      # fonts
      monaspace
      fantasque-sans-mono

      # git
      ghorg
      pre-commit
      #glab

      # development
      shellcheck
      python3
      nodejs_latest
      yarn
      #bun # switch to unstable
      asdf-vm
      devenv

      # networking
      ipcalc
      curl

      #nix
      nixfmt-classic
      nil # nix lsp

      # devops
      tflint
      #terragrunt
      terrascan
      terramate

      # vms
      packer

      # cloud
      awscli

      # k8s
      kubectl
      kubernetes-helm
      kubectx
      argo
      argocd
      eks-node-viewer
      kubie

      # crossplane
      upbound

      # charmbracelet
      glow
      vhs
      pop
      gum
      skate

      # ai
      ollama

      regctl
    ] ++ (if pkgs.stdenv.isLinux then
      with pkgs; [
        terraform-docs
        vagrant
        spotify-player
        iw
        qemu
        OVMF
        libvirt
        virt-viewer
        virt-manager
        pciutils
        glxinfo
        lshw

        libxslt # for libvirt Terraform

        terraform

        xclip

        vlc

        opendrop

        file
      ]
    else
      [ ]);
}
