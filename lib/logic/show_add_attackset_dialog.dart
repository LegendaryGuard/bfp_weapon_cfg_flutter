import 'package:flutter/material.dart';
import 'package:bfp_weapon_cfg_flutter/models/attackset.dart';
import 'package:bfp_weapon_cfg_flutter/models/weapon.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/attack_slot/build_attack_slot_dropdown.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/dialogs/warning_dialog.dart';

Future<void> showAddAttackSetDialog({
  required BuildContext context,
  required List<AttackSet> attackSets,
  required List<Weapon> loadedWeapons,
  required Function(void Function()) setStateCallback,
}) async {
  // Find next available attackset index
  int nextIndex = 1;

  if (loadedWeapons.isEmpty) {
    await WarningDialog.show(
      context,
      'bfp_weapon.cfg must be loaded first!\n'
      'Go to Weapons tab and load a weapon config file.',
    );
    return;
  }

  if (attackSets.isNotEmpty) {
    final maxIndex = attackSets.map((as) => as.index).reduce((a, b) => a > b ? a : b);
    nextIndex = maxIndex + 1;
  }

  final tempAttackSet = AttackSet(
    nextIndex,
    List.filled(5, 0),
    '',
    '',
    [],
  );
  
  // Create controllers for each attack slot
  final slotControllers = List.generate(5, (_) => TextEditingController(text: '0'));

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text('Add new attack set'),
          content: SizedBox(
            width: double.maxFinite,
            height: 600,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('attackset $nextIndex', style: TextStyle(fontSize: 18),),
                  const SizedBox(height: 12),
                  ...List.generate(5, (slot) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: BuildAttackSlotDropdown(
                        slot: slot,
                        controller: slotControllers[slot],
                        loadedWeapons: loadedWeapons,
                        onChanged: (value) {
                          final weaponNum = int.tryParse(value);
                          if (weaponNum != null) {
                            tempAttackSet.attacks[slot] = weaponNum;
                          }
                        },
                      ),
                    );
                  }),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'modelPrefix',
                      hintText: 'e.g. bfp1-',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) => tempAttackSet.modelPrefix = v.trim(),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'defaultModel',
                      hintText: 'e.g. bfp1-kyah',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (v) => tempAttackSet.defaultModel = v.trim(),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(ctx, false),
            ),
            ElevatedButton(
              child: const Text('Add'),
              onPressed: () {
                if (tempAttackSet.attacks[0] == 0
                 || tempAttackSet.attacks[1] == 0
                 || tempAttackSet.attacks[2] == 0
                 || tempAttackSet.attacks[3] == 0
                 || tempAttackSet.attacks[4] == 0) {
                  WarningDialog.show(
                    context,
                    'attacks cannot be none'
                  );
                  return;
                }
                if (tempAttackSet.modelPrefix.isEmpty || 
                    tempAttackSet.defaultModel.isEmpty) {
                  WarningDialog.show(
                    context,
                    'modelPrefix and defaultModel are required'
                  );
                  return;
                }
                Navigator.pop(ctx, true);
              },
            ),
          ],
        );
      },
    ),
  );

  if (confirmed == true) {
    setStateCallback(() {
      attackSets.add(tempAttackSet);
    });
  }
  
  // Dispose controllers
  for (final controller in slotControllers) {
    controller.dispose();
  }
}
