import 'package:flutter/material.dart';

import '../widgets/dc_app_bar.dart';
import '../widgets/dc_bottom_nav.dart';
import 'guide_screen.dart';
import 'history_screen.dart';
import 'home_screen.dart';
import 'scan_flow.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  static const _titles = ['Beranda', 'Scan', 'Riwayat', 'Panduan'];
  int _index = 0;

  void _go(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            DcAppBar(subtitle: _titles[_index]),
            Expanded(
              child: IndexedStack(
                index: _index,
                children: [
                  HomeScreen(
                    onStartScan: () => _go(1),
                    onOpenHistory: () => _go(2),
                    onOpenGuide: () => _go(3),
                  ),
                  ScanFlow(onOpenHistory: () => _go(2)),
                  const HistoryScreen(),
                  const GuideScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: DcBottomNav(currentIndex: _index, onTap: _go),
    );
  }
}
