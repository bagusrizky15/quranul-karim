import 'package:flutter/material.dart';
import 'package:quran_alkarim/core/colors.dart';

class PageTab extends StatelessWidget {
  const PageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Center(
        child: Text('Page Tab'),
      ),
    );
  }
}