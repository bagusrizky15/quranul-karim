import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:quran_alkarim/core/config/config.dart';
import 'package:quran_alkarim/data/model/surah.dart';
import 'package:quran_alkarim/data/model/surah_detail.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  HomeScreenBloc() : super(HomeScreenState.init()) {
    on<HomeScreenInitialized>(onInitialized);
    on<HomeScreenFetchData>(onFetchData);
  }

  Future<void> onInitialized(HomeScreenInitialized event, Emitter<HomeScreenState> emit) async {
    emit(HomeScreenState.init());
    add(HomeScreenFetchData());
  }

  Future<void> onFetchData(HomeScreenFetchData event, Emitter<HomeScreenState> emit) async {
    emit(state.copyWith(status: HomeScreenStatus.loading));
    try {
      var data = await rootBundle.loadString(ApiConfig.listSurah);
      final surah = Surah.fromJson(json.decode(data));
      emit(state.copyWith(status: HomeScreenStatus.success, listSurah: surah.data));
    } catch (e) {
      emit(state.copyWith(status: HomeScreenStatus.failure));
      print(e);
    }
  }
}
