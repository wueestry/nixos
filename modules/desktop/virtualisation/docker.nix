#
# Docker
#

{ config, pkgs, user, ... }:

{
    virtualisation = {
        docker = {
            enable = true;
            enableNvidia = true;
        };
    };

    users.groups.docker.members = [ "${user}" ];

    environment.systemPackages = with pkgs; [
        docker-compose
    ];
}