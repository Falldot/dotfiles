{ config, inputs, lib, pkgs,...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.systemd-boot.configurationLimit = 2;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # NixOS Network Configuration
  networking = {
    hostName = "falldot";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  programs.fish.enable = true;

  # User
  users = {
    users = {
      falldot = {
        shell = pkgs.fish;
        isNormalUser = true;
        extraGroups = [ "wheel" "networkmanager" "docker" "video" "audio" ];      
      };
    };
  };

  # NixOS enable Flakes
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };

    # Weekly garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 10d";
    };
  };

  # Timezone and locale
  time.timeZone = "Asia/Sakhalin";
  i18n = {
    defaultLocale = "ru_RU.UTF-8";
    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "ru_RU.UTF-8/UTF-8"
    ];
  };

  console = {
    earlySetup = true;
    font = "cyr-sun16";
    # keyMap = "ruwin_alt_sh-UTF-8";
    useXkbConfig = true;
  };

  services = {
    # blueman.enable = true;
    # dbus.packages = [pkgs.gnome.gnome-keyring pkgs.gcr];
    # gnome.gnome-keyring = {
    #   enable = true;
    # };
  
    # Enable SSH
    openssh = {
      enable = true;
      # Forbid root login through SSH.
      # settings = {
      #   PermitRootLogin = "no";
      #   PasswordAuthentication = true;
      # };
    };
    # Enable pipewire
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  sound.enable = true;
  
  # security = {
  #   rtkit.enable = true;
  # };

  # Enable hardware support
  hardware = {
    opengl.enable = true;
    opengl.driSupport = true;
    keyboard.zsa.enable = true;
    bluetooth.enable = true;

    # Enable braodcom chip for bluetooth
    enableAllFirmware = true;
    pulseaudio.enable = false;
  };

  # Enable virtualisation and docker support
  virtualisation = {
    # libvirtd.enable = true;
    docker = {
      enable = true;
      daemon.settings = {
        data-root = "/opt/docker";
      };
    };
  };

  # Enable proprietary software
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
  ];

  system.stateVersion = "23.05";
}