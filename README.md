# Bid For Power Weapon & Attack Set Config Editor

A modern GUI editor for `bfp_weapon.cfg`(and `bfp_weapon2.cfg`) and `bfp_attacksets.cfg` files used in the ancient Quake 3 mod **Bid For Power**. Built with Flutter for cross-platform compatibility.

## Features

- Edit all weapon and attack set properties in a user-friendly interface
- Intuitive search and organization of weapons and attack sets
- Load and save `bfp_weapon.cfg`/`bfp_weapon2.cfg` files
- Load and save `bfp_attacksets.cfg` files
- Add new weapons with all required properties
- Custom attack sets with different weapons for some player models
- Swap weapon IDs when conflicts occur
- Dark/Light mode support
- Cross-platform support (Windows, Linux, macOS, Android, Web)

## Screenshots
<img src="https://github.com/user-attachments/assets/93368e6f-deea-43ac-a4f2-5705f03e5653" width=500 />
<img src="https://github.com/user-attachments/assets/cac71fc6-010b-40ea-8b27-534041702f15" width=500 />


## Getting Started

### Prerequisites
- Git
- Dart SDK (version 3.3.0 or higher)
- Flutter SDK (version 3.19.0 or higher) _(I highly recommend FVM to manage Flutter SDK versions and it's better handled)_

### Installation from source code
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
    - Select either `bfp_weapon.cfg` or `bfp_weapon2.cfg`

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

5. Load attack sets (requires weapons loaded):
    - Go to Attack sets tab
    - Click the folder icon in the top-right corner
    - Select `bfp_attacksets.cfg`

6. Edit attack sets:
    - Expand any attack set to view its properties
    - Modify properties directly in the input and dropdown fields

7. Add new attack sets (requires weapons loaded):
    - Click the + icon in the top-right corner
    - Fill in attack set details in the dialog
    - Set all required properties

8. Save changes:
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

As for attack sets:

`bfp_attacksets.cfg`

```c
attackset 1
attack 0 21
attack 1 16
attack 2 15
attack 3 23
attack 4 13
modelPrefix bfp1-
defaultModel bfp1-kyah

// ...

end
```

### Icons and assets
Most icons are licensed under [CC BY 3.0.](http://creativecommons.org/licenses/by/3.0/).
Some icons are modified.

Credits: 
- Delapouite
- Lorc

Reference: https://game-icons.net/
