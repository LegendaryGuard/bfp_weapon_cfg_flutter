# Bid For Power Weapon Config Editor

A modern GUI editor for `bfp_weapon.cfg` and `bfp_weapon2.cfg` files used in the ancient Quake 3 mod **Bid For Power**. Built with Flutter for cross-platform compatibility.

## Features

- Edit all weapon properties in a user-friendly interface
- Intuitive search and organization of weapons
- Load and save `bfp_weapon.cfg`/`bfp_weapon2.cfg` files
- Add new weapons with all required properties
- Swap weapon IDs when conflicts occur
- Dark/Light mode support
- Cross-platform support (Windows, Linux, macOS, Android, Web)

## Screenshots
<img src="https://github.com/user-attachments/assets/981a961e-ff8a-489f-85a1-8e8bedf82069" width=500 />
<img src="https://github.com/user-attachments/assets/fd761b31-7ae3-4908-a129-8a5a999397d9" width=500 />
<img src="https://github.com/user-attachments/assets/14642fcb-4612-4ea0-a81d-08a6a4dbfc15" width=500 />
<img src="https://github.com/user-attachments/assets/18911f48-10c4-426b-9036-a5a8d67d6acc" width=500 />
<img src="https://github.com/user-attachments/assets/f2bd3b45-4f40-42d0-8b64-0da0d3b176d5" width=500 />


## Getting Started

### Prerequisites
- Git
- Dart SDK (version 3.3.0 or higher)
- Flutter SDK (version 3.19.0 or higher) _(I highly recommend FVM to manage Flutter SDK versions and it's better handled)_

### Installation
1. Clone the repository
2. Install dependencies:
```sh
flutter pub get
```
3. Run the application:
```sh
flutter run
```

## Usage
1. Load a config file:
    - Click the folder icon in the top-right corner
    - Select either bfp_weapon.cfg or bfp_weapon2.cfg

2. Edit weapons:
    - Expand any weapon to view its properties
    - Click the edit icon to rename a weapon
    - Modify properties directly in the input fields

3. Add new weapons:
    - Click the + icon in the top-right corner
    - Fill in weapon details in the dialog
    - Set all required properties

4. Save changes:
    - Click the save icon
    - Choose to overwrite or save a new copy
    - For new copies, specify a filename

## Building from source

### Linux
```sh
flutter build linux --release
```

### Android
```sh
flutter build apk --release
```

### Windows
```sh
flutter build windows --release
```

### macOS
```sh
flutter build macos --release
```

### Web
```sh
flutter config --enable-web
flutter build web --release
```

### Files
The config editor specifically works with:

`bfp_weapon.cfg` and `bfp_weapon2.cfg`

These files must follow the standard Bid For Power weapon config format (sample):

```c
(ghost_weapon)
weaponNum 46
attackType rdmissile
weaponTime 1500
randomWeaponTime 0
kiCostAsPct 0
kiPct 0
kiCost 400
chargeAttack 1
chargeAutoFire 0
minCharge 3
maxCharge 6
damage 55
splashDamage 55
chargeDamageMult 0
maxDamage 0
radius 30
explosionRadius 120
chargeRadiusMult 0
chargeExpRadiusMult 40
maxRadius 0
maxExpRadius 0
missileSpeed 2000
homing 0
homingRange 0
range 0
loopingAnim 0
noAttackAnim 0
alternatingXOffset 0
randYOffset 0
randXOffset 0
coneOfFireX 0
coneOfFireY 0
piercing 0
reflective 0
priority 0
blinding 0
extraKnockback 0
railTrail 0
movementPenalty 0
explosionSpawn 9

// ...

end
```