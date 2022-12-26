# Nix system configuration

![Branch build for main](https://github.com/hjdskes/system/actions/workflows/branch.yml/badge.svg?branch=main) ![Cachix cache](https://github.com/hjdskes/system/actions/workflows/cachix.yml/badge.svg)


This repository manages system configurations for all of my Linux, (soon) NixOS and (soon) macOS machines.
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
{ config, pkgs, ... }: {
  home-manager.users.jente = import ./home-manager/home.nix;
}
```

This means that [./modules/home-manager/default.nix](./modules/home-manager/default.nix) is fully compatible as a standalone configuration, managed with the `home-manager` CLI.
This allows close replication of any user config for any system running Nix. These configurations are defined in the `homeConfigurations` output.

## Installing a Configuration

### Non-NixOS prerequisite: install Nix

Nix has to be installed on your system. You can follow the official installation guidelines for [Linux](https://nixos.org/download.html#nix-install-linux) and [macOS](https://nixos.org/download.html#nix-install-macos).

Note that this step is naturally skipped on NixOS since `nix` is the package manager by default.

## System bootstrapping

### NixOS

Follow the installation instructions, then run

```bash
sudo nixos-install --flake github:hjdskes/system#jente@x86_64-linux
```

### macOS/Linux

Clone this repository into `~/.nixpkgs` with

```bash
git clone https://github.com/hjdskes/system ~/.nixpkgs
```

You can bootstrap a new nix-darwin system using

```bash
darwin-rebuild switch --flake .#jente@aarch64-darwin
```

or a home-manager configuration using

```bash
home-manager switch --flake .#jente@x86_64-linux
```
