import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Header: logo + "DragonCare" + sub-judul layar aktif.
class DcAppBar extends StatelessWidget {
  const DcAppBar({super.key, required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: DcColors.background,
        boxShadow: [
          BoxShadow(color: DcColors.shadow, blurRadius: 12, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          Image.asset('assets/images/logo.png', width: 38, height: 38),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DragonCare',
                style: dc(19, weight: FontWeight.w800, color: DcColors.primary, height: 1.1),
              ),
              Text(
                subtitle,
                style: dc(12, weight: FontWeight.w500, color: DcColors.textSecondary, height: 1.2),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
