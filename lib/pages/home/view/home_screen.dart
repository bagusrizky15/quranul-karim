import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_alkarim/core/colors.dart';
import 'package:quran_alkarim/core/strings.dart';
import 'package:quran_alkarim/pages/bookmark/view/bookmark_screen.dart';
import 'package:quran_alkarim/pages/pray/view/pray_screen.dart';
import 'package:quran_alkarim/pages/quran/view/quran_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgLight,
      bottomNavigationBar: _bottomNavigationBar(),
      appBar: _appBar(),
      body: _selectedPage(_selectedIndex),
    );
  }

  Widget _selectedPage(int index) {
    switch (index) {
      case 0:
        return QuranScreen();
      case 1:
        return PrayScreen();
      case 2:
        return BookmarkScreen();
      default:
        return QuranScreen();
    }
  }

  BottomNavigationBar _bottomNavigationBar() => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        backgroundColor: AppColors.bgLight,
        selectedItemColor: AppColors.txPrimary,
        unselectedItemColor: AppColors.txSecondary,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
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
