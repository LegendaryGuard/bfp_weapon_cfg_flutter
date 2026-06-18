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
  'damage': 'Projectile damage',
  'splashDamage': 'Splash attack damage',
  'chargeDamageMult': 'Attack damage multiplier by charge points',
  'maxDamage': 'Maximum attack damage',
  'radius': 'Projectile radius',
  'explosionRadius': 'Explosion radius',
  'chargeRadiusMult': 'Radius multiplier by charge points',
  'chargeExpRadiusMult': 'Explosion radius multiplier by charge points',
  'maxRadius': 'Maximum projectile radius',
  'maxExpRadius': 'Maximum explosion radius',
  'missileSpeed': 'Projectile speed',
  'homing': 'Homing factor (float), 0 or less = no homing',
  'homingRange': 'Homing range (float), 0 or less = no homing',
  'homingAcceleration': 'Homing acceleration (float)',
  'range': 'Projectile range (for hitscan weapons)',
  'loopingAnim': 'Enable animation loop',
  'noAttackAnim': 'Enable no attack strike animation',
  'alternatingXOffset': 'Alternative X offset of the attack',
  'randYOffset': 'Random Y offset of the attack',
  'randXOffset': 'Random X offset of the attack',
  'coneOfFireX': 'Attack fire muzzle X vector',
  'coneOfFireY': 'Attack fire muzzle Y vector',
  'piercing': 'Enable to pierce enemy attacks',
  'reflective': 'Enable to reflect enemy attacks (for hitscan weapons)',
  'priority': 'Projectile priority, if higher than the other one, the other one breaks/explodes/disappears',
  'blinding': 'Enable to blind enemies (original BFP: only works on forcefield weapons)',
  'usesGravity': 'Enable projectile gravity (original BFP: unused option)',
  'extraKnockback': 'Extra knockback factor, if negative, less knockback',
  'railTrail': 'Enable rail trail instant attack (for hitscan weapons)',
  'movementPenalty': 'Stun duration in seconds after attacking',
  'missileGravity': 'Projectile gravity factor, 0 or less = no gravity',
  'missileAcceleration': 'Projectile acceleration (float), lesser than 1 until 0.0001 = deceleration',
  'multishot': 'Attack shots quantity, 0, less or 1 = one shot',
  'bounces': 'Enable projectile bouncing',
  'bounceFriction': 'Bounce friction (float)',
  'noZBounce': 'Enable vertical bouncing (bounces continuously at the same altitude without fall decrease)',
  'missileDuration': 'Projectile duration in milliseconds',
  'explosionSpawn': 'Weapon id number to spawn projectiles (for rdmissile weapons)',
};

const attackTypes = [
  'missile',
  'rdmissile',
  'beam',
  'sbeam',
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
  'bounces',
  'noZBounce',
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
  'priority': RangeValues(0, 10000),
  'blinding': RangeValues(0, 1),
  'usesGravity': RangeValues(0, 1),
  'extraKnockback': RangeValues(-1000, 1000),
  'railTrail': RangeValues(0, 1),
  'movementPenalty': RangeValues(0, 100),
  'missileGravity': RangeValues(-10000, 10000),
  'missileAcceleration': RangeValues(0, 10000),
  'multishot': RangeValues(0, 10000),
  'bounces': RangeValues(0, 1),
  'bounceFriction': RangeValues(0, 10000),
  'noZBounce': RangeValues(0, 1),
  'missileDuration': RangeValues(0, 100000),
  'explosionSpawn': RangeValues(0, 32767),
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
    case 'missileGravity':
    case 'blinding': return '$imgDIR/weapon/$key.png';
    default: return '';
  }
}
