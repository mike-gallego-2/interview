part of 'book_list_bloc.dart';

abstract class BookListEvent {
  const BookListEvent();
}

class BookListLoadEvent extends BookListEvent {}

class BookListAddEvent extends BookListEvent {
  final Book book;
  BookListAddEvent({required this.book});
}

class BookListDeleteEvent extends BookListEvent {
  final int id;
  BookListDeleteEvent({required this.id});
}

class BookListSaveEvent extends BookListEvent {}

class BookListUpdateTitleEvent extends BookListEvent {
  final String title;
  BookListUpdateTitleEvent({required this.title});
}

class BookListUpdateAuthorEvent extends BookListEvent {
  final String author;
  BookListUpdateAuthorEvent({required this.author});
}
