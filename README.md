# nixos-dotfiles
My NixOS configurations in a flake

## Installation

Activate flakes in your /etc/nixos/configuration.nix

Clone this repo, replace "yuugen" by a user of your choice and replace ./hosts/<machine>/hardware-configuration.nix with your own (in /etc/nixos/hardware-configuration.nix)

Run `sudo nixos-rebuild boot --flake .#your-machine`

for example, I build it using

`sudo nixos-rebuild boot --flake .#omen`

Then just reboot and enjoy !
