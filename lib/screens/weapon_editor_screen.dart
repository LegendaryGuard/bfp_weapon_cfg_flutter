import 'package:bfp_weapon_cfg_flutter/logic/check_weapon_num.dart';
import 'package:bfp_weapon_cfg_flutter/logic/confirm_remove_weapon.dart';
import 'package:bfp_weapon_cfg_flutter/logic/edit_weapon_name.dart';
import 'package:bfp_weapon_cfg_flutter/logic/show_add_weapon_dialog.dart';
import 'package:bfp_weapon_cfg_flutter/logic/cfg_parser.dart';
import 'package:bfp_weapon_cfg_flutter/logic/cfg_writer.dart';
import 'package:bfp_weapon_cfg_flutter/models/constants.dart';
import 'package:bfp_weapon_cfg_flutter/models/weapon.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/dialogs/notification_dialog.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/dialogs/warning_dialog.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/fields/build_field.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/fields/build_labeled_field_above.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class WeaponEditorScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  const WeaponEditorScreen({
    required this.isDarkMode,
    required this.onToggleTheme,
    super.key,
  });

  @override
  State<WeaponEditorScreen> createState() => _WeaponEditorScreenState();
}

class _WeaponEditorScreenState extends State<WeaponEditorScreen> {
  List<Weapon> weapons = [];
  String? currentFile;

  // Use a map to store controllers for each weapon
  final Map<Weapon, TextEditingController> weaponNumControllers = {};
  final Map<Weapon, FocusNode> weaponNumFocusNodes = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Dispose all controllers and focus nodes
    for (final controller in weaponNumControllers.values) {
      controller.dispose();
    }
    for (final focusNode in weaponNumFocusNodes.values) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _initControllersForWeapons() {
    // Clear existing controllers
    for (final controller in weaponNumControllers.values) {
      controller.dispose();
    }
    for (final focusNode in weaponNumFocusNodes.values) {
      focusNode.dispose();
    }
    weaponNumControllers.clear();
    weaponNumFocusNodes.clear();

    // Create new controllers and focus nodes for each weapon
    for (final weapon in weapons) {
      weaponNumControllers[weapon] = TextEditingController(
        text: weapon.weaponNum?.toString() ?? '',
      );
      weaponNumFocusNodes[weapon] = FocusNode()
        ..addListener(() {
          if (!weaponNumFocusNodes[weapon]!.hasFocus) {
            _onWeaponNumFocusChange(weapon);
          }
        });
    }
  }

  void _onWeaponNumFocusChange(Weapon weapon) {
    final controller = weaponNumControllers[weapon];
    if (controller != null) {
      checkWeaponNum(
        context: context,
        weapons: weapons,
        value: controller.text,
        w: weapon,
        weaponNumController: controller,
        setStateCallback: (fn) => setState(fn),
      );
    }
  }

