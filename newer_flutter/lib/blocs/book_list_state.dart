part of 'book_list_bloc.dart';

class BookListState extends Equatable {
  final List<Book> books;
  final BookStatus status;
  final String titleText;
  final String authorText;
  const BookListState({required this.books, required this.status, required this.titleText, required this.authorText});

  @override
  List<Object> get props => [books, status, titleText, authorText];

  BookListState copyWith({
    List<Book>? books,
    BookStatus? status,
    String? titleText,
    String? authorText,
  }) {
    return BookListState(
      books: books ?? this.books,
      status: status ?? this.status,
      titleText: titleText ?? this.titleText,
      authorText: authorText ?? this.authorText,
    );
  }
}

enum BookStatus {
  initial,
  loading,
  loaded,
  error,
}
