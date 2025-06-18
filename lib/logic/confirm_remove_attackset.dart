import 'package:flutter/material.dart';
import 'package:bfp_weapon_cfg_flutter/models/attackset.dart';

Future<void> confirmRemoveAttackSet({
  required BuildContext context,
  required AttackSet attackSet,
  required List<AttackSet> attackSets,
  required Function(void Function()) setStateCallback,
}) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Delete AttackSet?'),
      content: Text('Are you sure you want to delete AttackSet ${attackSet.index}?'),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(ctx, false),
        ),
        ElevatedButton(
          child: const Text('Delete'),
          onPressed: () => Navigator.pop(ctx, true),
        ),
      ],
    ),
  );
  
  if (confirm == true) {
    setStateCallback(() {
      attackSets.remove(attackSet);
    });
  }
}
