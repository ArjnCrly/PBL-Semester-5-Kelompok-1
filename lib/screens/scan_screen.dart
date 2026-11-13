import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/animated_press_button.dart';

enum ScanTarget { fruit, stem }

class ScanScreen extends StatefulWidget {
  const ScanScreen({
    super.key,
    required this.onCapture,
    required this.onPickGallery,
  });

  final VoidCallback onCapture;
  final VoidCallback onPickGallery;

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  ScanTarget _target = ScanTarget.stem;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Column(
        children: [
          _TargetToggle(
            value: _target,
            onChanged: (t) => setState(() => _target = t),
          ),
          const SizedBox(height: 12),
          Expanded(child: _CameraPreview(target: _target)),
          const SizedBox(height: 12),
          const _TipsCard(),
          const SizedBox(height: 14),
          SizedBox(
            height: 100,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: _CaptureButton(onTap: widget.onCapture),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: _GalleryButton(onTap: widget.onPickGallery),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TargetToggle extends StatelessWidget {
  const _TargetToggle({required this.value, required this.onChanged});

  final ScanTarget value;
  final ValueChanged<ScanTarget> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: DcColors.container,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          _option(ScanTarget.fruit, Icons.apple, 'Buah Naga'),
          _option(ScanTarget.stem, Icons.eco_outlined, 'Batang Buah Naga'),
        ],
      ),
    );
  }

  Widget _option(ScanTarget t, IconData icon, String label) {
    final active = value == t;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(t),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          decoration: BoxDecoration(
            color: active ? DcColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 18,
                color: active ? Colors.white : DcColors.textPrimary,
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: dc(
                  14,
                  weight: FontWeight.w700,
                  color: active ? Colors.white : DcColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CameraPreview extends StatelessWidget {
  const _CameraPreview({required this.target});

  final ScanTarget target;

  @override
  Widget build(BuildContext context) {
    final focusLabel = target == ScanTarget.stem
        ? 'Fokus Batang Terkunci'
        : 'Fokus Buah Terkunci';
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // TODO: ganti dengan CameraPreview dari paket `camera`.
          Image.asset('assets/images/batang_sakit.jpg', fit: BoxFit.cover),
          CustomPaint(painter: _BracketPainter()),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0x1AA53149),
                    border: Border.all(
                      color: const Color(0xCCA53149),
                      width: 1.5,
                    ),
                  ),
                  child: const Icon(
                    Icons.center_focus_weak_rounded,
                    color: DcColors.primary,
                    size: 30,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xE6FFFFFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    focusLabel,
                    style: dc(12, weight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 24,
            right: 24,
            bottom: 18,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xCC2A3040),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.center_focus_weak_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Arahkan kamera ke permukaan kulit yang memiliki bercak/rusak',
                      textAlign: TextAlign.center,
                      style: dc(
                        13,
                        weight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Empat sudut bingkai bidik.
class _BracketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = DcColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    const m = 14.0; // jarak dari tepi
    const l = 26.0; // panjang garis sudut
    final w = size.width;
    final h = size.height;
    canvas.drawPath(
      Path()
        ..moveTo(m, m + l)
        ..lineTo(m, m)
        ..lineTo(m + l, m),
      p,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w - m - l, m)
        ..lineTo(w - m, m)
        ..lineTo(w - m, m + l),
      p,
    );
    canvas.drawPath(
      Path()
        ..moveTo(m, h - m - l)
        ..lineTo(m, h - m)
        ..lineTo(m + l, h - m),
      p,
    );
    canvas.drawPath(
      Path()
        ..moveTo(w - m - l, h - m)
        ..lineTo(w - m, h - m)
        ..lineTo(w - m, h - m - l),
      p,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TipsCard extends StatelessWidget {
  const _TipsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: DcColors.container,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: DcColors.pinkContainer,
            ),
            child: const Icon(
              Icons.lightbulb_outline_rounded,
              color: DcColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TIPS LAPANGAN OPTIMAL',
                  style: dc(
                    12,
                    weight: FontWeight.w800,
                    color: DcColors.primary,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Cahaya cukup terang • Jarak bidik 15–25 cm • Hindari bayangan tangan',
                  style: dc(13.5, height: 1.35),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CaptureButton extends StatelessWidget {
  const _CaptureButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedPress(
      onTap: onTap,
      scaleAmount: 0.90,
      child: Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0x2EA53149),
        ),
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: DcColors.primary,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: const [
              BoxShadow(
                color: Color(0x40A53149),
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(
            Icons.document_scanner_outlined,
            color: Colors.white,
            size: 34,
          ),
        ),
      ),
    );
  }
}

class _GalleryButton extends StatelessWidget {
  const _GalleryButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedPress(
      onTap: onTap,
      scaleAmount: 0.90,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: DcColors.blueContainer.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.photo_library_outlined, size: 24),
            const SizedBox(height: 2),
            Text('Galeri', style: dc(12, weight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
