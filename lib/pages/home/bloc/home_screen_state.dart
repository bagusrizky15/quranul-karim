part of 'home_screen_bloc.dart';

enum HomeScreenStatus { init, loading, success, failure }

class HomeScreenState extends Equatable {
  HomeScreenState({
    required this.status,
    required this.listSurah,
  });

  final HomeScreenStatus status;
  late final List<Datum> listSurah;

  HomeScreenState.init()
      : status = HomeScreenStatus.init,
        listSurah = [];

  HomeScreenState copyWith({HomeScreenStatus? status, List<Datum>? listSurah, List<Ayat>? listSurahDetail}) {
    return HomeScreenState(
        status: status ?? this.status,
        listSurah: listSurah ?? this.listSurah,
      );
  }

  @override
  List<Object?> get props => <Object?>[status, listSurah];
}
