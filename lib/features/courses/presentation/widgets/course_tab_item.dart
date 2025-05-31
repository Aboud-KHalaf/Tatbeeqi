import 'package:flutter/material.dart';

class CourseTabItem extends StatelessWidget {
  final String text;
  final bool isSelected;

  const CourseTabItem({
    super.key,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: isSelected ? 12 : 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
