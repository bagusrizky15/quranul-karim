import 'package:flutter/material.dart';
import 'package:quran_alkarim/core/colors.dart';

class HijbTab extends StatelessWidget {
  const HijbTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Center(
        child: Text('Hijb Tab'),
      ),
    );
  }
}