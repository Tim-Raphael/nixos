# Config  

A modular configuration for NixOS using flakes.

## Folder Structure 
```
├── flake.lock
├── flake.nix 
├── hosts 
│   └── default 
├── modules
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

- **home-manager**: Configuration for user-specific programs. Gets built together with the system. 
- **system**: Core system modules.

### `overlays`

Contains Nix overlays.
