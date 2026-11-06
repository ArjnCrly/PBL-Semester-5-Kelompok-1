import 'package:flutter/material.dart';

import '../models/diagnosis.dart';
import '../theme/app_theme.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({
    super.key,
    required this.diagnosis,
    required this.onSave,
    required this.onShare,
    required this.onCorrect,
  });

  final Diagnosis diagnosis;
  final VoidCallback onSave;
  final VoidCallback onShare;
  final VoidCallback onCorrect;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: AspectRatio(
            aspectRatio: 398 / 298,
            child: Image.asset(diagnosis.imagePath, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 28),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: DcColors.surface,
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(color: DcColors.shadow, blurRadius: 16, offset: Offset(0, 4)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('HASIL DIAGNOSIS AI',
                            style: dc(12, weight: FontWeight.w600, color: DcColors.textSecondary, letterSpacing: 0.5)),
                        const SizedBox(height: 2),
                        Text(diagnosis.name, style: dc(22, weight: FontWeight.w800)),
                      ],
                    ),
                  ),
                  _ConfidenceBadge(label: '${diagnosis.confidenceLabel} Yakin'),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: DcColors.container,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _DetailRow(
                      icon: Icons.visibility_outlined,
                      iconBg: DcColors.blueContainer,
                      iconColor: const Color(0xFF2B3A67),
                      title: 'Gejala Terdeteksi',
                      body: diagnosis.symptom,
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      icon: Icons.bug_report_outlined,
                      iconBg: DcColors.blueContainer,
                      iconColor: const Color(0xFF2B3A67),
                      title: 'Penyebab',
                      body: diagnosis.cause,
                    ),
                    const SizedBox(height: 12),
                    _DetailRow(
                      icon: Icons.healing_rounded,
                      iconBg: DcColors.greenContainer,
                      iconColor: DcColors.onGreen,
                      title: 'Rekomendasi Penanganan',
                      titleColor: DcColors.onGreen,
                      body: diagnosis.recommendation,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: _ActionButton(icon: Icons.share_outlined, label: 'Bagikan Analisis', onTap: onShare),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _ActionButton(icon: Icons.bookmark_border_rounded, label: 'Simpan Riwayat', onTap: onSave),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Center(
                child: TextButton.icon(
                  onPressed: onCorrect,
                  icon: const Icon(Icons.edit_note_rounded, size: 20, color: DcColors.textSecondary),
                  label: Text('Koreksi Manual Diagnosis',
                      style: dc(14, weight: FontWeight.w700, color: DcColors.textSecondary)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ConfidenceBadge extends StatelessWidget {
  const _ConfidenceBadge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: DcColors.pinkContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.verified_outlined, size: 16, color: DcColors.primaryDark),
          const SizedBox(width: 5),
          Text(label, style: dc(12.5, weight: FontWeight.w800, color: DcColors.primaryDark)),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.title,
    required this.body,
    this.titleColor = DcColors.textPrimary,
  });

  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String title;
  final String body;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 16, color: iconColor),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: dc(13, weight: FontWeight.w700, color: titleColor)),
              const SizedBox(height: 1),
              Text(body, style: dc(14, height: 1.35)),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.label, required this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 20),
      label: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(label, style: dc(14.5, weight: FontWeight.w700, color: Colors.white)),
      ),
      style: FilledButton.styleFrom(
        backgroundColor: DcColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(52),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
