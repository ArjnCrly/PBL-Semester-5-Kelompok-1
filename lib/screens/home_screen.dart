import 'package:flutter/material.dart';

import '../state/history_store.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_press_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onStartScan,
    this.onOpenHistory,
    this.onOpenGuide,
  });

  final VoidCallback onStartScan;
  final VoidCallback? onOpenHistory;
  final VoidCallback? onOpenGuide;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: _PulsingStatusChip(),
        ),
        const SizedBox(height: 14),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, Selamat Datang! 👋',
                    style: dc(26, weight: FontWeight.w800, height: 1.2),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Pantau kesehatan kebun buah naga Anda hari ini.',
                    style: dc(14.5, color: DcColors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),

        _ScanCard(onStartScan: onStartScan),
        const SizedBox(height: 22),

        AnimatedBuilder(
          animation: HistoryStore.instance,
          builder: (context, _) {
            final weeklyCount = HistoryStore.instance.weeklyScans;
            return Row(
              children: [
                Expanded(
                  child: _StatCard(
                    icon: Icons.verified_rounded,
                    iconBg: DcColors.greenContainer,
                    iconColor: DcColors.onGreen,
                    value: 'Aman',
                    label: 'Kondisi Kebun',
                    subtitle: 'Tidak ada wabah kritis',
                    onTap: onOpenHistory,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: _StatCard(
                    icon: Icons.history_rounded,
                    iconBg: DcColors.blueContainer,
                    iconColor: const Color(0xFF2B3A67),
                    value: '$weeklyCount Kali',
                    label: 'Scan Minggu Ini',
                    subtitle: 'Ketuk untuk detail',
                    onTap: onOpenHistory,
                  ),
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 26),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tips Perawatan Cepat',
              style: dc(18, weight: FontWeight.w800),
            ),
            if (onOpenGuide != null)
              AnimatedPress(
                onTap: onOpenGuide,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 4,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Panduan Lengkap',
                        style: dc(
                          13,
                          weight: FontWeight.w700,
                          color: DcColors.primary,
                        ),
                      ),
                      const SizedBox(width: 2),
                      const Icon(
                        Icons.chevron_right_rounded,
                        size: 18,
                        color: DcColors.primary,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),

        SizedBox(
          height: 130,
          child: ListView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            children: [
              _TipItem(
                emoji: '💧',
                title: 'Penyiraman Seimbang',
                desc:
                    'Hindari genangan air pada akar untuk cegah busuk pangkal batang.',
                color: const Color(0xFFE8F2FF),
                onTap: onOpenGuide,
              ),
              const SizedBox(width: 12),
              _TipItem(
                emoji: '✂️',
                title: 'Pemangkasan Cabang',
                desc:
                    'Pangkas cabang yang terserang bercak agar nutrisi tetap optimal.',
                color: const Color(0xFFFFF4E8),
                onTap: onOpenGuide,
              ),
              const SizedBox(width: 12),
              _TipItem(
                emoji: '☀️',
                title: 'Cahaya Maksimal',
                desc:
                    'Pastikan terkena sinar matahari langsung minimal 6 jam sehari.',
                color: const Color(0xFFEAF8ED),
                onTap: onOpenGuide,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PulsingStatusChip extends StatefulWidget {
  const _PulsingStatusChip();

  @override
  State<_PulsingStatusChip> createState() => _PulsingStatusChipState();
}

class _PulsingStatusChipState extends State<_PulsingStatusChip>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);

    _glowAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: DcColors.greenContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: DcColors.onGreen.withValues(alpha: 0.18),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _glowAnimation,
            builder: (context, _) => Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: DcColors.onGreen,
                boxShadow: [
                  BoxShadow(
                    color: DcColors.onGreen.withValues(
                      alpha: _glowAnimation.value * 0.7,
                    ),
                    blurRadius: 5 * _glowAnimation.value,
                    spreadRadius: 2 * _glowAnimation.value,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Sistem Siap Operasi',
            style: dc(12, weight: FontWeight.w700, color: DcColors.onGreen),
          ),
        ],
      ),
    );
  }
}

class _ScanCard extends StatelessWidget {
  const _ScanCard({required this.onStartScan});

  final VoidCallback onStartScan;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: DcColors.surface,
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14141B2C),
            blurRadius: 22,
            offset: Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: Colors.black.withValues(alpha: 0.04),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: AspectRatio(
              aspectRatio: 336 / 185,
              child: Image.asset('assets/images/kebun.jpg', fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 18),

          Text('Identifikasi Tanaman', style: dc(20, weight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(
            'Pindai batang atau buah naga untuk mendeteksi penyakit secara instan dengan kecerdasan buatan.',
            style: dc(14, color: DcColors.textSecondary, height: 1.4),
          ),
          const SizedBox(height: 20),

          DcAnimatedButton(
            onPressed: onStartScan,
            icon: Icons.photo_camera_rounded,
            label: 'Mulai Scan Sekarang',
            height: 56,
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.value,
    required this.label,
    required this.subtitle,
    this.onTap,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String value;
  final String label;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedPress(
      onTap: onTap,
      scaleAmount: 0.96,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: DcColors.container,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.03),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(shape: BoxShape.circle, color: iconBg),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(height: 12),
            Text(value, style: dc(20, weight: FontWeight.w800)),
            const SizedBox(height: 2),
            Text(
              label,
              style: dc(
                13,
                weight: FontWeight.w700,
                color: DcColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: dc(11, color: DcColors.textMuted),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  const _TipItem({
    required this.emoji,
    required this.title,
    required this.desc,
    required this.color,
    this.onTap,
  });

  final String emoji;
  final String title;
  final String desc;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedPress(
      onTap: onTap,
      scaleAmount: 0.97,
      child: Container(
        width: 220,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: Colors.black.withValues(alpha: 0.04),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(emoji, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: dc(13.5, weight: FontWeight.w800),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                desc,
                style: dc(12, color: DcColors.textSecondary, height: 1.35),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
