part of 'book_list_bloc.dart';

abstract class BookListEvent {
  const BookListEvent();
}

class BookListLoadEvent extends BookListEvent {}

class BookListAddEvent extends BookListEvent {}

class BookListDeleteEvent extends BookListEvent {}

class BookListSaveEvent extends BookListEvent {}

class BookListUpdateEvent extends BookListEvent {}
