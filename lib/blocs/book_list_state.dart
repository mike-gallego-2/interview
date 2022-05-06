part of 'book_list_bloc.dart';

class BookListState extends Equatable {
  final List<Book> books;
  final BookStatus status;
  final EditStatus editStatus;
  final String titleText;
  final String authorText;
  const BookListState({
    required this.books,
    required this.status,
    required this.editStatus,
    required this.titleText,
    required this.authorText,
  });

  @override
  List<Object> get props => [books, status, editStatus, titleText, authorText];

  BookListState copyWith({
    List<Book>? books,
    BookStatus? status,
    EditStatus? editStatus,
    String? titleText,
    String? authorText,
  }) {
    return BookListState(
      books: books ?? this.books,
      status: status ?? this.status,
      editStatus: editStatus ?? this.editStatus,
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

enum EditStatus {
  waiting,
  added,
  updated,
}
