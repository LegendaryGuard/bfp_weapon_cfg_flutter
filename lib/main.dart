import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'models/theme.dart';

import 'package:bfp_weapon_cfg_flutter/screens/weapon_editor_screen.dart';

void main() => runApp(WeaponEditorApp());

class WeaponEditorApp extends StatefulWidget {
  const WeaponEditorApp({super.key});
  @override
  State<WeaponEditorApp> createState() => _WeaponEditorAppState();
}

class _WeaponEditorAppState extends State<WeaponEditorApp> {
  ThemeMode _themeMode = ThemeMode.dark; // dark by default :contentReference[oaicite:1]{index=1}

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bid For Power - Weapon Editor',
      debugShowCheckedModeBanner: kDebugMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      home: WeaponEditorScreen(onToggleTheme: _toggleTheme, isDarkMode: _themeMode == ThemeMode.dark),
    );
  }
}

