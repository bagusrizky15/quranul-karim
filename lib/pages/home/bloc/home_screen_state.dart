part of 'home_screen_bloc.dart';

enum HomeScreenStatus { init, loading, success, failure }

class HomeScreenState extends Equatable {
  HomeScreenState({
    required this.status, 
    required this.listSurah, 
    required this.listSurahDetail,
  });

  final HomeScreenStatus status;
  late final List<Datum> listSurah;
  late final List<Ayat> listSurahDetail;

  HomeScreenState.init()
      : status = HomeScreenStatus.init,
        listSurah = [],
        listSurahDetail = [];

  HomeScreenState copyWith({HomeScreenStatus? status, List<Datum>? listSurah, List<Ayat>? listSurahDetail}) {
    return HomeScreenState(
        status: status ?? this.status, 
        listSurah: listSurah ?? this.listSurah, 
        listSurahDetail: listSurahDetail ?? this.listSurahDetail
      );
  }

  @override
  // TODO: implement props
  List<Object?> get props => <Object?>[status, listSurah, listSurahDetail];
}
