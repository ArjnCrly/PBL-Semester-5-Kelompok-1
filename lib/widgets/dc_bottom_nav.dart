import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'animated_press_button.dart';

class _NavItem {
  const _NavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
}

class DcBottomNav extends StatelessWidget {
  const DcBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    _NavItem(
      label: 'Beranda',
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
    ),
    _NavItem(
      label: 'Scan',
      icon: Icons.photo_camera_outlined,
      activeIcon: Icons.photo_camera_rounded,
    ),
    _NavItem(
      label: 'Riwayat',
      icon: Icons.history_rounded,
      activeIcon: Icons.history_rounded,
    ),
    _NavItem(
      label: 'Panduan',
      icon: Icons.menu_book_outlined,
      activeIcon: Icons.menu_book_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFF),
        boxShadow: [
          BoxShadow(
            color: DcColors.shadow.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, -1),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: Colors.black.withValues(alpha: 0.04),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 68,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isActive = index == currentIndex;

              return Expanded(
                child: AnimatedPress(
                  scaleAmount: 0.90,
                  onTap: () => onTap(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive
                          ? DcColors.primary.withValues(alpha: 0.09)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedScale(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutBack,
                          scale: isActive ? 1.15 : 1.0,
                          child: Icon(
                            isActive ? item.activeIcon : item.icon,
                            color: isActive
                                ? DcColors.primary
                                : DcColors.textMuted,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 3),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: dc(
                            11.5,
                            weight: isActive
                                ? FontWeight.w800
                                : FontWeight.w600,
                            color: isActive
                                ? DcColors.primary
                                : DcColors.textMuted,
                          ),
                          child: Text(item.label),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
