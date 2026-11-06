import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Placeholder: isi menu "Panduan" belum ada di desain.
class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.menu_book_outlined, size: 48, color: DcColors.textMuted),
          const SizedBox(height: 12),
          Text('Panduan', style: dc(20, weight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text('Konten panduan belum tersedia.', style: dc(14, color: DcColors.textSecondary)),
        ],
      ),
    );
  }
}
