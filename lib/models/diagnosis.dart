/// Hasil diagnosis AI untuk satu foto tanaman.
class Diagnosis {
  const Diagnosis({
    required this.name,
    required this.confidence,
    required this.symptom,
    required this.cause,
    required this.recommendation,
    required this.imagePath,
    required this.time,
  });

  final String name;
  final double confidence; // persen, mis. 94.5
  final String symptom;
  final String cause;
  final String recommendation;
  final String imagePath;
  final DateTime time;

  String get confidenceLabel => '${confidence.toStringAsFixed(1)}%';

  /// Data contoh sesuai desain. Ganti dengan keluaran model AI/API.
  factory Diagnosis.sample() => Diagnosis(
        name: 'Busuk Batang',
        confidence: 94.5,
        symptom: 'Bercak lunak meluas pada batang.',
        cause: 'Kelembapan tinggi & infeksi jamur.',
        recommendation: 'Potong bagian busuk dan kurangi intensitas air.',
        imagePath: 'assets/images/batang_sakit.jpg',
        time: DateTime.now(),
      );
}
