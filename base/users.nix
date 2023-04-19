{ config, lib, pkgs, ... }:
{
  users.mutableUsers = true;
  users.users.yuugen = {
    isNormalUser = true;
    password = "uuu";
    home = "/home/yuugen";
    description = "The one and only me";
    shell = pkgs.fish;
    uid = 5020130;
    extraGroups = [ "wheel"  "media" "networkmanager" "video" "audio" "docker" ];
  };
}
