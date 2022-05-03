part of 'book_list_bloc.dart';

abstract class BookListEvent {
  const BookListEvent();
}

class BookListLoadEvent extends BookListEvent {}

class BookListAddEvent extends BookListEvent {
  final Book book;
  BookListAddEvent({required this.book});
}

class BookListUpdateEvent extends BookListEvent {
  final Book book;
  final String titleText;
  final String authorText;
  BookListUpdateEvent({required this.book, required this.titleText, required this.authorText});
}

class BookListDeleteEvent extends BookListEvent {
  final int id;
  BookListDeleteEvent({required this.id});
}

class BookListUpdateTitleEvent extends BookListEvent {
  final String title;
  BookListUpdateTitleEvent({required this.title});
}

class BookListUpdateAuthorEvent extends BookListEvent {
  final String author;
  BookListUpdateAuthorEvent({required this.author});
}
