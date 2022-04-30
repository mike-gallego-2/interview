part of 'book_list_bloc.dart';

class BookListState extends Equatable {
  final List<Book> books;
  const BookListState({required this.books});

  @override
  List<Object> get props => [books];

  BookListState copyWith({List<Book>? books}) {
    return BookListState(books: books ?? this.books);
  }
}
