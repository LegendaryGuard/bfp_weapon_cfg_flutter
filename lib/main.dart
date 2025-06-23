import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bfp_weapon_cfg_flutter/models/constants.dart';
import 'package:bfp_weapon_cfg_flutter/models/theme.dart';
import 'package:bfp_weapon_cfg_flutter/models/weapon.dart';
import 'package:bfp_weapon_cfg_flutter/screens/weapon_editor_screen.dart';
import 'package:bfp_weapon_cfg_flutter/screens/attackset_editor_screen.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/weapon/weapon_property_image.dart';

void main() => runApp(WeaponEditorApp());

class WeaponEditorApp extends StatefulWidget {
  const WeaponEditorApp({super.key});
  @override
  State<WeaponEditorApp> createState() => _WeaponEditorAppState();
}

class _WeaponEditorAppState extends State<WeaponEditorApp> {
  ThemeMode _themeMode = ThemeMode.dark;
  int _currentIndex = 0;
  List<Weapon> weapons = [];

  void _toggleTheme() {
    setState(() => _themeMode = 
        _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bid For Power - Weapon Editor',
      debugShowCheckedModeBanner: !kDebugMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            WeaponEditorScreen(
              onToggleTheme: _toggleTheme,
              isDarkMode: _themeMode == ThemeMode.dark,
              onWeaponsUpdated: (newWeapons) {
                setState(() => weapons = newWeapons);
              },
            ),
            AttackSetEditorScreen(
              onToggleTheme: _toggleTheme,
              isDarkMode: _themeMode == ThemeMode.dark,
              loadedWeapons: weapons,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: WeaponPropertyImage(
                path: '$imgDIR/weapons.png',
                color: const Color(0xFFFA6E06),
              ),
              activeIcon: WeaponPropertyImage(
                path: '$imgDIR/weapons.png',
                color: const Color(0xFFFA6E06),
                enlarge: true,
              ),
              label: 'Weapons',
            ),
            BottomNavigationBarItem(
              icon: WeaponPropertyImage(
                path: '$imgDIR/attacksets.png',
                color: const Color(0xFF8984CB),
              ),
              activeIcon: WeaponPropertyImage(
                path: '$imgDIR/attacksets.png',
                color: const Color(0xFF8984CB),
                enlarge: true,
              ),
              label: 'Attack sets',
            ),
          ],
          onTap: (index) => setState(() => _currentIndex = index),
          selectedFontSize: 18,
          selectedIconTheme: IconThemeData(size: 50),
        ),
      ),
    );
  }
}