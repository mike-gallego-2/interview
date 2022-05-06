import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:interview/models/book.dart';
import 'package:interview/repositories/book_repository.dart';

part 'book_list_event.dart';
part 'book_list_state.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  BookRepository bookRepository;
  BookListBloc({required this.bookRepository})
      : super(const BookListState(
            books: [], status: BookStatus.initial, editStatus: EditStatus.waiting, titleText: '', authorText: '')) {
    on<BookListLoadEvent>((event, emit) async {
      emit(state.copyWith(status: BookStatus.loading));
      final bookStream = bookRepository.getBooks();
      if (bookStream.isLeft) {
        await emit.forEach<List<Book>>(bookStream.left, onData: (data) {
          return state.copyWith(books: data, status: BookStatus.loaded);
        }, onError: (_, __) {
          return state.copyWith(status: BookStatus.error);
        });
      }
    });

    on<BookListAddEvent>((event, emit) async {
      await bookRepository.addBook(book: event.book);
      emit(state.copyWith(titleText: '', authorText: '', editStatus: EditStatus.added));
    });

    on<BookListUpdateEvent>((event, emit) async {
      await bookRepository.updateBook(book: event.book, title: event.titleText, author: event.authorText);
      emit(state.copyWith(titleText: '', authorText: '', editStatus: EditStatus.updated));
    });

    on<BookListDeleteEvent>((event, emit) async {
      await bookRepository.deleteBook(id: event.id);
      emit(state.copyWith(titleText: '', authorText: '', editStatus: EditStatus.updated));
    });

    on<BookListUpdateTitleEvent>((event, emit) {
      emit(state.copyWith(titleText: event.title));
    });

    on<BookListUpdateAuthorEvent>((event, emit) {
      emit(state.copyWith(authorText: event.author));
    });

    on<BookListResetEvent>((event, emit) {
      emit(state.copyWith(editStatus: EditStatus.waiting));
    });
  }
}
