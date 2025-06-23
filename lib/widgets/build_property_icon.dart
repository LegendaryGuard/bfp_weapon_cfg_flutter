
import 'package:flutter/material.dart';
import 'package:bfp_weapon_cfg_flutter/models/constants.dart';
import 'package:bfp_weapon_cfg_flutter/models/weapon.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/weapon/weapon_property_image.dart';

class BuildPropertyIcon extends StatefulWidget {
  final Weapon w;
  final String keyName;

  const BuildPropertyIcon({
    required this.w,
    required this.keyName,
    super.key,
  });

  @override
  State<BuildPropertyIcon> createState() => _BuildPropertyIconState();
}

class _BuildPropertyIconState extends State<BuildPropertyIcon> {
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = widget.w.properties[widget.keyName];
    final iconPath = getPropertyIcon(widget.keyName, value);
    String? keyNameMsg = widget.keyName;

    if (keyNameMsg == 'attackType') {
      keyNameMsg = value;
    }

    if (iconPath.isEmpty && iconPath != '') return const SizedBox.shrink();
    
    return Tooltip(
      message: keyNameMsg,
      child: WeaponPropertyImage(
        path: iconPath,
        color: const Color(0xFF000034),
      )
    );
  }
}