import 'package:flutter/material.dart';

import '../state/history_store.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.onStartScan});

  final VoidCallback onStartScan;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      children: [
        const Align(alignment: Alignment.centerLeft, child: _StatusChip()),
        const SizedBox(height: 14),
        Text('Halo, Selamat Datang!', style: dc(29, weight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text('Pantau kebun buah naga Anda hari ini.',
            style: dc(15, color: DcColors.textSecondary)),
        const SizedBox(height: 26),
        _ScanCard(onStartScan: onStartScan),
        const SizedBox(height: 26),
        AnimatedBuilder(
          animation: HistoryStore.instance,
          builder: (context, _) {
            return Row(
              children: [
                const Expanded(
                  child: _StatCard(
                    icon: Icons.verified_outlined,
                    iconBg: DcColors.greenContainer,
                    iconColor: DcColors.onGreen,
                    // Aturan penentuan "Aman" belum ada di desain: statis.
                    value: 'Aman',
                    label: 'Kondisi Kebun',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _StatCard(
                    icon: Icons.history_rounded,
                    iconBg: DcColors.blueContainer,
                    iconColor: const Color(0xFF2B3A67),
                    value: '${HistoryStore.instance.weeklyScans} Kali',
                    label: 'Scan Minggu Ini',
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: DcColors.greenContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: DcColors.onGreen),
          ),
          const SizedBox(width: 8),
          Text('Sistem Siap Operasi',
              style: dc(12.5, weight: FontWeight.w700, color: DcColors.onGreen)),
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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: DcColors.surface,
        borderRadius: BorderRadius.circular(26),
        boxShadow: const [
          BoxShadow(color: Color(0x1A141B2C), blurRadius: 24, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: AspectRatio(
              aspectRatio: 336 / 196,
              child: Image.asset('assets/images/kebun.jpg', fit: BoxFit.cover),
            ),
          ),
          const SizedBox(height: 18),
          Text('Identifikasi Tanaman', style: dc(20, weight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text('Deteksi kesehatan tanaman buah naga Anda secara instan.',
              style: dc(15, color: DcColors.textSecondary, height: 1.4)),
          const SizedBox(height: 22),
          FilledButton.icon(
            onPressed: onStartScan,
            icon: const Icon(Icons.photo_camera_outlined, size: 22),
            label: Text('Mulai Scan', style: dc(16, weight: FontWeight.w700, color: Colors.white)),
            style: FilledButton.styleFrom(
              backgroundColor: DcColors.primary,
              minimumSize: const Size.fromHeight(58),
              shape: const StadiumBorder(),
            ),
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
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DcColors.container,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, color: iconBg),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(height: 12),
          Text(value, style: dc(20, weight: FontWeight.w800)),
          const SizedBox(height: 2),
          Text(label, style: dc(13, color: DcColors.textSecondary)),
        ],
      ),
    );
  }
}
