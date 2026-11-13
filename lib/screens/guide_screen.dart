import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/animated_press_button.dart';

class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      children: [
        Text('Panduan & Edukasi 📚', style: dc(24, weight: FontWeight.w800)),
        const SizedBox(height: 4),
        Text(
          'Pedoman lengkap pemeliharaan dan penanganan hama buah naga.',
          style: dc(14, color: DcColors.textSecondary),
        ),
        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2B3A67), Color(0xFF1B2440)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1B2440).withValues(alpha: 0.25),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.camera_enhance_rounded,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Tips Pengambilan Foto Akurat',
                      style: dc(
                        16,
                        weight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                '• Pastikan pencahayaan terang (siang hari atau cahaya langsung).\n'
                '• Dekatkan kamera sekitar 15-25 cm pada bercak/gejala.\n'
                '• Hindari foto buram (blur) atau backlight.',
                style: dc(
                  13,
                  color: Colors.white.withValues(alpha: 0.88),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        Text('Penyakit Umum Buah Naga', style: dc(18, weight: FontWeight.w800)),
        const SizedBox(height: 12),

        const _DiseaseGuideCard(
          title: 'Kanker Batang (Stem Canker)',
          pathogen: 'Neoscytalidium dimidiatum',
          symptoms:
              'Bercak melingkar berwarna oranye kemerahan yang berkembang menjadi cekung abu-abu dan rapuh.',
          action:
              'Pangkas cabang yang terinfeksi berat dan semprotkan fungisida tembaga secara berkala.',
          severity: 'Tinggi',
          severityColor: DcColors.primary,
        ),
        const SizedBox(height: 14),

        const _DiseaseGuideCard(
          title: 'Busuk Lunak Bakteri (Soft Rot)',
          pathogen: 'Dickeya / Pectobacterium',
          symptoms:
              'Jaringan batang menjadi lunak berair, berlendir kekuningan, dan mengeluarkan bau tidak sedap.',
          action:
              'Sterilkan pisau pangkas, buang bagian membusuk, dan kurangi kelembapan kebun.',
          severity: 'Sedang',
          severityColor: Color(0xFFD97706),
        ),
        const SizedBox(height: 14),

        const _DiseaseGuideCard(
          title: 'Antraknosa (Anthracnose)',
          pathogen: 'Colletotrichum gloeosporioides',
          symptoms:
              'Bercak cokelat kehitaman konsentris pada kulit buah atau tepi sirip cabang.',
          action:
              'Tingkatkan sirkulasi udara, hindari luka mekanis, gunakan fungisida protektif.',
          severity: 'Ringan',
          severityColor: Color(0xFF2563EB),
        ),
      ],
    );
  }
}

class _DiseaseGuideCard extends StatelessWidget {
  const _DiseaseGuideCard({
    required this.title,
    required this.pathogen,
    required this.symptoms,
    required this.action,
    required this.severity,
    required this.severityColor,
  });

  final String title;
  final String pathogen;
  final String symptoms;
  final String action;
  final String severity;
  final Color severityColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: DcColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F141B2C),
            blurRadius: 14,
            offset: Offset(0, 4),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(title, style: dc(15.5, weight: FontWeight.w800)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                decoration: BoxDecoration(
                  color: severityColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  severity,
                  style: dc(11, weight: FontWeight.w800, color: severityColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            pathogen,
            style: dc(12, weight: FontWeight.w600, color: DcColors.textMuted),
          ),
          const SizedBox(height: 10),
          Text(
            'Gejala: $symptoms',
            style: dc(13, color: DcColors.textSecondary, height: 1.35),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: DcColors.container,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.healing_rounded,
                  size: 16,
                  color: DcColors.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    action,
                    style: dc(
                      12,
                      weight: FontWeight.w600,
                      color: DcColors.textPrimary,
                      height: 1.3,
                    ),
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
