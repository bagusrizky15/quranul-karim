import 'package:flutter/material.dart';
import 'package:quran_alkarim/core/colors.dart';

class PrayScreen extends StatefulWidget {
  const PrayScreen({super.key});

  @override
  State<PrayScreen> createState() => _PrayScreenState();
}

class _PrayScreenState extends State<PrayScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      body: Center(
        child: Text("Pray Screen"),
      ),
    );
  }
}