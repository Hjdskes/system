{ config, pkgs, ... }: {
  imports = [ ./nixpkgs.nix ];

  users.users.jente = {
    description = "Jente Hidskes Ankarberg";
    home = "${if pkgs.stdenvNoCC.isDarwin then "/Users" else "/home"}/${config.users.users.jente.name}";
    shell = pkgs.bashInteractive;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.jente = import ./home-manager;
  };

  environment = {
    shells = with pkgs; [ bashInteractive ];
  };

  time.timeZone = "Europe/Stockholm";
}
