part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class FetchSurahDetail extends DetailEvent {
  final int nomorSurah;

  FetchSurahDetail({required this.nomorSurah});

  @override
  List<Object> get props => [nomorSurah];
}
