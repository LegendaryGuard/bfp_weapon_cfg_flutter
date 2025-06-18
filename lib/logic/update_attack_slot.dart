import 'package:bfp_weapon_cfg_flutter/models/attackset.dart';

void updateAttackSlot({
  required AttackSet attackSet,
  required int slot,
  required String value,
  required void Function(void Function()) setStateCallback,
}) {
  final weaponNum = int.tryParse(value);
  if (weaponNum != null && weaponNum >= 0 && weaponNum <= 32767) {
    setStateCallback(() {
      attackSet.updateAttack(slot, weaponNum);
    });
  }
}
