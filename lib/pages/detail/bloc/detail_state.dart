part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class DetailInitial extends DetailState {}

class DetailLoading extends DetailState {}

class DetailLoaded extends DetailState {
  final SurahDetail surahDetail;
  DetailLoaded({required this.surahDetail});

  @override 
  List<Object> get props => [surahDetail];
}

class DetailError extends DetailState {
  final String message;
  DetailError({required this.message});
}