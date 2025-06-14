import 'package:bfp_weapon_cfg_flutter/models/weapon.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/dialogs/notification_dialog.dart';
import 'package:flutter/material.dart';

Future<void> confirmRemoveWeapon({
  required BuildContext context,
  required Weapon w,
  required List<Weapon> weapons,
  required Function(void Function()) setStateCallback,
  required bool mounted,
}) async {
  final num = w.weaponNum?.toString() ?? '';
  final name = w.name;
  final sure = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Remove weapon?'),
      content: Text(
        'Are you sure you want to remove weaponNum $num ($name)?',
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(ctx).pop(false),
        ),
        ElevatedButton(
          child: const Text('OK'),
          onPressed: () => Navigator.of(ctx).pop(true),
        ),
      ],
    ),
  );
  
  if (sure == true) {
    setStateCallback(() {
      weapons.remove(w);
    });
    NotificationDialog.show(mounted ? context : context, 'Removed weapon $num ($name)');
  }
}