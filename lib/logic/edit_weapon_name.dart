import 'package:bfp_weapon_cfg_flutter/models/weapon.dart';
import 'package:flutter/material.dart';

Future<void> editWeaponName({
  required BuildContext context,
  required Weapon w,
  required Function(void Function()) setStateCallback,
}) async {
  final controller = TextEditingController(text: w.name);
  final newName = await showDialog<String>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Edit weapon name'),
      content: TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: 'Weapon name'),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(ctx).pop(),
        ),
        TextButton(
          child: const Text('Save'),
          onPressed: () => Navigator.of(ctx).pop(controller.text.trim()),
        ),
      ],
    ),
  );
  
  if (newName != null && newName.isNotEmpty) {
    setStateCallback(() => w.name = newName);
  }
}