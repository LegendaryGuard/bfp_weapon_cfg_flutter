import 'package:flutter/material.dart';

const Map<String, String> variableDescriptions = {
  'weaponNum': 'Weapon id number',
  'attackType': 'Type of attack',
  'weaponTime': 'Weapon time in milliseconds',
  'randomWeaponTime': 'Random weapon time in milliseconds',
  'kiCostAsPct': 'Ki attack percentage cost (float)',
  'kiPct': 'Ki attack percentage (float)',
  'kiCost': 'Ki attack cost',
  'chargeAttack': 'Enable charge attack',
  'chargeAutoFire': 'Enable auto-fire even while charging',
  'minCharge': 'Minimum charge points',
  'maxCharge': 'Maximum charge points',
  'damage': 'Attack (projectile) damage',
  'splashDamage': 'Splash attack damage',
  'chargeDamageMult': 'Attack damage multiplier by charge points',
  'maxDamage': 'Maximum attack damage',
  'radius': 'Attack (projectile) radius',
  'explosionRadius': 'Explosion radius',
  'chargeRadiusMult': 'Radius multiplier by charge points',
  'chargeExpRadiusMult': 'Explosion radius multiplier by charge points',
  'maxRadius': 'Maximum attack (projectile) radius',
  'maxExpRadius': 'Maximum explosion radius',
  'missileSpeed': 'Attack (projectile) speed',
  'homing': 'Homing factor (float), 0 = no homing',
  'homingRange': 'Homing range (float)',
  'homingAcceleration': 'Homing acceleration (float)',
  'range': 'Attack (projectile) range',
  'loopingAnim': 'Enable animation loop',
  'noAttackAnim': 'Enable no attack strike animation',
  'alternatingXOffset': 'Alternative X offset of the attack',
  'randYOffset': 'Random Y offset of the attack',
  'randXOffset': 'Random X offset of the attack',
  'coneOfFireX': 'Attack fire muzzle X vector',
  'coneOfFireY': 'Attack fire muzzle Y vector',
  'piercing': 'Enable to pierce enemy attacks',
  'reflective': 'Enable to reflect enemy attacks',
  'priority': 'Attack priority: 2 = forcefield, 1 = beam, 0 = none',
  'blinding': 'Enable to blind enemies',
  'usesGravity': 'Enable projectile gravity',
  'extraKnockback': 'If negative, no knockback',
  'railTrail': 'Enable rail trail instant attack',
  'movementPenalty': 'Stun duration in seconds after attack',
  'missileGravity': 'Attack (projectile) gravity factor, 0 = no gravity',
  'missileAcceleration': 'Projectile acceleration (float), lesser than 1 = deceleration',
  'multishot': 'Attack shots quantity, 0 = one shot',
  'bounces': 'Number of projectile bounces on solid',
  'bounceFriction': 'Bounce friction (float)',
  'noZBounce': 'Vertical bounce damping factor (float)',
  'missileDuration': 'Projectile duration in milliseconds',
  'explosionSpawn': 'Number of spawned explosion projectiles',
};

const attackTypes = [
  'missile',
  'rdmissile',
  'beam',
  'hitscan',
  'forcefield'
];

const floatWeaponKeys = {
  'kiCostAsPct',
  'kiPct',
  'homing',
  'homingRange',
  'homingAcceleration',
  'missileAcceleration',
  'bounceFriction',
  'noZBounce',
};

final boolWeaponKeysArr = [
  'chargeAttack',
  'loopingAnim',
  'piercing',
  'reflective',
  'blinding',
  'usesGravity',
  'railTrail',
  'noAttackAnim',
  'chargeAutoFire',
];

final weaponRangeValues = {
  'weaponNum': RangeValues(0, 32767),
  'attackType': RangeValues(0, 0),
  'weaponTime': RangeValues(0, 100000),
  'randomWeaponTime': RangeValues(0, 100000),
  'kiCostAsPct': RangeValues(0, 100),
  'kiPct': RangeValues(0, 100),
  'kiCost': RangeValues(0, 10000),
  'chargeAttack': RangeValues(0, 1),
  'chargeAutoFire': RangeValues(0, 1),
  'minCharge': RangeValues(0, 6),
  'maxCharge': RangeValues(0, 6),
  'damage': RangeValues(0, 1000),
  'splashDamage': RangeValues(0, 1000),
  'chargeDamageMult': RangeValues(0, 100),
  'maxDamage': RangeValues(0, 1000),
  'radius': RangeValues(0, 1000),
  'explosionRadius': RangeValues(0, 1000),
  'chargeRadiusMult': RangeValues(0, 100),
  'chargeExpRadiusMult': RangeValues(0, 100),
  'maxRadius': RangeValues(0, 1000),
  'maxExpRadius': RangeValues(0, 1000),
  'missileSpeed': RangeValues(0, 10000),
  'homing': RangeValues(0, 1),
  'homingRange': RangeValues(0, 100000),
  'homingAcceleration': RangeValues(0, 1000),
  'range': RangeValues(0, 100000),
  'loopingAnim': RangeValues(0, 1),
  'noAttackAnim': RangeValues(0, 1),
  'alternatingXOffset': RangeValues(0, 100000),
  'randYOffset': RangeValues(0, 100000),
  'randXOffset': RangeValues(0, 100000),
  'coneOfFireX': RangeValues(0, 100000),
  'coneOfFireY': RangeValues(0, 100000),
  'piercing': RangeValues(0, 1),
  'reflective': RangeValues(0, 1),
  'priority': RangeValues(0, 2),
  'blinding': RangeValues(0, 1),
  'usesGravity': RangeValues(0, 1),
  'extraKnockback': RangeValues(-1000, 1000),
  'railTrail': RangeValues(0, 1),
  'movementPenalty': RangeValues(0, 100),
  'missileGravity': RangeValues(-10000, 10000),
  'missileAcceleration': RangeValues(0, 10000),
  'multishot': RangeValues(0, 10000),
  'bounces': RangeValues(0, 10000),
  'bounceFriction': RangeValues(0, 10000),
  'noZBounce': RangeValues(0, 100000),
  'missileDuration': RangeValues(0, 100000),
  'explosionSpawn': RangeValues(0, 10000),
};

const double imageSIZE = 48;

const String imgDIR = 'assets/img';
const String cfgDIR = 'assets/cfg';

String getPropertyIcon(String key, String? value) {
  switch (key) {
    case 'attackType':
      return (attackTypes.contains(value)) ? '$imgDIR/weapon/$value.png' : '';
    case 'multishot':
    case 'homing':
    case 'chargeAttack':
    case 'chargeAutoFire':
    case 'loopingAnim':
    case 'noAttackAnim':
    case 'piercing':
    case 'railTrail':
    case 'reflective':
    case 'usesGravity':
    case 'blinding': return '$imgDIR/weapon/$key.png';
    default: return '';
  }
}
