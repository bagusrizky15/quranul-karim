import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:quran_alkarim/core/config/config.dart';
import 'package:quran_alkarim/data/model/surah_detail.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailState.init()) {
    on<FetchSurahDetail>(onInitialized);
  }

  Future<void> onInitialized(FetchSurahDetail event, Emitter<DetailState> emit) async {
    emit(DetailState.init());
    emit(state.copyWith(status: DetailStatus.loading));
    String? surahPath = detailSurah[event.noSurat];

    if (surahPath == null) {
      emit(state.copyWith(status: DetailStatus.failure));
      return;
    }

    emit(state.copyWith(status: DetailStatus.loading));
    try {
      var data = await rootBundle.loadString(surahPath);
      final surahDetail = SurahDetail.fromJson(json.decode(data));
      emit(state.copyWith(status: DetailStatus.success, listSurahDetail: surahDetail.data.ayat));
      print(surahDetail.data.ayat);
    } catch (e) {
      emit(state.copyWith(status: DetailStatus.failure));
      print(e);
    }
  }
}
