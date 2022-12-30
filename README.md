# Nix system configuration

![Branch build for main](https://github.com/hjdskes/system/actions/workflows/branch.yml/badge.svg?branch=main) ![Cachix cache](https://github.com/hjdskes/system/actions/workflows/cachix.yml/badge.svg)


This repository manages system configurations for all of my Linux, (soon) NixOS and macOS machines.
It is based on [kclejeune's system repository](https://github.com/kclejeune/system).

## Structure

This repository is a [flake](https://nixos.wiki/wiki/Flakes). All system configurations are defined
in [flake.nix](./flake.nix). Platform specific configurations are found in the flake outputs
`darwinConfigurations` and `nixosConfigurations` for macOS and NixOS respectively.

### Overlapping NixOS and nix-darwin

NixOS and nix-darwin configurations share as much overlap as possible in the common module, [./modules/common.nix](./modules/common.nix).
Platform specific modules add onto the common module in [./modules/nixos/default.nix](./modules/nixos/default.nix) and [./modules/darwin/default.nix](./modules/darwin/default.nix) for NixOS and macOS respectively.

### Decoupled home-manager configuration

My home-manager configuration is entirely decoupled from NixOS and nix-darwin configurations.
This means that all of its modules are found in [./modules/home-manager](./modules/home-manager).
These modules are imported into all other configurations in the common module similarly to this:

```nix
{ ... }: {
  home-manager.users.jente = import ./home-manager;
}
```

This means that [./modules/home-manager/default.nix](./modules/home-manager/default.nix) is fully compatible as a standalone configuration, managed with the `home-manager` CLI.
This allows close replication of any user config for any system running Nix. These configurations are defined in the `homeConfigurations` output.

## Installing a configuration

### NixOS

Follow the NixOS installation instructions, then run

```bash
sudo nixos-install --flake github:hjdskes/system#jente@x86_64-linux
```

or, if you cloned the repository to your filesystem,

```bash
sudo nixos-install --flake .#jente@x86_64-linux
```

### macOS with nix-darwin

Install [nix for macOS](https://nixos.org/download.html#nix-install-macos) and [nix-darwin](https://github.com/LnL7/nix-darwin#install) using their linked installation instructions, then run

```bash
darwin-rebuild switch --flake github:hjdskes/system#jente@aarch64-darwin`
```

or, if you cloned the repository to your filesystem,

```bash
darwin-rebuild switch --flake .#jente@aarch64-darwin
```

### Standalone home-manager

First make sure that nix is installed (installation instructions for [Linux](https://nixos.org/download.html#nix-install-linux) & [macOS](https://nixos.org/download.html#nix-install-macos)). Now you can use the standalone home-manager configuration using

```bash
home-manager switch --flake .#jente@x86_64-linux
```
