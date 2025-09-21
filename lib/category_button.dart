import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Color(0xFFFF69B4)
              : Colors.white, // Hot pink when selected
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Color(0xFFFF1493)
                : Color(
                    0xFFFFB6C1,
                  ), // Deep pink border when selected, light pink when not
            width: 2,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Color(0xFFFF69B4).withOpacity(0.5), // Hot pink shadow
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.shopping_cart,
              size: 16,
              color: isSelected
                  ? Colors.white
                  : Color(0xFFDA70D6), // White when selected, orchid when not
            ),
            SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Color(
                        0xFFC71585,
                      ), // White when selected, medium violet red when not
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
