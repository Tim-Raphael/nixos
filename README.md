# Config  

A modular configuration for NixOS using flakes.

## Folder Structrue 
```
├── flake.lock
├── flake.nix 
├── hosts 
│   └── default 
├── modules
│   ├── driver 
│   ├── home-manager
│   └── system
└── overlays
```

### `hosts`

Per-Host system configuration.

- **default**: The default host configuration used to build the system for the
first time.

### `modules`

Contains reusable modules organnized into `home-manager` and `system`.

- **driver**: Hardware specific driver.
- **home-manager**: Configuration for user-specific programs. Gets built together with the system. 
- **system**: Core system modules.

### `overlays`

Contains Nix overlays.

## Usage

`sudo nixos-rebuild switch --impure --flake github:Tim-Raphael/nixos#default`

I'm using the --impure flag because the access to a absolute path
(/etc/nixos/hardware-configuration.nix) is forbidden in pure evaluation mode.

