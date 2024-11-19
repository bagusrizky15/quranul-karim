import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_alkarim/core/colors.dart';
import 'package:quran_alkarim/data/model/surah_detail.dart';
import 'package:quran_alkarim/pages/detail/bloc/detail_bloc.dart';

class DetailScreen extends StatefulWidget {
  final String namaSurah;
  final int nomorSurah;
  const DetailScreen({super.key, required this.namaSurah, required this.nomorSurah});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailBloc()..add(FetchSurahDetail(nomorSurah: widget.nomorSurah)),
      child: Scaffold(
        appBar: _appBar(context: context, namaSurah: widget.namaSurah),
        backgroundColor: AppColors.bgLight,
        body: BlocBuilder<DetailBloc, DetailState>(builder: (context, state) {
          if (state is DetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailError) {
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
                      context.read<DetailBloc>().add(FetchSurahDetail(nomorSurah: widget.nomorSurah));
                    },
                    child: Text('Refresh', style: GoogleFonts.poppins(color: AppColors.txPrimary, fontSize: 16)),
                  ),
                ],
              ),
            );
          } else if (state is DetailLoaded) {
            final surahDetail = state.surahDetail;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  children: [
                    ...surahDetail.data.ayat.map((ayat) => _ayatItem(ayat)).toList(),
                  ],
                ),
              );
          } else {
            return Container();
          }
        }),
      ),
    );
  }

  AppBar _appBar({required BuildContext context, required String namaSurah}) => AppBar(
        backgroundColor: AppColors.bgLight,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          children: [
            IconButton(
                onPressed: (() => Navigator.of(context).pop()),
                icon: SvgPicture.asset('assets/svgs/ic_back_arrow.svg', color: AppColors.bgDark)),
            const SizedBox(
              width: 24,
            ),
            Text(
              namaSurah,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.txPrimary),
            ),
          ],
        ),
      );

      Widget _ayatItem(Ayat ayat) => Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              ayat.teksArab,
              style: GoogleFonts.amiri(color: AppColors.txPrimary, fontWeight: FontWeight.bold, fontSize: 24),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              ayat.teksIndonesia,
              style: GoogleFonts.poppins(color: AppColors.txPrimary, fontSize: 16),
            ),
          ],
        ),
      );
}
