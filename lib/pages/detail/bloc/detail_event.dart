part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class FetchSurahDetail extends DetailEvent {
  final int noSurat;

  FetchSurahDetail({required this.noSurat});

  @override
  List<Object> get props => [noSurat];
}
