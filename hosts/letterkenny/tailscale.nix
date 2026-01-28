# https://tailscale.com/kb/1096/nixos-minecraft
{
  pkgs,
  config,
  ...
}: {
  systemd.services.tailscale-autoconnect = {
    after = ["network-pre.target" "tailscaled.service"];
    wants = ["network-pre.target" "tailscaled.service"];
    wantedBy = ["multi-user.target"];

    serviceConfig.Type = "oneshot";

    script = with pkgs; ''
      # wait for tailscaled to settle
      sleep 2
      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then
        exit 0
      fi

      authKey="$(cat ${config.age.secrets.tailscale.path})"

      ${tailscale}/bin/tailscale up --auth-key $authKey
    '';
  };
}
