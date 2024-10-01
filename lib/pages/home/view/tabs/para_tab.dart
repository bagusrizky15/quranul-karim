import 'package:flutter/material.dart';
import 'package:quran_alkarim/core/colors.dart';

class ParaTab extends StatelessWidget {
  const ParaTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Center(
        child: Text('Para Tab'),
      ),
    );
  }
}