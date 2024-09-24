# Nix system configuration

![Branch build for main](https://github.com/hjdskes/system/actions/workflows/branch.yml/badge.svg?branch=main) ![Cachix cache](https://github.com/hjdskes/system/actions/workflows/cachix.yml/badge.svg)


This repository manages system configurations for all of my machines.

## Structure

This repository is a [flake](https://nixos.wiki/wiki/Flakes). All system configurations are defined
in [flake.nix](./flake.nix).

## Installing a configuration

### Standalone home-manager

First make sure that nix is installed (installation instructions for [Linux](https://nixos.org/download.html#nix-install-linux) & [macOS](https://nixos.org/download.html#nix-install-macos)). Now you can use the standalone home-manager configuration using

```bash
home-manager switch --flake .#mac
```
