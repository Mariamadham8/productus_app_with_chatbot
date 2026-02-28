import 'package:flutter/material.dart';
import '../../../../../../../core/theming/app_color.dart';
import '../../../../../../../core/theming/app_fonts.dart';

class ProductsTabBar extends StatefulWidget {
  final Function(int) onTabChanged;

  const ProductsTabBar({super.key, required this.onTabChanged});

  @override
  State<ProductsTabBar> createState() => _ProductsTabBarState();
}

class _ProductsTabBarState extends State<ProductsTabBar> {
  int _selectedIndex = 0;

  final List<String> _tabs = ['All', 'Electronics', 'Clothing', 'Home'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);
              widget.onTabChanged(index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.grey.shade300,
                ),
              ),
              child: Text(
                _tabs[index],
                style: AppFonts.font14BlackW500.copyWith(
                  color: isSelected ? Colors.white : Colors.grey.shade600,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
