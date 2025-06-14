import 'package:bfp_weapon_cfg_flutter/models/weapon.dart';
import 'package:flutter/material.dart';

Future<void> checkWeaponNum({
  required BuildContext context,
  required List<Weapon> weapons,
  required String value,
  required Weapon w,
  required TextEditingController? weaponNumController,
  required Function(void Function()) setStateCallback,
}) async {
  final newVal = int.tryParse(value);
  if (newVal == null) return;

  Weapon? other;
  for (var o in weapons) {
    if (o != w && o.weaponNum == newVal) {
      other = o;
      break;
    }
  }

  // If found, confirm swap
  if (other != null) {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Duplicated weaponNum'),
        content: Text(
          'Another weapon "${other?.name}" already uses weaponNum $newVal.\n'
          'This will swap their IDs. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setStateCallback(() {
        w.swapWeaponNumWith(other!);
      });
    } else {
      // revert input
      setStateCallback(() {
        weaponNumController?.text = w.weaponNum?.toString() ?? '';
      });
    }
  } else {
    // Don't duplicate, just assign
    setStateCallback(() {
      w.weaponNum = newVal;
      w.properties['weaponNum'] = newVal.toString();
    });
  }
}