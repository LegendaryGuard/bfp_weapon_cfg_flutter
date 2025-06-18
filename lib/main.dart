import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bfp_weapon_cfg_flutter/models/theme.dart';
import 'package:bfp_weapon_cfg_flutter/models/weapon.dart';
import 'package:bfp_weapon_cfg_flutter/screens/weapon_editor_screen.dart';
import 'package:bfp_weapon_cfg_flutter/screens/attackset_editor_screen.dart';

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
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.bolt, color: Color(0xFFEBD300)),
              label: 'Weapons',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_search, color: Color(0xFF3F51B5)),
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