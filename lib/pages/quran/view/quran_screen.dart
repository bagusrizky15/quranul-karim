import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_alkarim/core/colors.dart';
import 'package:quran_alkarim/core/strings.dart';
import 'package:quran_alkarim/data/model/surah.dart';
import 'package:quran_alkarim/pages/quran/bloc/quran_bloc.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranState();
}

class _QuranState extends State<QuranScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranBloc()..add(QuranFetchData()),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Scaffold(
          backgroundColor: AppColors.bgLight,
          body: BlocBuilder<QuranBloc, QuranState>(
            builder: (context, state) {
              if (state.status == QuranStatus.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.status == QuranStatus.failure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error to get data, please tap refresh',
                        style: GoogleFonts.poppins(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                        onPressed: () {
                          context.read<QuranBloc>().add(QuranFetchData());
                        },
                        child: Text('Refresh', style: GoogleFonts.poppins(color: AppColors.txPrimary, fontSize: 16)),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: state.listSurah.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        _surahItem(state.listSurah[index], context),
                        SizedBox(height: 5),
                        Divider(
                          color: AppColors.txPrimary.withOpacity(0.2),
                          height: 0.5,
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _surahItem(Datum surah, BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(noSurat: surah.nomor)));
        print("LOGGER : Surah ${surah.namaLatin}");
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Stack(
              children: [
                SvgPicture.asset(AppAssets.imageNomorSurah),
                SizedBox(
                  height: 36,
                  width: 36,
                  child: Center(
                    child: Text(
                      surah.nomor.toString(),
                      style: GoogleFonts.poppins(
                        color: AppColors.txPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    surah.namaLatin,
                    style: GoogleFonts.poppins(
                      color: AppColors.txPrimary,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        surah.arti.toString().split('.').last,
                        style: GoogleFonts.poppins(
                          color: AppColors.txSecondary,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.txPrimary,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "${surah.jumlahAyat} Ayat",
                        style: GoogleFonts.poppins(
                          color: AppColors.txSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              "${surah.nama}",
              style: GoogleFonts.amiri(
                color: AppColors.txPrimary,
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

}