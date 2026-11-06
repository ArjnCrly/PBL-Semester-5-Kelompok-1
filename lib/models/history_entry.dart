enum HistoryStatus { healthy, needsTreatment, handled }

/// Satu catatan pada layar Riwayat Pemantauan.
class HistoryEntry {
  const HistoryEntry({
    required this.title,
    required this.status,
    required this.dateLabel,
    required this.location,
    required this.imagePath,
  });

  final String title; // "Sehat" atau nama diagnosis
  final HistoryStatus status;
  final String dateLabel; // mis. "15 Okt 2026"
  final String location; // mis. "Baris Utama 04"
  final String imagePath;
}
