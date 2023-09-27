{pkgs, ...}: {
  programs.git = {
    enable = true;
    # aliases = {
      
    # };
    extraConfig = {
      pull.rebase = false;
      push.autoSetupRemote = true;
    };
    userEmail = "fe.offep@gmail.com";
    userName = "Falldot";
  }
  // (pkgs.sxm.git or {});
}