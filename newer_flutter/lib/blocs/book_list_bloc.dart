import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:interview/models/book.dart';
import 'package:interview/repositories/book_repository.dart';

part 'book_list_event.dart';
part 'book_list_state.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  BookRepository bookRepository;
  BookListBloc({required this.bookRepository})
      : super(BookListState(books: [], status: BookStatus.initial, titleText: '', authorText: '')) {
    on<BookListLoadEvent>((event, emit) async {
      emit(state.copyWith(status: BookStatus.loading));
      final bookStream = await bookRepository.getBooks();
      await emit.forEach<List<Book>>(bookStream, onData: (data) {
        return state.copyWith(books: data, status: BookStatus.loaded);
      }, onError: (_, __) {
        return state.copyWith(status: BookStatus.error);
      });
    });

    on<BookListAddEvent>((event, emit) {
      bookRepository.addBook(book: event.book);
      emit(state.copyWith(titleText: '', authorText: ''));
    });

    on<BookListUpdateEvent>((event, emit) {
      bookRepository.updateBook(book: event.book, title: event.titleText, author: event.authorText);
      emit(state.copyWith(titleText: '', authorText: ''));
    });

    on<BookListDeleteEvent>((event, emit) {
      bookRepository.deleteBook(id: event.id);
    });

    on<BookListUpdateTitleEvent>((event, emit) {
      emit(state.copyWith(titleText: event.title));
    });

    on<BookListUpdateAuthorEvent>((event, emit) {
      emit(state.copyWith(authorText: event.author));
    });
  }
}