  void _load() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['cfg'],
    );
    
    if (result != null) {
      final file = result.files.single;
      final path = file.path!;
      final fileName = file.name.toLowerCase();
      
      // Check if filename is allowed
      if (fileName == 'bfp_weapon.cfg' || fileName == 'bfp_weapon2.cfg') {
        setState(() {
          currentFile = path;
          weapons = parseCfg(path);
          _initControllersForWeapons();
        });
      } else {
        // Show error for invalid file selection
        WarningDialog.show(
          mounted ? context : context, 
          'Invalid file selected!\n'
          'Please select either "bfp_weapon.cfg" or "bfp_weapon2.cfg"'
        );
      }
    }
  }

  Future<void> _save() async {
    if (currentFile == null) return;

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Save changes'),
        content: const Text('Do you want to overwrite the original file, or save a new copy?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, 'copy'), 
            child: const Text('Save As…'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, 'overwrite'), 
            child: const Text('Overwrite'),
          ),
        ],
      ),
    );

    if (result == 'overwrite') {
      saveCfg(currentFile!, weapons);
      NotificationDialog.show(mounted ? context : context, 'Overwritten: $currentFile');
    } else if (result == 'copy') {
      // Show filename input dialog
      final controller = TextEditingController(
        text: currentFile!.replaceFirst('.cfg', '_edited.cfg'),
      );
      
      final newPath = await showDialog<String>(
        context: mounted ? context : context,
        builder: (ctx) => AlertDialog(
          title: const Text('Save As'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Enter file path',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
              onSubmitted: (value) => Navigator.pop(ctx, value),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('CANCEL'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, controller.text),
              child: const Text('OK'),
            ),
          ],
        ),
      );

      if (newPath != null && newPath.isNotEmpty) {
        // Ensure file has .cfg extension
        final outPath = newPath.endsWith('.cfg') ? newPath : '$newPath.cfg';
        saveCfg(outPath, weapons);
        NotificationDialog.show(mounted ? context : context, 'Saved copy: $outPath');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFA6E06),
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Bid For Power - Weapon Config Editor',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 14),
            IconButton(
              icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
              tooltip: widget.isDarkMode ? 'Dark' : 'Light',
              onPressed: widget.onToggleTheme,
            ),
          ],
        ),
        actions: [
          if (weapons.isNotEmpty)
            IconButton(
              icon: Icon(Icons.add),
              tooltip: 'Add new weapon',
              onPressed: () async {
                await showAddWeaponDialog(
                  context: context,
                  weapons: weapons,
                  isDarkMode: widget.isDarkMode,
                  setStateCallback: (fn) => setState(fn),
                );
                _initControllersForWeapons();
              },
            ),
          IconButton(
            onPressed: _load,
            tooltip: "Open bfp_weapon.cfg file",
            icon: Icon(Icons.folder_open)
          ),
          IconButton(
            onPressed: _save,
            tooltip: "Save loaded bfp_weapon.cfg file",
            icon: Icon(Icons.save)
          ),
        ],
      ),
      body: weapons.isEmpty
        ? Center(child: Text('Load bfp_weapon.cfg or bfp_weapon2.cfg to edit'))
        : ListView.builder(
            itemCount: weapons.length,
            itemBuilder: (_, i) {
              final w = weapons[i];
              int id = i + 1;
              return ExpansionTile(
                title: Row(
                  children: [
                    Expanded(child: Row(
                      children: [
                        // ID badge
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '$id',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          "${w.properties['weaponNum']} "
                        ),
                        Text(
                          "(${w.name})", 
                          style: TextStyle(fontWeight: FontWeight.bold)
                        ),
                      ],
                    )),
                    IconButton(
                      icon: Icon(Icons.delete, size: 20),
                      tooltip: "Remove ${w.name}",
                      onPressed: () => confirmRemoveWeapon(
                        context: context,
                        w: w,
                        weapons: weapons,
                        setStateCallback: (fn) => setState(fn),
                        mounted: mounted,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, size: 20),
                      tooltip: "Edit weapon name",
                      onPressed: () => editWeaponName(
                        context: context,
                        w: w,
                        setStateCallback: (fn) => setState(fn),
                      ),
                    ),
                  ],
                ),
                children: [
                  ...[
                    'weaponNum',
                    'attackType',
                    'weaponTime',
                    'randomWeaponTime',
                    'kiCostAsPct',
                    'kiPct',
                    'kiCost',
                    'chargeAttack',
                    'chargeAutoFire',
                    'minCharge',
                    'maxCharge',
                    'damage',
                    'splashDamage',
                    'chargeDamageMult',
                    'maxDamage',
                    'radius',
                    'explosionRadius',
                    'chargeRadiusMult',
                    'chargeExpRadiusMult',
                    'maxRadius',
                    'maxExpRadius',
                    'missileSpeed',
                    'homing',
                    'homingRange',
                    'homingAcceleration',
                    'range',
                    'loopingAnim',
                    'noAttackAnim',
                    'alternatingXOffset',
                    'randYOffset',
                    'randXOffset',
                    'coneOfFireX',
                    'coneOfFireY',
                    'piercing',
                    'reflective',
                    'priority',
                    'blinding',
                    'usesGravity',
                    'extraKnockback',
                    'railTrail',
                    'movementPenalty',
                    'missileGravity',
                    'missileAcceleration',
                    'multishot',
                    'bounces',
                    'bounceFriction',
                    'noZBounce',
                    'missileDuration',
                    'explosionSpawn',
                  ].map((key) {
                    final range = weaponRangeValues[key] ?? RangeValues(0, 10000);
                    final isBool = boolWeaponKeysArr.contains(key);
                    final isAttackType = key == 'attackType';

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BuildLabeledFieldAbove(
                        keyName: key,
                        inputField: BuildField(
                          w: w,
                          keyName: key,
                          range: range,
                          isBool: isBool,
                          isAttackType: isAttackType,
                          // special handling for weaponNum
                          controller: key == 'weaponNum' 
                              ? weaponNumControllers[w]
                              : null,
                          focusNode: key == 'weaponNum' 
                              ? weaponNumFocusNodes[w]
                              : null,
                          onWeaponNumCheck: (value, weapon) => checkWeaponNum(
                            context: context,
                            weapons: weapons,
                            value: value,
                            w: weapon,
                            weaponNumController: weaponNumControllers[w],
                            setStateCallback: (fn) => setState(fn),
                          ),
                        ),
                        isDarkMode: widget.isDarkMode,
                      ),
                    );
                  }),
                ],
              );
            },
          ),
    );
  }
}
