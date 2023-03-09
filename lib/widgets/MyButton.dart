import 'package:flutter/material.dart';
import 'package:itflowapp/theme/app_theme.dart';

class MyButton extends StatelessWidget {
  final void Function() _onPressed;
  final String _textContent;
  final double _leftRadius;
  final double _rightRadius;
  final double _borderWidth;
  final Color _borderColor;
  final Color _backgroundColor;
  final TextStyle _textStyle;
  final double _padding;

  const MyButton({
    Key? key,
    required void Function() onPressed,
    String textContent = '',
    double leftRadius = 0,
    double rightRadius = 0,
    double borderWidth = 1,
    Color borderColor = AppColors.gray,
    Color backgroundColor = AppColors.black,
    TextStyle textStyle = const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.black),
    double verticalPadding = 0,
  }) :  _onPressed = onPressed,
        _textContent = textContent,
        _leftRadius = leftRadius,
        _rightRadius = rightRadius,
        _borderWidth = borderWidth,
        _borderColor = borderColor,
        _backgroundColor = backgroundColor,
        _textStyle = textStyle,
        _padding = verticalPadding,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(_leftRadius),
              topLeft: Radius.circular(_leftRadius),
              bottomRight: Radius.circular(_rightRadius),
              topRight: Radius.circular(_rightRadius),
            ),
          ),
        ),
        side: MaterialStateProperty.all(
          BorderSide(
            width: _borderWidth,
            color: _borderColor,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          _backgroundColor,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: _padding),
        child: Text(
          _textContent,
          style: _textStyle,
        ),
      ),
    );
  }
}
