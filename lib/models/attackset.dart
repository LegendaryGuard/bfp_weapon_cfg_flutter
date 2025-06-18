class AttackSet {
  int index;
  List<int> attacks;
  String modelPrefix;
  String defaultModel;
  List<String> rawLines;

  AttackSet(this.index, this.attacks, this.modelPrefix, this.defaultModel, this.rawLines) {
    if (rawLines.isEmpty) {
      rawLines = [
        'attackset $index',
        for (int slot = 0; slot < 5; slot++) 'attack $slot ${attacks[slot]}',
        'modelPrefix $modelPrefix',
        'defaultModel $defaultModel',
      ];
    }
  }

  @override
  String toString() {
    return 'AttackSet $index: ${attacks.join(', ')} | $modelPrefix | $defaultModel';
  }

  void updateAttack(int slot, int weaponNum) {
    attacks[slot] = weaponNum;
  }
}