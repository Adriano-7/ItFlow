import 'package:flutter/material.dart';
import 'package:itflowapp/theme/app_theme.dart';

class DoubleButton extends StatelessWidget {
  final void Function() _onPressedFirst;
  final void Function() _onPressedSecond;
  final Widget _childFirst;
  final Widget _childSecond;
  final double _borderRadius;

  const DoubleButton({
    Key? key,
    required void Function() onPressedFirst,
    required void Function() onPressedSecond,
    required Widget childFirst,
    required Widget childSecond,
    double borderRadius = 15,
  })  : _onPressedFirst = onPressedFirst,
        _onPressedSecond = onPressedSecond,
        _childFirst = childFirst,
        _childSecond = childSecond,
        _borderRadius = borderRadius,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: _onPressedFirst,
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(_borderRadius),
                    right: Radius.zero,
                  ),
                ),
              ),
            ),
            child: _childFirst,
          ),
        ),
        Expanded(
          child: OutlinedButton(
            onPressed: _onPressedSecond,
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.zero,
                    right: Radius.circular(_borderRadius),
                  ),
                ),
              ),
            ),
            child: _childSecond,
          ),
        ),
      ],
    );
  }
}
