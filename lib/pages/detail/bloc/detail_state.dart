part of 'detail_bloc.dart';

enum DetailStatus { init, loading, success, failure }

class DetailState extends Equatable {
  DetailState({
    required this.status,
    required this.listSurahDetail
  });

  final DetailStatus status;
  late final List<Ayat> listSurahDetail;

  DetailState.init() : status = DetailStatus.init,
  listSurahDetail = <Ayat>[];

  DetailState copyWith({
    DetailStatus? status,
    List<Ayat>? listSurahDetail
  }) {
    return DetailState(
      status: status ?? this.status,
      listSurahDetail: listSurahDetail ?? this.listSurahDetail
    );
  }
  
  @override
  List<Object?> get props => <Object>[
    status
  ];

}