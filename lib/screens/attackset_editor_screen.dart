import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:bfp_weapon_cfg_flutter/models/attackset.dart';
import 'package:bfp_weapon_cfg_flutter/models/weapon.dart';
import 'package:bfp_weapon_cfg_flutter/logic/cfg_parser.dart';
import 'package:bfp_weapon_cfg_flutter/logic/cfg_writer.dart';
import 'package:bfp_weapon_cfg_flutter/logic/confirm_remove_attackset.dart';
import 'package:bfp_weapon_cfg_flutter/logic/show_add_attackset_dialog.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/attack_slot/build_attack_slot_tile.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/dialogs/notification_dialog.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/dialogs/warning_dialog.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/fields/build_model_textfield.dart';

class AttackSetEditorScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;
  final List<Weapon> loadedWeapons;

  const AttackSetEditorScreen({
    required this.isDarkMode,
    required this.onToggleTheme,
    required this.loadedWeapons,
    super.key,
  });

  @override
  State<AttackSetEditorScreen> createState() => _AttackSetEditorScreenState();
}

class _AttackSetEditorScreenState extends State<AttackSetEditorScreen> {
  List<AttackSet> attackSets = [];
  String? currentFile;
  final Map<AttackSet, List<TextEditingController>> attackControllers = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    for (final controllers in attackControllers.values) {
      for (final controller in controllers) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  void _initControllers() {
    // Clear existing controllers
    for (final controllers in attackControllers.values) {
      for (final controller in controllers) {
        controller.dispose();
      }
    }
    attackControllers.clear();

    for (final as in attackSets) {
      final controllers = List.generate(5, (slot) {
        return TextEditingController(text: as.attacks[slot].toString());
      });
      attackControllers[as] = controllers;
    }
  }

  void _load() async {
    if (widget.loadedWeapons.isEmpty) {
      await WarningDialog.show(
        context,
        'bfp_weapon.cfg must be loaded first!\n'
        'Go to Weapons tab and load a weapon config file.',
      );
      return;
    }

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['cfg'],
    );
    
    if (result != null) {
      final file = result.files.single;
      final path = file.path!;
      
      if (file.name.toLowerCase() == 'bfp_attacksets.cfg') {
        setState(() {
          currentFile = path;
          attackSets = parseAttackSetCfg(path);
          _initControllers();
        });
      } else {
        WarningDialog.show(
          mounted ? context : context, 
          'Invalid file selected!\n'
          'Please select "bfp_attacksets.cfg"'
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
      saveAttackSetCfg(currentFile!, attackSets);
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
        saveAttackSetCfg(outPath, attackSets);
        NotificationDialog.show(mounted ? context : context, 'Saved copy: $outPath');
      }
    }
  }

  void _showAddAttackSetDialog() async {
    await showAddAttackSetDialog(
      context: context,
      attackSets: attackSets,
      setStateCallback: (fn) => setState(fn),
      loadedWeapons: widget.loadedWeapons,
    );
    
    // Reinitialize controllers after adding
    _initControllers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF8984CB),
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Bid For Power - Attack Set Config Editor',
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
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add new attackset',
            onPressed: () => _showAddAttackSetDialog(),
          ),
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: _load,
            tooltip: "Open bfp_attacksets.cfg",
          ),
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
            tooltip: "Save file",
          ),
        ],
      ),
      body: attackSets.isEmpty
        ? Center(child: Text('Load bfp_attacksets.cfg to edit'))
        : ListView.builder(
            itemCount: attackSets.length,
            itemBuilder: (_, i) {
              final as = attackSets[i];
              return ExpansionTile(
                title: Row(
                  children: [
                    // ID badge
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${as.index}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      "attackset ${as.index}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.delete, size: 20),
                      tooltip: "Remove AttackSet ${as.index}",
                      onPressed: () => confirmRemoveAttackSet(
                        context: context,
                        attackSet: as,
                        attackSets: attackSets,
                        setStateCallback: (fn) => setState(fn),
                      ),
                    ),
                  ],
                ),
                children: [
                  for (int slot = 0; slot < 5; slot++) 
                    BuildAttackSlotTile(
                      attackSet: as,
                      slot: slot,
                      loadedWeapons: widget.loadedWeapons,
                      controller: attackControllers[as] ? [slot],
                      setStateCallback: (fn) => setState(fn),
                    ),

                  const SizedBox(height: 16),
                  BuildModelTextField(
                    label: 'modelPrefix',
                    value: as.modelPrefix,
                    onChanged: (v) => setState(() => as.modelPrefix = v),
                  ),
                  const SizedBox(height: 12),
                  BuildModelTextField(
                    label: 'defaultModel',
                    value: as.defaultModel,
                    onChanged: (v) => setState(() => as.defaultModel = v),
                  ),
                ],
              );
            },
          ),
    );
  }
}