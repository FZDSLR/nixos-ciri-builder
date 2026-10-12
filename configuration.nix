{
  lib,
  pkgs,
  ...
}:

{
  imports = [ ./hardware-configuration.nix ];

  mobile.generatedFilesystems.rootfs = lib.mkDefault {
    label = lib.mkForce "NIXOS_SYSTEM_E";
  };

  users.users.fzdslr = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    initialPassword = "nixos";
  };
  security.sudo.wheelNeedsPassword = false;

  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = true;
  };

  networking = {
    hostName = "nixos-ciri";
    networkmanager.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  time.timeZone = "Asia/Shanghai";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "26.05";
}