import 'package:flutter/material.dart';

import '../models/diagnosis.dart';
import '../state/history_store.dart';
import '../widgets/save_success_dialog.dart';
import 'analysis_screen.dart';
import 'scan_screen.dart';

/// Mengatur alur tab Scan: kamera -> hasil analisis -> simpan -> pop-up.
class ScanFlow extends StatefulWidget {
  const ScanFlow({super.key, required this.onOpenHistory});

  final VoidCallback onOpenHistory;

  @override
  State<ScanFlow> createState() => _ScanFlowState();
}

class _ScanFlowState extends State<ScanFlow> {
  Diagnosis? _result;

  void _capture() {
    // TODO: ganti dengan hasil kamera/galeri + inferensi model AI.
    HistoryStore.instance.registerScan();
    setState(() => _result = Diagnosis.sample());
  }

  Future<void> _save() async {
    final d = _result;
    if (d == null) return;
    HistoryStore.instance.addFromDiagnosis(d);
    final action = await showSaveSuccessDialog(context, d);
    if (!mounted) return;
    setState(() => _result = null);
    if (action == SaveDialogAction.openHistory) widget.onOpenHistory();
  }

  void _toast(String msg) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final d = _result;
    if (d == null) {
      return ScanScreen(onCapture: _capture, onPickGallery: _capture);
    }
    return AnalysisScreen(
      diagnosis: d,
      onSave: _save,
      // Layar tujuan belum ada di desain; hubungkan saat sudah tersedia.
      onShare: () => _toast('Fitur bagikan belum tersambung.'),
      onCorrect: () => _toast('Layar koreksi manual belum tersedia.'),
    );
  }
}
