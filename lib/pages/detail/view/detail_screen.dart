// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:quran_alkarim/core/colors.dart';
// import 'package:quran_alkarim/data/model/surah_detail.dart';
// import 'package:quran_alkarim/pages/detail/bloc/detail_bloc.dart';

// class DetailScreen extends StatefulWidget {
//   final int noSurat;
//   const DetailScreen({super.key, required this.noSurat});

//   @override
//   State<DetailScreen> createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {
//   AudioPlayer _audioPlayer = AudioPlayer();
//   bool isPlaying = false;
//   int? playingAyatIndex;

//   void _playAudio(String url, int index) async {
//     if (isPlaying && playingAyatIndex == index) {
//       await _audioPlayer.pause();
//       setState(() {
//         isPlaying = false;
//         playingAyatIndex = null;
//       });
//     } else {
//       await _audioPlayer.play(UrlSource(url));
//       setState(() {
//         isPlaying = true;
//         playingAyatIndex = index;
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("TEST NO SURAT: ${widget.noSurat}");
//     // context.read<DetailBloc>().add(FetchSurahDetail(noSurat: widget.noSurat));
//     return BlocProvider(
//         create: (context) => DetailBloc()..add(FetchSurahDetail(noSurat: widget.noSurat)),
//         child: Scaffold(
//           backgroundColor: AppColors.darkBackground,
//           body: BlocBuilder(builder: (context, state) {
//             return Text("");
//             // if (state.status == DetailStatus.loading) {

//             // }
//           }),
//         ));
//     // return FutureBuilder<SurahDetail>(
//     //   future: _getDetailSurah(),
//     //   initialData: null,
//     //   builder: ((context, snapshot) {
//     //     if (snapshot.connectionState == ConnectionState.waiting) {
//     //       return Center(
//     //         child: CircularProgressIndicator(),
//     //       );
//     //     } else if (snapshot.hasError) {
//     //       // Handle errors from the Future
//     //       print("snapshot.error: ${snapshot.error}");
//     //       return Center(
//     //         child: Text('Error: ${snapshot.error}'),
//     //       );
//     //     } else if (!snapshot.hasData || snapshot.data == null) {
//     //       // Handle the case where the data is null
//     //       return Center(
//     //         child: Text('No data available'),
//     //       );
//     //     }

//     //     SurahDetail surahDetail = snapshot.data!;
//     //     return Scaffold(
//     //       backgroundColor: AppColors.backgroundDark,
//     //       appBar: _appBar(context: context, surahDetail: surahDetail),
//     //       body: NestedScrollView(
//     //         headerSliverBuilder: (context, innerBoxIsScrolled) => [
//     //           SliverToBoxAdapter(
//     //             child: _details(surahDetail: surahDetail),
//     //           )
//     //         ],
//     //         body: Padding(
//     //           padding: const EdgeInsets.symmetric(horizontal: 24),
//     //           child: Container(),
//     //           // child: ListView.separated(
//     //           //   itemBuilder: (context, index) =>
//     //           //       _ayatItem(ayat: surah.data!.ayat!.elementAt(index + (widget.noSurat == 1 ? 1 : 0))),
//     //           //   itemCount: surah.data!.jumlahAyat! + (widget.noSurat == 1 ? -1 : 0),
//     //           //   separatorBuilder: (context, index) => Container(),
//     //           // ),
//     //         ),
//     //       ),
//     //     );
//     //   }),
//     // );
//   }

//   Widget _ayatItem({required SurahDetail ayat}) => Padding(
//         padding: const EdgeInsets.only(top: 24),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//               decoration: BoxDecoration(color: AppColors.gray, borderRadius: BorderRadius.circular(10)),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 27,
//                     height: 27,
//                     decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(27 / 2)),
//                     child: Center(
//                       child: Text(
//                         // '${ayat.nomorAyat}',
//                         '',
//                         style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                   const Spacer(),
//                   const Icon(
//                     Icons.share_outlined,
//                     color: Colors.white,
//                   ),
//                   const SizedBox(
//                     width: 16,
//                   ),
//                   IconButton(
//                     onPressed: () => {
//                       // print(ayat.audio),
//                     },
//                     icon: Icon(
//                       Icons.play_arrow_outlined,
//                     ),
//                     color: Colors.white,
//                   ),
//                   const SizedBox(
//                     width: 16,
//                   ),
//                   const Icon(
//                     Icons.bookmark_outline,
//                     color: Colors.white,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 24,
//             ),
//             Text(
//               // ayat.teksArab,?
//               "",
//               style: GoogleFonts.amiri(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
//               textAlign: TextAlign.right,
//             ),
//             const SizedBox(
//               height: 16,
//             ),
//             Text(
//               // ayat.teksLatin,
//               "",
//               style: GoogleFonts.poppins(color: AppColors.text, fontSize: 16),
//             )
//           ],
//         ),
//       );

//   Widget _details({required SurahDetail surahDetail}) => Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Stack(children: [
//           Container(
//             height: 257,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 gradient: const LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     stops: [0, .6, 1],
//                     colors: [Color(0xFFDF98FA), Color(0xFFB070FD), Color(0xFF9055FF)])),
//           ),
//           Positioned(
//               bottom: 0,
//               right: 0,
//               child: Opacity(
//                   opacity: .2,
//                   child: SvgPicture.asset(
//                     'assets/svgs/quran.svg',
//                     width: 324 - 55,
//                   ))),
//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(28),
//             child: Column(
//               children: [
//                 Text(
//                   surahDetail.data.namaLatin,
//                   style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 26),
//                 ),
//                 const SizedBox(
//                   height: 4,
//                 ),
//                 Text(
//                   surahDetail.data.namaLatin,
//                   style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
//                 ),
//                 Divider(
//                   color: Colors.white.withOpacity(.35),
//                   thickness: 2,
//                   height: 32,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       surahDetail.data.tempatTurun,
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Container(
//                       width: 4,
//                       height: 4,
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: Colors.white),
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       "${surahDetail.data.jumlahAyat} Ayat",
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 32,
//                 ),
//                 SvgPicture.asset('assets/svgs/bismillah.svg')
//               ],
//             ),
//           )
//         ]),
//       );

//   AppBar _appBar({required BuildContext context, required SurahDetail surahDetail}) => AppBar(
//         backgroundColor: AppColors.backgroundDark,
//         automaticallyImplyLeading: false,
//         elevation: 0,
//         title: Row(
//           children: [
//             IconButton(
//                 onPressed: (() => Navigator.of(context).pop()), icon: SvgPicture.asset('assets/svgs/back-icon.svg')),
//             const SizedBox(
//               width: 24,
//             ),
//             Text(
//               surahDetail.data.namaLatin,
//               style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//             ),
//             // const Spacer(),
//             // IconButton(onPressed: (() => {}), icon: SvgPicture.asset('assets/svgs/search-icon.svg')),
//           ],
//         ),
//       );
// }
