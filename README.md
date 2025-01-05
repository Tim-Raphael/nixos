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

- **default**: The primary host configuration.

### `modules`
Contains reusable modules organnized into `home-manager` and `system`.

- **drivers**: Hardware specific drivers.
- **home-manager**: Configuration for user-specific programs. Gets built together with the system. 
- **system**: Core system modules.

### `overlays`
Contains Nix overlays.

## Usage
`sudo nixos-rebuild switch --flake ./nixos#default`
