import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:bfp_weapon_cfg_flutter/logic/cfg_parser.dart';

void main() {
  test('parseCfg should split blocks and read properties', () {
    // create a temporary .cfg file
    final tempDir = Directory.systemTemp.createTempSync();
    final file = File('${tempDir.path}/sample.cfg');
file.writeAsStringSync('''
(beam_weapon)
weaponNum 42
attackType beam
damage 100
end
''');

    final weapons = parseCfg(file.path);

    // verify
    expect(weapons, hasLength(1));
    final w = weapons.first;
    expect(w.name, 'beam_weapon');
    expect(w.properties['weaponNum'], '42');
    expect(w.properties['attackType'], 'beam');
    expect(w.properties['damage'], '100');

    // clean up
    tempDir.deleteSync(recursive: true);
  });
}
