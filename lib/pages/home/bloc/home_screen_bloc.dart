import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
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
    on<HomeScreenClickedSurah>(onSurahClicked);
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

  Future<void> onSurahClicked(HomeScreenClickedSurah event, Emitter<HomeScreenState> emit) async { 
    emit(state.copyWith(status: HomeScreenStatus.loading));
    try {
      var data = await Dio().get(ApiConfig.baseUrl + "surat/${event.noSurat}");
      final surahDetail = SurahDetail.fromJson(json.decode(data.toString()));
      emit(state.copyWith(status: HomeScreenStatus.success, listSurahDetail: surahDetail.data.ayat));
      print(surahDetail.data.ayat[1].teksIndonesia);
    } catch (e) {
      emit(state.copyWith(status: HomeScreenStatus.failure));
      print(e);
    }
  }

}
