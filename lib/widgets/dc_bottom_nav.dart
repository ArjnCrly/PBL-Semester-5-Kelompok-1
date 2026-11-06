import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class _NavItem {
  const _NavItem(this.label, this.icon, this.activeIcon);
  final String label;
  final IconData icon;
  final IconData activeIcon;
}

/// Menu bawah: Beranda, Scan, Riwayat, Panduan.
class DcBottomNav extends StatelessWidget {
  const DcBottomNav({super.key, required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  static const _items = [
    _NavItem('Beranda', Icons.home_outlined, Icons.home_rounded),
    _NavItem('Scan', Icons.photo_camera_outlined, Icons.photo_camera_rounded),
    _NavItem('Riwayat', Icons.history_rounded, Icons.history_rounded),
    _NavItem('Panduan', Icons.menu_book_outlined, Icons.menu_book_rounded),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFFEFEFF),
        boxShadow: [
          BoxShadow(color: DcColors.shadow, blurRadius: 16, offset: Offset(0, -2)),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 70,
          child: Row(
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              final active = i == currentIndex;
              final color = active ? DcColors.primary : DcColors.textPrimary;
              return Expanded(
                child: InkWell(
                  onTap: () => onTap(i),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(active ? item.activeIcon : item.icon, color: color, size: 26),
                      const SizedBox(height: 4),
                      Text(
                        item.label,
                        style: dc(12, weight: active ? FontWeight.w800 : FontWeight.w700, color: color),
                      ),
                    ],
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
