class Weapon {
  String name;
  Map<String, String?> properties;
  List<String> rawLines; // original lines for preserving format

  Weapon(this.name, this.properties, this.rawLines);

  int? get weaponNum {
    final v = properties['weaponNum'];
    return v == null ? null : int.tryParse(v);
  }

  set weaponNum(int? num) {
    properties['weaponNum'] = num?.toString();
  }

  void swapWeaponNumWith(Weapon other) {
    final temp = weaponNum;
    weaponNum = other.weaponNum;
    other.weaponNum = temp;
  }
}
