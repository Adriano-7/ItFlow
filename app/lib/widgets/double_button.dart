import 'package:flutter/material.dart';
import 'package:itflowapp/theme/app_theme.dart';

// stateful widget where each button redirects to a given page, and color change to the selected button
class DoubleButton extends StatefulWidget {
  final void Function() onPressedFirst;
  final void Function() onPressedSecond;
  final Widget childFirst;
  final Widget childSecond;
  final double borderRadius;

  const DoubleButton({
    Key? key,
    required this.onPressedFirst,
    required this.onPressedSecond,
    required this.childFirst,
    required this.childSecond,
    this.borderRadius = 18,
  }) : super(key: key);

  @override
  DoubleButtonState createState() => DoubleButtonState();
}

class DoubleButtonState extends State<DoubleButton> {
  bool _isFirstSelected = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _isFirstSelected = true;
              });
              widget.onPressedFirst();
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(widget.borderRadius),
                  right: Radius.zero,
                ),
              ),
              backgroundColor: _isFirstSelected
                  ? AppColors.green
                  : Theme.of(context).primaryColor,
              foregroundColor: _isFirstSelected ? Colors.black : Colors.white,
            ),
            child: widget.childFirst,
          ),
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _isFirstSelected = false;
              });
              widget.onPressedSecond();
            },
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.horizontal(
                  left: Radius.zero,
                  right: Radius.circular(widget.borderRadius),
                ),
              ),
              backgroundColor: _isFirstSelected
                  ? Theme.of(context).primaryColor
                  : AppColors.green,
              foregroundColor: _isFirstSelected ? Colors.white : Colors.black,
            ),
            child: widget.childSecond,
          ),
        ),
      ],
    );
  }
}
