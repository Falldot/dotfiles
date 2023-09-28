{ config, pkgs, ... }: 
let 
  username = "falldot";
  homeDirectory = "/home/${username}";
  configHome = "${homeDirectory}/.config";
  defaultPkgs = with pkgs; [
    docker-compose
    zip
    unzip
    htop
    direnv
  ];
in {
  imports = [
    "${fetchTarball {
        url = "https://github.com/msteen/nixos-vscode-server/tarball/master";
        sha256 = "0sz8njfxn5bw89n6xhlzsbxkafb6qmnszj4qxy2w0hw2mgmjp829";
      }
    }/modules/vscode-server/home.nix"
  ]
  ++ builtins.concatMap import [
      ./pkgs
  ];

  services.vscode-server.enable = true;

  xdg = {
    inherit configHome;
    enable = true;
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    nix-direnv.enable = true;
  };

  home = {
    inherit username homeDirectory;
    stateVersion = "23.05";
    packages = defaultPkgs;
  };

  systemd.user.startServices = "sd-switch";
  
  
  programs.home-manager.enable = true;
}