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
        bottomNavigationBar: _bottomNavigationBar(),
        appBar: _appBar(),
        body: BlocProvider(
          create: (context) => HomeScreenBloc()..add(HomeScreenFetchData()),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Scaffold(
              backgroundColor: AppColors.lightBackground,
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
                            onPressed: () {
                              context.read<HomeScreenBloc>().add(HomeScreenFetchData());
                            },
                            child: Text('Refresh'),
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
          ),
        ));
  }

  Widget _surahItem(Datum surah, BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(noSurat: surah.nomor)));
        print("Log - Clicked");
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
                        color: AppColors.primaryText,
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
                      color: AppColors.primaryText,
                      fontSize: 18,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        surah.arti.toString().split('.').last,
                        style: GoogleFonts.poppins(
                          color: AppColors.secondaryText,
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
              "${surah.nama}",
              style: GoogleFonts.amiri(
                color: AppColors.text,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerView() {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 160,
              width: double.infinity,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFDF98FA),
                      AppColors.primary.withOpacity(0.5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30)),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: SvgPicture.asset(AppAssets.imageQuran),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.iconBook, height: 25, width: 25),
                      SizedBox(width: 10),
                      Text(
                        AppStrings.headingBanner,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Al-Fatihah",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "Ayat ke - 7",
                    style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        backgroundColor: AppColors.lightBackground,
        selectedItemColor: AppColors.primaryText,
        unselectedItemColor: AppColors.secondaryText,
        items: [
          _bottomNavBarItem(AppAssets.iconQuran, AppStrings.btnQuranTitle),
          _bottomNavBarItem(AppAssets.iconPray, AppStrings.navSettingTitle),
          _bottomNavBarItem(AppAssets.iconBookmark, AppStrings.btnBookmarkTitle)
        ],
      );

  BottomNavigationBarItem _bottomNavBarItem(String icon, String label) {
    return BottomNavigationBarItem(
        // ignore: deprecated_member_use
        icon: SvgPicture.asset(icon, color: AppColors.text),
        activeIcon: SvgPicture.asset(
          icon,
          // ignore: deprecated_member_use
          color: AppColors.primary,
        ),
        label: label);
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.lightBackground,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.appName,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: AppColors.primaryText),
          ),
        ],
      ),
    );
  }
}
