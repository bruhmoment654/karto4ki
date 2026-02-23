import 'package:flutter/material.dart';

class AppBottomNavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;

  const AppBottomNavItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });
}

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppBottomNavItem> items;

  const AppBottomNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = index == currentIndex;
            final color =
                isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant;
            final icon =
                isSelected ? (item.activeIcon ?? item.icon) : item.icon;

            return Expanded(
              child: InkWell(
                onTap: () => onTap(index),
                borderRadius: BorderRadius.circular(12),
                splashColor: colorScheme.primary.withAlpha(30),
                highlightColor: colorScheme.primary.withAlpha(15),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, color: color, size: 24),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: TextStyle(
                          color: color,
                          fontSize: 12,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
