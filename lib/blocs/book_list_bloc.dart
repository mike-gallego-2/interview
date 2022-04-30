import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:interview/models/book.dart';

part 'book_list_event.dart';
part 'book_list_state.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  BookListBloc() : super(BookListState(books: [])) {
    on<BookListLoadEvent>((event, emit) {});
    on<BookListAddEvent>((event, emit) {});
    on<BookListDeleteEvent>((event, emit) {});
    on<BookListUpdateEvent>((event, emit) {});
    on<BookListSaveEvent>((event, emit) {});
  }
}
