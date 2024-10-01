part of 'home_screen_bloc.dart';

abstract class HomeScreenEvent extends Equatable {}

class HomeScreenInitialized extends HomeScreenEvent {

  @override
  List<Object> get props => [];
}

class HomeScreenFetchData extends HomeScreenEvent {

  @override
  List<Object> get props => [];
}

class HomeScreenClickedSurah extends HomeScreenEvent {
  final int noSurat;

  HomeScreenClickedSurah({required this.noSurat});

  @override
  List<Object> get props => [noSurat];
}

