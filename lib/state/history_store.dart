import 'package:flutter/foundation.dart';

import '../models/diagnosis.dart';
import '../models/history_entry.dart';
import '../utils/format.dart';

/// Penyimpanan sementara di memori. Ganti dengan database lokal
/// (sqflite/drift/hive) dan/atau API sesuai kebutuhan.
class HistoryStore extends ChangeNotifier {
  HistoryStore._();
  static final HistoryStore instance = HistoryStore._();

  /// Lokasi bawaan untuk catatan baru (dari status "Plot B-14" pada desain).
  static const defaultLocation = 'Plot B-14';

  final List<HistoryEntry> _entries = [
    const HistoryEntry(
      title: 'Sehat',
      status: HistoryStatus.healthy,
      dateLabel: '15 Okt 2026',
      location: 'Baris Utama 04',
      imagePath: 'assets/images/riwayat_1.jpg',
    ),
    const HistoryEntry(
      title: 'Sehat',
      status: HistoryStatus.healthy,
      dateLabel: '10 Okt 2026',
      location: 'Blok Timur 02',
      imagePath: 'assets/images/riwayat_2.jpg',
    ),
    const HistoryEntry(
      title: 'Sehat',
      status: HistoryStatus.healthy,
      dateLabel: '04 Okt 2026',
      location: 'Blok Selatan 01',
      imagePath: 'assets/images/riwayat_3.jpg',
    ),
  ];

  int _weeklyScans = 12; // "12 Kali Scan Minggu Ini" pada desain

  List<HistoryEntry> get entries => List.unmodifiable(_entries);
  int get weeklyScans => _weeklyScans;

  void registerScan() {
    _weeklyScans++;
    notifyListeners();
  }

  void addFromDiagnosis(Diagnosis d, {String location = defaultLocation}) {
    _entries.insert(
      0,
      HistoryEntry(
        title: d.name,
        status: HistoryStatus.needsTreatment,
        dateLabel: formatTanggal(d.time),
        location: location,
        imagePath: d.imagePath,
      ),
    );
    notifyListeners();
  }
}
