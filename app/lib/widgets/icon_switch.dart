import 'package:flutter/material.dart';

class IconSwitch extends StatefulWidget {
  final void Function(bool) _onChanged;
  final Icon _iconEnabled;
  final Icon _iconDisabled;
  final Color? _color;
  final double? _iconSize;
  final ButtonStyle? _style;

  const IconSwitch({
    super.key,
    required onChanged,
    required Icon iconEnabled,
    required Icon iconDisabled,
    Color? color,
    double? iconSize,
    ButtonStyle? style,
  })  : _iconEnabled = iconEnabled,
        _iconDisabled = iconDisabled,
        _onChanged = onChanged,
        _color = color,
        _iconSize = iconSize,
        _style = style;

  @override
  State<IconSwitch> createState() => _IconSwitchState();
}

class _IconSwitchState extends State<IconSwitch> {
  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: widget._color,
      iconSize: widget._iconSize,
      style: widget._style,
      onPressed: () {
        setState(() {
          _isEnabled = !_isEnabled;
        });
        widget._onChanged(_isEnabled);
      },
      icon: _isEnabled ? widget._iconEnabled : widget._iconDisabled,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
