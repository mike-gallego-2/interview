part of 'book_list_bloc.dart';

class BookListState extends Equatable {
  final List<Book> books;
  final BookStatus status;
  const BookListState({required this.books, required this.status});

  @override
  List<Object> get props => [books, status];

  BookListState copyWith({List<Book>? books, BookStatus? status}) {
    return BookListState(books: books ?? this.books, status: status ?? this.status);
  }
}

enum BookStatus {
  initial,
  loading,
  loaded,
  error,
}
