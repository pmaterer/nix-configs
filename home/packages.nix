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
      unzip

      dnsmasq

      step-cli
      step-ca

      ffmpeg

      agenix.packages.${system}.default

      # etc
      imagemagick
      nerdfonts
      cowsay
      fortune
      lolcat
      gmailctl
      graphviz
      element

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
      nodejs_latest
      yarn
      asdf-vm

      # networking
      ipcalc
      curl

      #nix
      nixfmt-classic
      nil # nix lsp

      # devops
      tflint
      terragrunt
      terrascan

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

      # charmbracelet
      glow
      vhs
      pop
      gum
      skate
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
      ]
    else
      [ ]);
}
