import 'package:bfp_weapon_cfg_flutter/models/constants.dart';
import 'package:bfp_weapon_cfg_flutter/models/weapon.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/dialogs/warning_dialog.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/fields/build_field.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/fields/build_labeled_field_above.dart';
import 'package:flutter/material.dart';

Future<void> showAddWeaponDialog({
  required BuildContext context,
  required List<Weapon> weapons,
  required bool isDarkMode,
  required Function(void Function()) setStateCallback,
}) async {
  // Prepare temporary weapon
  final temp = Weapon(
    '',
    Map.fromEntries(
      weaponRangeValues.keys.map((k) => MapEntry(k, null)),
    ),
    [],
  );

  // Controllers just for the dialog
  final nameController = TextEditingController(text: temp.name);
  final numController = TextEditingController();

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (_) => StatefulBuilder(
      builder: (ctx, setDlg) => AlertDialog(
        title: const Text('Add new weapon'),
        content: SizedBox(
          width: double.maxFinite,
          height: 500,
          child: Column(
            children: [
              // Weapon name input field
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Weapon name',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (v) => temp.name = v.trim(),
                ),
              ),

              // weaponNum input field
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: TextField(
                  controller: numController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'weaponNum (0–32767)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              // The rest of the weapon properties
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: weaponRangeValues.entries
                        .where((e) => e.key != 'weaponNum')
                        .map((e) {
                      final key = e.key;
                      final range = e.value;
                      final isBool = boolWeaponKeysArr.contains(key);
                      final isAttackType = key == 'attackType';
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: BuildLabeledFieldAbove(
                          keyName: key,
                          inputField: BuildField(
                            w: temp,
                            keyName: key,
                            range: range,
                            isBool: isBool,
                            isAttackType: isAttackType,
                            onWeaponNumCheck: (value, weapon) {
                              final newVal = int.tryParse(value);
                              if (newVal != null) {
                                setDlg(() {
                                  weapon.weaponNum = newVal;
                                  weapon.properties['weaponNum'] = newVal.toString();
                                });
                              }
                            },
                          ),
                          isDarkMode: isDarkMode,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              nameController.dispose();
              numController.dispose();
              Navigator.pop(ctx, false);
            },
          ),
          ElevatedButton(
            child: const Text('Add'),
            onPressed: () {
              final name = temp.name;
              final num = int.tryParse(numController.text);
              // validate
              if (name.isEmpty || num == null) {
                WarningDialog.show(context, 'Weapon name and weaponNum required');
                return;
              }
              // check duplicated weaponNum
              final existingWeapon = weapons.firstWhere(
                (w) => w.weaponNum == num,
                orElse: () => Weapon('', {}, []),
              );
              
              if (existingWeapon.name.isNotEmpty) {
                WarningDialog.show(context,'weaponNum $num (${existingWeapon.name}) already exists');
                return;
              }
              // commit to temp
              temp.properties['weaponNum'] = num.toString();
              nameController.dispose();
              numController.dispose();
              Navigator.pop(ctx, true);
            },
          ),
        ],
      ),
    ),
  );

  if (confirmed == true) {
    setStateCallback(() {
      weapons.add(temp);
    });
  }
}