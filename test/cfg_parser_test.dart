import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:bfp_weapon_cfg_flutter/logic/cfg_parser.dart';
import 'package:bfp_weapon_cfg_flutter/models/constants.dart';

void main() {
  test('parseCfg and parseAttackSetCfg should split blocks and read properties', () {
    // open bfp_weapon.cfg file in the assets/cfg/ directory
    var file = File('$cfgDIR/bfp_weapon.cfg');

    final weapons = parseCfg(file.path);

    // verify
    expect(weapons, hasLength(22));

    // verify the first weapon
    final w = weapons.first;
    expect(w.name, 'large_ki_blast');
    expect(w.properties['weaponNum'], '10');
    expect(w.properties['attackType'], 'missile');
    expect(w.properties['damage'], '30');
    expect(w.properties['missileSpeed'], '6000');

    // open bfp_attacksets.cfg file in the assets/cfg/ directory
    file = File('$cfgDIR/bfp_attacksets.cfg');

    final attacksets = parseAttackSetCfg(file.path);

    // verify
    expect(attacksets, hasLength(6));

    // verify the first attackset
    final a = attacksets.first;
    expect(a.index, 1);
    expect(a.attacks[0], 21);
    expect(a.attacks[1], 16);
    expect(a.attacks[2], 15);
    expect(a.attacks[3], 23);
    expect(a.attacks[4], 13);
    expect(a.modelPrefix, 'bfp1-');
    expect(a.defaultModel, 'bfp1-kyah');

  });
}
