import 'package:flutter/material.dart';
import 'package:bfp_weapon_cfg_flutter/models/constants.dart';

class WeaponPropertyImage extends StatelessWidget {
  final String path;
  final Color color;
  final bool? enlarge;

  const WeaponPropertyImage({
    super.key,
    required this.path,
    required this.color,
    this.enlarge
  });

  @override
  Widget build(BuildContext context) {
    final imgSize = (enlarge == true) ? imageSIZE * 1.4 : imageSIZE;
    return Image.asset(
      path,
      width: imgSize,
      height: imgSize,
      fit: BoxFit.contain,
      colorBlendMode: BlendMode.lighten,
      color: color,
    );
  }
}
