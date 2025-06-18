import 'package:flutter/material.dart';
import 'package:bfp_weapon_cfg_flutter/models/weapon.dart';

class BuildAttackSlotDropdown extends StatelessWidget {
  final int slot;
  final TextEditingController controller;
  final List<Weapon> loadedWeapons;
  final ValueChanged<String> onChanged;

  const BuildAttackSlotDropdown({
    required this.slot,
    required this.controller,
    required this.loadedWeapons,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'attack $slot',
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 200,
          child: loadedWeapons.isEmpty
            ? TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'weaponNum',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(8),
                ),
                onChanged: onChanged,
              )
            : DropdownButtonFormField<String>( 
                value: controller.text,
                decoration: const InputDecoration(
                  labelText: 'Select weapon',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(8),
                ),
                items: [
                  // Display "None" by default
                  const DropdownMenuItem<String>(
                    value: '0',
                    child: Text('None', style: TextStyle(fontStyle: FontStyle.italic)),
                  ),
                  ...loadedWeapons.map((weapon) {
                    return DropdownMenuItem<String>(
                      value: weapon.weaponNum?.toString() ?? '0',
                      child: Text(
                        weapon.name,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    );
                  }),
                ],
                onChanged: (newValue) {
                  if (newValue != null) {
                    controller.text = newValue;
                    onChanged(newValue);
                  }
                },
              ),
        ),
      ],
    );
  }
}
