import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  BookmarkBloc() : super(BookmarkInitial()) {
    on<BookmarkEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
