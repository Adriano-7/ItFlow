import 'package:flutter/material.dart';
import 'package:itflowapp/theme/app_theme.dart';

class ScrolableButtonRow extends StatefulWidget{
  final List<String> options;
  final Function(int) onSelected;

  const ScrolableButtonRow({Key? key, required this.options, required this.onSelected}) : super(key: key);

  @override
  _ScrolableButtonRow createState() => _ScrolableButtonRow();
}

class _ScrolableButtonRow extends State<ScrolableButtonRow>{
  int _selectedOption = -1;

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: List.generate(widget.options.length, (index) {
        final isSelected = index == _selectedOption;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: (){setState(() {
              _selectedOption = index;
            });
            widget.onSelected(index);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: isSelected ? AppColors.green : AppColors.black2,
            ),
            child: Text(
              widget.options[index],
              style: TextStyle(
                color: isSelected ? AppColors.black : AppColors.white,
                fontSize: 16,
              ),
            )
          ),
        );
      }),
      ),
    );
  }
}