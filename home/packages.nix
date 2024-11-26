{ pkgs, agenix, ... }: {
  home.packages = with pkgs;
    [
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

      oil

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
      glab

      # development
      shellcheck
      python3
      #nodejs_latest
      #yarn
      asdf-vm

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
      aws-sso-cli
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
      llama-cpp

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

        xclip

        vlc
      ]
    else
      [ ]);
}
