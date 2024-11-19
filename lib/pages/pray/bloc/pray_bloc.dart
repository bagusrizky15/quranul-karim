import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pray_event.dart';
part 'pray_state.dart';

class PrayBloc extends Bloc<PrayEvent, PrayState> {
  PrayBloc() : super(PrayInitial()) {
    on<PrayEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
