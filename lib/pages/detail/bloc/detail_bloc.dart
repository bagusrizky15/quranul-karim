import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:quran_alkarim/core/config/config.dart';
import 'package:quran_alkarim/data/model/surah_detail.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailInitial()) {
    on<FetchSurahDetail>(onInitialized);
  }

  Future<void> onInitialized(FetchSurahDetail event, Emitter<DetailState> emit) async {
    emit(DetailInitial());
    emit(DetailLoading());

    String? surahPath = listNomorSurah[event.nomorSurah];

    if (surahPath == null) {
      emit(DetailError("Surah not found"));
      return;
    }

    try {
      var data = await rootBundle.loadString(surahPath);
      final surahDetail = SurahDetail.fromJson(json.decode(data));
      emit(DetailLoaded(surahDetail));
    } catch (e) {
      emit(DetailError(e.toString()));
      print("LOGGER ERROR : $e");
    }
  }
}
