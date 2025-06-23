import 'package:flutter/material.dart';
import 'package:bfp_weapon_cfg_flutter/models/constants.dart';
import 'package:bfp_weapon_cfg_flutter/models/weapon.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/build_property_icon.dart';

class WeaponSummaryBar extends StatelessWidget {
  final Weapon weapon;

  const WeaponSummaryBar({required this.weapon, super.key});

  @override
  Widget build(BuildContext context) {
    final activeProperties = [
      'attackType',
      'chargeAttack',
      'chargeAutoFire',
      'loopingAnim',
      'noAttackAnim',
      'multishot',
      'homing',
      'piercing',
      'railTrail',
      'reflective',
      'usesGravity',
      'blinding',
    ].where((key) {
      final value = weapon.properties[key];
      if (value == null) return false;

      if (key == 'attackType') {
        return attackTypes.contains(value);
      }
      
      switch (key) {
        case 'multishot': 
          return (int.tryParse(value) ?? 0) > 0;
        case 'homing':
          return (double.tryParse(value) ?? 0.0) > 0;
        default:
          return value == '1';
      }
    }).toList();

    if (activeProperties.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: activeProperties.map((key) {
          return BuildPropertyIcon(
            keyName: key,
            w: weapon
          );
        }).toList(),
      ),
    );
  }
}
