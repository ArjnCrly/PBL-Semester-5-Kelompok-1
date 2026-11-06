import 'package:flutter/material.dart';

import '../models/history_entry.dart';
import '../state/history_store.dart';
import '../theme/app_theme.dart';

enum _Filter { all, healthy, handled }

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  _Filter _filter = _Filter.all;

  List<HistoryEntry> _apply(List<HistoryEntry> all) {
    switch (_filter) {
      case _Filter.all:
        return all;
      case _Filter.healthy:
        return all.where((e) => e.status == HistoryStatus.healthy).toList();
      case _Filter.handled:
        return all.where((e) => e.status == HistoryStatus.handled).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: HistoryStore.instance,
      builder: (context, _) {
        final items = _apply(HistoryStore.instance.entries);
        return ListView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          children: [
            Text('Riwayat Pemantauan', style: dc(26, weight: FontWeight.w800)),
            const SizedBox(height: 2),
            Text('Catatan inspeksi kebun', style: dc(15, color: DcColors.textSecondary)),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _FilterChip(label: 'Semua', active: _filter == _Filter.all, onTap: () => setState(() => _filter = _Filter.all)),
                  const SizedBox(width: 10),
                  _FilterChip(label: 'Sehat', active: _filter == _Filter.healthy, onTap: () => setState(() => _filter = _Filter.healthy)),
                  const SizedBox(width: 10),
                  _FilterChip(label: 'Selesai Ditangani', active: _filter == _Filter.handled, onTap: () => setState(() => _filter = _Filter.handled)),
                ],
              ),
            ),
            const SizedBox(height: 18),
            if (items.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text('Belum ada catatan.', style: dc(14, color: DcColors.textMuted)),
                ),
              )
            else
              for (final e in items) ...[
                _HistoryCard(entry: e),
                const SizedBox(height: 14),
              ],
            const SizedBox(height: 6),
            Center(
              child: Text(
                'Semua data tersimpan manual di perangkat',
                style: dc(13, color: DcColors.textMuted),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.active, required this.onTap});

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
          color: active ? DcColors.primary : DcColors.container,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: dc(14, weight: FontWeight.w700, color: active ? Colors.white : DcColors.textPrimary),
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.entry});

  final HistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: DcColors.surface,
      borderRadius: BorderRadius.circular(22),
      elevation: 0,
      shadowColor: DcColors.shadow,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        // TODO: buka detail catatan (layar detail belum ada di desain).
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(color: DcColors.shadow, blurRadius: 16, offset: Offset(0, 4)),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(entry.imagePath, width: 72, height: 72, fit: BoxFit.cover),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 8,
                      runSpacing: 4,
                      children: [
                        Text(entry.title, style: dc(20, weight: FontWeight.w800)),
                        _StatusBadge(status: entry.status),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text('${entry.dateLabel} • ${entry.location}',
                        style: dc(13.5, color: DcColors.textSecondary)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: DcColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});

  final HistoryStatus status;

  @override
  Widget build(BuildContext context) {
    // Hanya "Optimal" yang ada di desain; dua lainnya adalah tambahan.
    late final String label;
    late final IconData icon;
    late final Color bg;
    late final Color fg;
    switch (status) {
      case HistoryStatus.healthy:
        label = 'Optimal';
        icon = Icons.check_circle_rounded;
        bg = DcColors.greenContainer;
        fg = DcColors.onGreen;
      case HistoryStatus.needsTreatment:
        label = 'Perlu Ditangani';
        icon = Icons.error_outline_rounded;
        bg = DcColors.pinkContainer;
        fg = DcColors.primaryDark;
      case HistoryStatus.handled:
        label = 'Selesai';
        icon = Icons.task_alt_rounded;
        bg = DcColors.blueContainer;
        fg = const Color(0xFF2B3A67);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(label, style: dc(12, weight: FontWeight.w700, color: fg)),
        ],
      ),
    );
  }
}
