import 'package:flutter/material.dart';
import 'package:bfp_weapon_cfg_flutter/models/attackset.dart';
import 'package:bfp_weapon_cfg_flutter/models/weapon.dart';
import 'package:bfp_weapon_cfg_flutter/logic/update_attack_slot.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/weapon/weapon_summary_bar.dart';

class BuildAttackSlotTile extends StatelessWidget {
  final AttackSet attackSet;
  final int slot;
  final List<Weapon> loadedWeapons;
  final TextEditingController? controller;
  final Function(void Function()) setStateCallback;

  const BuildAttackSlotTile({
    required this.attackSet,
    required this.slot,
    required this.loadedWeapons,
    required this.controller,
    required this.setStateCallback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentValue = attackSet.attacks[slot];
    
    // Find the weapon for this slot
    Weapon? weaponForSlot = loadedWeapons.firstWhere(
      (weapon) => weapon.weaponNum == currentValue,
      orElse: () => Weapon('Unknown', {}, []),
    );

    return Column(
      children: [
        ListTile(
          title: Row(
            children: [
              Expanded(
                child: Text(
                  'attack $slot',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              
              if (loadedWeapons.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: WeaponSummaryBar(weapon: weaponForSlot),
                ),
              SizedBox(
                width: 300,
                child: loadedWeapons.isEmpty
                  ? TextFormField(
                      controller: controller,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      decoration: const InputDecoration(
                        labelText: 'weaponNum (0-32767)',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onChanged: (value) => updateAttackSlot(
                        attackSet: attackSet,
                        slot: slot,
                        value: value,
                        setStateCallback: setStateCallback,
                      ),
                    )
                  : DropdownButtonFormField<int>( 
                      value: currentValue,
                      decoration: const InputDecoration(
                        labelText: 'Select weapon',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      items: [
                        // Display "None" by default
                        const DropdownMenuItem<int>(
                          value: null,
                          child: Text('None', style: TextStyle(fontStyle: FontStyle.italic)),
                        ),
                        ...loadedWeapons.map((weapon) {
                          return DropdownMenuItem<int>(
                            value: weapon.weaponNum,
                            child: Text(
                              '${weapon.weaponNum} (${weapon.name})',
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
                          setStateCallback(() {
                            attackSet.attacks[slot] = newValue;
                            // Update controller text
                            if (controller != null) {
                              controller!.text = newValue.toString();
                            }
                          });
                        }
                      },
                    ),
              ),
            ],
          ),
          subtitle: loadedWeapons.isNotEmpty
            ? Text(
                'weaponNum $currentValue',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              )
            : null,
        ),
      ],
    );
  }
}
