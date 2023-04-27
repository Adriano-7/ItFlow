import 'package:flutter/material.dart';
import 'package:test/test.dart';

class IconSwitch extends StatefulWidget {
  final void Function(bool) _onChanged;
  final Icon _iconEnabled;
  final Icon _iconDisabled;
  final Color? _color;
  final double? _iconSize;
  final ButtonStyle? _style;
  final bool _isEnabled;
  const IconSwitch({
    super.key,
    required onChanged,
    required Icon iconEnabled,
    required Icon iconDisabled,
    required bool isEnabled,
    Color? color,
    double? iconSize,
    ButtonStyle? style,
  })  : _iconEnabled = iconEnabled,
        _iconDisabled = iconDisabled,
        _onChanged = onChanged,
        _color = color,
        _iconSize = iconSize,
        _style = style,
        _isEnabled=isEnabled;

  @override
  State<IconSwitch> createState() => _IconSwitchState();
}

  
class _IconSwitchState extends State<IconSwitch> {
  bool isActive = false;

  @override
  void initState(){
    super.initState();
    isActive = widget._isEnabled;
  }
 
  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: widget._color,
      iconSize: widget._iconSize,
      style: widget._style,
      onPressed: () {
        setState(() {
          isActive= !isActive;
        });
        widget._onChanged(isActive);
      },
      icon: isActive? widget._iconEnabled : widget._iconDisabled,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}