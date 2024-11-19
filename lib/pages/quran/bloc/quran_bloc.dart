import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:quran_alkarim/core/config/config.dart';
import 'package:quran_alkarim/data/model/surah.dart';
import 'package:quran_alkarim/data/model/surah_detail.dart';

part 'quran_event.dart';
part 'quran_state.dart';

class QuranBloc extends Bloc<QuranEvent, QuranState> {
  QuranBloc() : super(QuranState.init()) {
    on<QuranInitialized>(onInitialized);
    on<QuranFetchData>(onFetchData);
  }

  Future<void> onInitialized(QuranInitialized event, Emitter<QuranState> emit) async {
    emit(QuranState.init());
    add(QuranFetchData());
  }

  Future<void> onFetchData(QuranFetchData event, Emitter<QuranState> emit) async {
    emit(state.copyWith(status: QuranStatus.loading));
    try {
      var data = await rootBundle.loadString(ApiConfig.listSurah);
      final surah = Surah.fromJson(json.decode(data));
      emit(state.copyWith(status: QuranStatus.success, listSurah: surah.data));
    } catch (e) {
      emit(state.copyWith(status: QuranStatus.failure));
      print(e);
    }
  }
}