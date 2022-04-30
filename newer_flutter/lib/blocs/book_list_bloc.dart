import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:interview/models/book.dart';
import 'package:interview/repositories/book_repository.dart';

part 'book_list_event.dart';
part 'book_list_state.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  BookRepository bookRepository;
  BookListBloc({required this.bookRepository}) : super(BookListState(books: [], status: BookStatus.initial)) {
    on<BookListLoadEvent>((event, emit) async {
      emit(state.copyWith(status: BookStatus.loading));
      final bookStream = await bookRepository.getBooks();
      await emit.forEach<List<Book>>(bookStream, onData: (data) {
        return state.copyWith(books: data, status: BookStatus.loaded);
      }, onError: (_, __) {
        return state.copyWith(status: BookStatus.error);
      });
    });
    on<BookListAddEvent>((event, emit) {});
    on<BookListDeleteEvent>((event, emit) {});
    on<BookListUpdateEvent>((event, emit) {});
    on<BookListSaveEvent>((event, emit) {});
  }
}