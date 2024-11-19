part of 'quran_bloc.dart';

enum QuranStatus { init, loading, success, failure }

class QuranState extends Equatable {
  QuranState({
    required this.status,
    required this.listSurah,
  });

  final QuranStatus status;
  late final List<Datum> listSurah;

  QuranState.init()
      : status = QuranStatus.init,
        listSurah = [];

  QuranState copyWith({QuranStatus? status, List<Datum>? listSurah, List<Ayat>? listSurahDetail}) {
    return QuranState(
        status: status ?? this.status,
        listSurah: listSurah ?? this.listSurah,
      );
  }

  @override
  List<Object?> get props => <Object?>[status, listSurah];
}
