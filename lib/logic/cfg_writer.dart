import 'dart:io';
import 'package:bfp_weapon_cfg_flutter/models/attackset.dart';
import 'package:bfp_weapon_cfg_flutter/models/weapon.dart';

void saveCfg(String outPath, List<Weapon> weapons) {
  final out = <String>[];

  for (var weapon in weapons) {
    for (var raw in weapon.rawLines) {
      final trimmed = raw.trim();
      if (trimmed.contains(' ')) {
        final key = trimmed.split(RegExp(r'\s+'))[0];
        final newVal = weapon.properties[key];
        if (newVal != null) {
          // overwrite with new value
          final indent = raw.substring(0, raw.indexOf(key));
          out.add('$indent$key $newVal');
          continue;
        }
      }
      // keep original line if there's no new value
      out.add(raw);
    }
  }

  // add trailing 'end' if missing...
  File(outPath).writeAsStringSync(out.join('\n'));
}

void saveAttackSetCfg(String outPath, List<AttackSet> attackSets) {
  final out = <String>[];
  
  for (var attackSet in attackSets) {
    out.add('attackset ${attackSet.index}');
    for (int slot = 0; slot < 5; slot++) {
      out.add('attack $slot ${attackSet.attacks[slot]}');
    }
    out.add('modelPrefix ${attackSet.modelPrefix}');
    out.add('defaultModel ${attackSet.defaultModel}');
    out.add(''); // Add empty line between attacksets
  }

  out.add('end');
  File(outPath).writeAsStringSync(out.join('\n'));
}
