import 'dart:io';
import 'package:bfp_weapon_cfg_flutter/models/weapon.dart';

List<Weapon> parseCfg(String path) {
  final lines = File(path).readAsLinesSync();
  final weapons = <Weapon>[];
  Weapon? current;

  for (var raw in lines) {
    final trimmed = raw.trim();

    if (trimmed.isEmpty) {
      current?.rawLines.add(raw);
      continue;
    }

    final header = RegExp(r'^\((.+)\)$').firstMatch(trimmed);
    if (header != null) {
      if (current != null) weapons.add(current);
      current = Weapon(header.group(1)!, {}, [raw]);
    }
    else if (trimmed.toLowerCase() == 'end') {
      current?.rawLines.add(raw);
      if (current != null) weapons.add(current);
      current = null;
    }
    else if (current != null) {
      final parts = trimmed.split(RegExp(r'\s+'));
      if (parts.isNotEmpty) {
        final key = parts[0];
        final value = parts.length >= 2 ? parts.sublist(1).join(' ') : null;
        current.properties[key] = value;
      }
      current.rawLines.add(raw);
    }
  }

  return weapons;
}
