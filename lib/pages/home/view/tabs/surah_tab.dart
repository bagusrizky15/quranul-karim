import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_alkarim/core/colors.dart';
import 'package:quran_alkarim/core/strings.dart';
import 'package:quran_alkarim/data/model/surah.dart';
import 'package:quran_alkarim/pages/home/bloc/home_screen_bloc.dart';

class SurahTab extends StatelessWidget {
  const SurahTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeScreenBloc()..add(HomeScreenFetchData()),
      child: Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
          builder: (context, state) {
            if (state.status == HomeScreenStatus.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == HomeScreenStatus.failure) {
              return Center(
                child: Text('Error to get data, please drag and refresh'),
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
                        color: AppColors.text.withOpacity(0.2),
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
    );
  }

  Widget _surahItem(Datum surah, BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.read<HomeScreenBloc>().add(HomeScreenClickedSurah(noSurat: surah.nomor));
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
                      style: GoogleFonts.amiri(
                        color: Colors.white,
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
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        surah.tempatTurun.toString().split('.').last,
                        style: GoogleFonts.poppins(
                          color: AppColors.text,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(
                          color: AppColors.text,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "${surah.jumlahAyat} Ayat",
                        style: GoogleFonts.poppins(
                          color: AppColors.text,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              surah.nama,
              style: GoogleFonts.amiri(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
