import 'package:bloc/bloc.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<StartSplash>(_startSplash);
  }

  Future<void> _startSplash(StartSplash event, Emitter<SplashState> emit) async {
    await Future.delayed(Duration(seconds: 2));
    emit(SplashCompleted());
  }
}

