import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../utils/constants.dart';

class CategoryIcon extends StatelessWidget {
  final CategoryModel category;
  final double size;
  final bool selected;

  const CategoryIcon({
    super.key,
    required this.category,
    this.size = 48,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: selected
            ? category.color
            : category.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radiusSmall),
        border: selected
            ? Border.all(color: category.color, width: 2)
            : null,
      ),
      child: Center(
        child: Text(
          category.icon,
          style: TextStyle(fontSize: size * 0.5),
        ),
      ),
    );
  }
}
