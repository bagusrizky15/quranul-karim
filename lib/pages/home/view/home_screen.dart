import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_alkarim/core/colors.dart';
import 'package:quran_alkarim/core/strings.dart';
import 'package:quran_alkarim/data/model/surah.dart';
import 'package:quran_alkarim/pages/home/bloc/home_screen_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgLight,
        bottomNavigationBar: _bottomNavigationBar(),
        appBar: _appBar(),
        body: BlocProvider(
          create: (context) => HomeScreenBloc()..add(HomeScreenFetchData()),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Scaffold(
              backgroundColor: AppColors.bgLight,
              body: BlocBuilder<HomeScreenBloc, HomeScreenState>(
                builder: (context, state) {
                  if (state.status == HomeScreenStatus.loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.status == HomeScreenStatus.failure) {
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
                              context.read<HomeScreenBloc>().add(HomeScreenFetchData());
                            },
                            child:
                                Text('Refresh', style: GoogleFonts.poppins(color: AppColors.txPrimary, fontSize: 16)),
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
        ));
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

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        backgroundColor: AppColors.bgLight,
        selectedItemColor: AppColors.txPrimary,
        unselectedItemColor: AppColors.txSecondary,
        items: [
          _bottomNavBarItem(AppAssets.iconQuran, AppStrings.navQuranTitle),
          _bottomNavBarItem(AppAssets.iconPray, AppStrings.navPrayTitle),
          _bottomNavBarItem(AppAssets.iconBookmark, AppStrings.navBookmarkTitle)
        ],
      );

  BottomNavigationBarItem _bottomNavBarItem(String icon, String label) {
    return BottomNavigationBarItem(
        // ignore: deprecated_member_use
        icon: SvgPicture.asset(icon, color: AppColors.txSecondary),
        activeIcon: SvgPicture.asset(
          icon,
          // ignore: deprecated_member_use
          color: AppColors.txPrimary,
        ),
        label: label);
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.bgLight,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.appName,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.txPrimary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: AppColors.txPrimary),
          ),
        ],
      ),
    );
  }
}
