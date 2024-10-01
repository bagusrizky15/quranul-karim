import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:quran_alkarim/data/model/surah_detail.dart';

part 'detail_event.dart';
part 'detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(DetailInitial());

  @override
  Stream<DetailState> mapEventToState(DetailEvent event) async* {
    if (event is FetchSurahDetail) {
      yield DetailLoading();

      try {
        // Call Dio to fetch surah details
        var response = await Dio().get("https://equran.id/api/v2/surat/${event.noSurat}");
        SurahDetail surahDetail = SurahDetail.fromJson(json.decode(response.toString()));
        print(surahDetail.data);
        // yield DetailLoaded(surahDetail);
      } catch (e) {
        // yield DetailError("Failed to fetch surah details");
      }
    }
  }
}
