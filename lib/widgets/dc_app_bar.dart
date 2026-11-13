import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class DcAppBar extends StatelessWidget {
  const DcAppBar({super.key, required this.subtitle});

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFF),
        boxShadow: [
          BoxShadow(
            color: DcColors.shadow.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: Colors.black.withValues(alpha: 0.04),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/images/logo.png',
              width: 38,
              height: 38,
              errorBuilder: (_, __, ___) => Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: DcColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.eco_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DragonCare',
                style: dc(
                  19,
                  weight: FontWeight.w800,
                  color: DcColors.primary,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 2),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0.0, 0.25),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                ),
                child: Text(
                  subtitle,
                  key: ValueKey<String>(subtitle),
                  style: dc(
                    12,
                    weight: FontWeight.w600,
                    color: DcColors.textSecondary,
                    height: 1.2,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
            decoration: BoxDecoration(
              color: DcColors.container,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: DcColors.onGreen,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  'Aktif',
                  style: dc(
                    11,
                    weight: FontWeight.w700,
                    color: DcColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
