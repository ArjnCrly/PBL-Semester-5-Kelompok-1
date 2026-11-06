const _bulan = [
  'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
  'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des',
];

/// Contoh: 21 Okt 2026
String formatTanggal(DateTime d) =>
    '${d.day.toString().padLeft(2, '0')} ${_bulan[d.month - 1]} ${d.year}';

/// Contoh: 14:30
String formatJam(DateTime d) =>
    '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';

/// Contoh: 21 Okt 2026 • 14:30 WIB
/// Catatan: label "WIB" ditulis tetap seperti pada desain. Gunakan zona
/// waktu perangkat/paket `timezone` bila aplikasi dipakai di luar WIB.
String formatTanggalJamWib(DateTime d) =>
    '${formatTanggal(d)} • ${formatJam(d)} WIB';
