import 'package:flutter/material.dart';
import 'package:bfp_weapon_cfg_flutter/models/weapon.dart';
import 'package:bfp_weapon_cfg_flutter/models/constants.dart';
import 'package:bfp_weapon_cfg_flutter/widgets/weapon/weapon_property_image.dart';

class BuildField extends StatefulWidget {
  final Weapon w;
  final String keyName;
  final RangeValues range;
  final bool isBool;
  final bool isAttackType;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final Function(String, Weapon) onWeaponNumCheck;

  const BuildField({
    required this.w,
    required this.keyName,
    required this.range,
    required this.onWeaponNumCheck,
    this.isBool = false,
    this.isAttackType = false,
    this.focusNode,
    this.controller,
    super.key,
  });

  @override
  State<BuildField> createState() => _BuildFieldState();
}

class _BuildFieldState extends State<BuildField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late bool _isWeaponNum;
  late bool _isPriority;

  @override
  void initState() {
    super.initState();
    _isWeaponNum = widget.keyName == 'weaponNum';
    _isPriority = widget.keyName == 'priority';
    
    // Use provided controller or create new one
    _controller = widget.controller ?? TextEditingController(
      text: widget.w.properties[widget.keyName] ?? ''
    );
    
    // Use provided focus node or create new one
    _focusNode = widget.focusNode ?? FocusNode();
    
    if (_isWeaponNum) {
      _focusNode.addListener(_onWeaponNumFocusChange);
    }
  }

  void _onWeaponNumFocusChange() {
    if (!_focusNode.hasFocus) {
      widget.onWeaponNumCheck(_controller.text, widget.w);
    }
  }

  @override
  void dispose() {
    if (_isWeaponNum) {
      _focusNode.removeListener(_onWeaponNumFocusChange);
    }
    
    // Only dispose if we created these internally
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final key = widget.keyName;
    final isFloat = floatWeaponKeys.contains(key);

    // AttackType dropdown
    if (widget.isAttackType) {
      return Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: attackTypes.contains(widget.w.properties[key]) ? widget.w.properties[key] : null,
              items: attackTypes
                  .map((t) => DropdownMenuItem(
                        value: t, 
                        child: Row(
                          children: [
                            WeaponPropertyImage(
                              path: getPropertyIcon('attackType', t),
                              color: const Color(0xFF000034),
                            ),
                            Text(t),
                          ],
                        )
                      )
                    ).toList(),
              onChanged: (v) => setState(() => widget.w.properties[key] = v!),
              decoration: InputDecoration(
                labelText: key,
                border: const OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ),
        ],
      );
    }

    // Boolean switch
    if (widget.isBool) {
      final val = widget.w.properties[key] ?? '0';
      return Row(
        children: [
          WeaponPropertyImage(
            path: getPropertyIcon(key, widget.w.properties[key]),
            color: const Color(0xFF000034),
          ),
          Text('$key (${widget.range.start.toInt()}–${widget.range.end.toInt()})'),
          const SizedBox(width: 8),
          Switch(
            value: val == '1',
            onChanged: (b) => setState(() => widget.w.properties[key] = b ? '1' : '0'),
          ),
        ],
      );
    }

    // Priority dropdown
    if (_isPriority) {
      return DropdownButtonFormField<int>(
        value: int.tryParse(widget.w.properties[key] ?? '0 = none') ?? 0,
        items: const [
          DropdownMenuItem(value: 0, child: Text('0 = none')),
          DropdownMenuItem(value: 1, child: Text('1 = beam')),
          DropdownMenuItem(value: 2, child: Text('2 = forcefield')),
        ],
        onChanged: (v) {
          if (v != null) {
            setState(() => widget.w.properties[key] = v.toString());
          }
        },
        decoration: InputDecoration(
          labelText: key,
          border: const OutlineInputBorder(),
          isDense: true,
        ),
      );
    }

    // Numeric text field
    final propertyIcon = getPropertyIcon(key, '0');
    return Row(
      children: [
        if (propertyIcon.isNotEmpty && propertyIcon != '')
          WeaponPropertyImage(
            path: propertyIcon,
            color: const Color(0xFF000034),
          ),
        Expanded(
          child: TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: '$key (${widget.range.start.toInt()}–${widget.range.end.toInt()})',
              border: const OutlineInputBorder(),
              isDense: true,
            ),
            onFieldSubmitted: (value) {
              final text = value.trim();
              if (key == 'weaponNum') {
                widget.onWeaponNumCheck(text, widget.w);
                return;
              }
              
              if (text.isEmpty) {
                setState(() => widget.w.properties[key] = null);
                return;
              }
              
              if (isFloat) {
                final f = double.tryParse(text);
                if (f != null && f >= widget.range.start && f <= widget.range.end) {
                  setState(() => widget.w.properties[key] = f.toString());
                }
              } else {
                final n = int.tryParse(text);
                if (n != null && n >= widget.range.start && n <= widget.range.end) {
                  setState(() => widget.w.properties[key] = n.toString());
                }
              }
            },
          ),
        ),
      ],
    );
  }
}