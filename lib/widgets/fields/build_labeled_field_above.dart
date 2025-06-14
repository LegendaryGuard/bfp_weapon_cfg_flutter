import 'package:flutter/material.dart';
import 'package:bfp_weapon_cfg_flutter/models/constants.dart';

class BuildLabeledFieldAbove extends StatelessWidget {
  final String keyName;
  final Widget inputField;
  final bool isDarkMode;

  const BuildLabeledFieldAbove({
    required this.keyName,
    required this.inputField,
    required this.isDarkMode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final desc = variableDescriptions[keyName];
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (desc != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                desc,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isDarkMode ? Colors.grey[400] : Colors.black,
                ),
              ),
            ),
          inputField,
        ],
      ),
    );
  }
}