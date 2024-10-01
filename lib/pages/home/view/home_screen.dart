import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_alkarim/core/colors.dart';
import 'package:quran_alkarim/core/strings.dart';
import 'package:quran_alkarim/pages/home/view/tabs/hijb_tab.dart';
import 'package:quran_alkarim/pages/home/view/tabs/page_tab.dart';
import 'package:quran_alkarim/pages/home/view/tabs/para_tab.dart';
import 'package:quran_alkarim/pages/home/view/tabs/surah_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      bottomNavigationBar: _bottomNavigationBar(),
      appBar: _appBar(),
      body: DefaultTabController(
        length: 4,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverToBoxAdapter(
                  child: _buildBannerView(),
                ),
                SliverAppBar(
                  pinned: true,
                  elevation: 0,
                  backgroundColor: AppColors.backgroundDark,
                  automaticallyImplyLeading: false,
                  shape: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1))),
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(0),
                    child: TabBar(
                        indicatorColor: AppColors.darkPurple,
                        indicatorWeight: 3,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelColor: Colors.white,
                        unselectedLabelColor: AppColors.text,
                        tabs: [
                          Tab(text: "Surah"),
                          Tab(text: "Para"),
                          Tab(text: "Page"),
                          Tab(text: "Hijb"),
                        ]),
                  ),
                )
              ],
              body: TabBarView(children: [SurahTab(), ParaTab(), PageTab(), HijbTab()]),
            )),
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
        backgroundColor: AppColors.gray,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.text,
        items: [
          _bottomNavBarItem(AppAssets.iconQuran, AppStrings.btnQuranTitle),
          _bottomNavBarItem(AppAssets.iconPray, AppStrings.btnPrayTitle),
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
      backgroundColor: AppColors.backgroundDark,
      title: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppAssets.iconMenu),
          ),
          const SizedBox(width: 20),
          Text(
            AppStrings.appName,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
