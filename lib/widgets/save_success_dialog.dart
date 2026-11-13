import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/diagnosis.dart';
import '../theme/app_theme.dart';
import '../utils/format.dart';

enum SaveDialogAction { openHistory, scanAgain }

/// Pop-up "Riwayat Berhasil Disimpan!" dengan latar buram.
/// Mengembalikan aksi yang dipilih (null bila ditutup dengan mengetuk luar).
Future<SaveDialogAction?> showSaveSuccessDialog(
  BuildContext context,
  Diagnosis diagnosis,
) {
  return showGeneralDialog<SaveDialogAction>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Tutup',
    barrierColor: const Color(0x66141B2C),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (ctx, a1, a2) => _SaveSuccessDialog(diagnosis: diagnosis),
    transitionBuilder: (ctx, anim, secondary, child) {
      return FadeTransition(
        opacity: anim,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.94, end: 1).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        ),
      );
    },
  );
}

class _SaveSuccessDialog extends StatelessWidget {
  const _SaveSuccessDialog({required this.diagnosis});

  final Diagnosis diagnosis;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
          decoration: BoxDecoration(
            color: DcColors.surface,
            borderRadius: BorderRadius.circular(28),
            boxShadow: const [
              BoxShadow(
                color: Color(0x29141B2C),
                blurRadius: 32,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const _SuccessIcon(),
              const SizedBox(height: 18),
              Text(
                'Riwayat Berhasil Disimpan!',
                textAlign: TextAlign.center,
                style: dc(22, weight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                'Data diagnosis dan foto tanaman telah tersimpan ke riwayat pemantauan Anda.',
                textAlign: TextAlign.center,
                style: dc(14.5, color: DcColors.textSecondary, height: 1.4),
              ),
              const SizedBox(height: 18),
              _Summary(diagnosis: diagnosis),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () =>
                      Navigator.of(context).pop(SaveDialogAction.openHistory),
                  icon: const Icon(Icons.history_rounded, size: 22),
                  label: Text(
                    'Lihat di Riwayat',
                    style: dc(16, weight: FontWeight.w700, color: Colors.white),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: DcColors.primary,
                    minimumSize: const Size.fromHeight(54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              TextButton.icon(
                onPressed: () =>
                    Navigator.of(context).pop(SaveDialogAction.scanAgain),
                icon: const Icon(
                  Icons.photo_camera_outlined,
                  size: 20,
                  color: DcColors.textSecondary,
                ),
                label: Text(
                  'Selesai & Pindai Lagi',
                  style: dc(
                    15,
                    weight: FontWeight.w700,
                    color: DcColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuccessIcon extends StatelessWidget {
  const _SuccessIcon();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE3F7EC),
            ),
          ),
          Container(
            width: 78,
            height: 78,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: DcColors.greenContainer,
            ),
            child: Center(
              child: Container(
                width: 38,
                height: 38,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF1B6B4F),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  color: Colors.white,
                  size: 26,
                ),
              ),
            ),
          ),
          Positioned(
            right: 4,
            bottom: 8,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: DcColors.primary,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: const Icon(
                Icons.eco_outlined,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.diagnosis});

  final Diagnosis diagnosis;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: DcColors.container,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          _Row(
            icon: Icons.local_florist_outlined,
            label: 'Tanaman',
            value: Text(diagnosis.name, style: dc(14, weight: FontWeight.w800)),
          ),
          const SizedBox(height: 12),
          _Row(
            icon: Icons.bar_chart_rounded,
            label: 'Tingkat Akurasi',
            value: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
              decoration: BoxDecoration(
                color: DcColors.greenContainer.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                diagnosis.confidenceLabel,
                style: dc(
                  13.5,
                  weight: FontWeight.w800,
                  color: DcColors.onGreen,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          _Row(
            icon: Icons.schedule_rounded,
            label: 'Waktu',
            value: Text(
              formatTanggalJamWib(diagnosis.time),
              style: dc(13, weight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 12),
          _Row(
            icon: Icons.cached_rounded,
            label: 'Status',
            value: Row(
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
                  'Tersimpan Lokal & Cloud',
                  style: dc(
                    13,
                    weight: FontWeight.w800,
                    color: DcColors.onGreen,
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

class _Row extends StatelessWidget {
  const _Row({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: DcColors.textSecondary),
        const SizedBox(width: 8),
        Text(label, style: dc(13.5, color: DcColors.textSecondary)),
        const Spacer(),
        value,
      ],
    );
  }
}
