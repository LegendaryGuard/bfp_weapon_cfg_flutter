import 'dart:io';
import 'package:bfp_weapon_cfg_flutter/models/attackset.dart';
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

List<AttackSet> parseAttackSetCfg(String path) {
  final lines = File(path).readAsLinesSync();
  final attackSets = <AttackSet>[];
  AttackSet? current;
  List<String> currentLines = [];

  for (var raw in lines) {
    final trimmed = raw.trim();
    currentLines.add(raw);

    if (trimmed.isEmpty) continue;

    if (trimmed.startsWith('attackset ')) {
      // Finalize previous attackset if exists
      if (current != null) {
        current.rawLines = List.from(currentLines..removeLast());
        attackSets.add(current);
        currentLines = [raw];
      }

      final parts = trimmed.split(RegExp(r'\s+'));
      if (parts.length >= 2) {
        final index = int.tryParse(parts[1]) ?? 0;
        current = AttackSet(index, List.filled(5, 0), '', '', []);
      }
    }
    else if (current != null) {
      if (trimmed.startsWith('attack ')) {
        final parts = trimmed.split(RegExp(r'\s+'));
        if (parts.length >= 3) {
          final slot = int.tryParse(parts[1]) ?? 0;
          final weaponNum = int.tryParse(parts[2]) ?? 0;
          if (slot >= 0 && slot < 5) {
            current.attacks[slot] = weaponNum;
          }
        }
      }
      else if (trimmed.startsWith('modelPrefix ')) {
        current.modelPrefix = trimmed.substring('modelPrefix '.length).trim();
      }
      else if (trimmed.startsWith('defaultModel ')) {
        current.defaultModel = trimmed.substring('defaultModel '.length).trim();
      }
      else if (trimmed == 'end') {
        current.rawLines = List.from(currentLines);
        attackSets.add(current);
        current = null;
        currentLines = [];
      }
    }
  }

  // Add last attackset if exists
  if (current != null) {
    current.rawLines = List.from(currentLines);
    attackSets.add(current);
  }

  return attackSets;
}
