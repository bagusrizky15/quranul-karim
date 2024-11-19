part of 'quran_bloc.dart';

abstract class QuranEvent extends Equatable {}

class QuranInitialized extends QuranEvent {

  @override
  List<Object> get props => [];
}

class QuranFetchData extends QuranEvent {

  @override
  List<Object> get props => [];
}
