part of 'book_list_bloc.dart';

abstract class BookListEvent {
  const BookListEvent();
}

class BookListLoadEvent extends BookListEvent {
  @override
  String toString() {
    return 'Loaded';
  }
}

class BookListResetEvent extends BookListEvent {
  @override
  String toString() {
    return 'Resetted';
  }
}

class BookListAddEvent extends BookListEvent {
  final Book book;
  BookListAddEvent({required this.book});

  @override
  String toString() {
    return 'Added $book';
  }
}

class BookListUpdateEvent extends BookListEvent {
  final Book book;
  final String titleText;
  final String authorText;
  BookListUpdateEvent({required this.book, required this.titleText, required this.authorText});

  @override
  String toString() {
    Book newBook = book.copyWith(title: titleText, author: authorText);
    return 'Updated $book with these values: title: $titleText, author: $authorText\nNew book: $newBook';
  }
}

class BookListDeleteEvent extends BookListEvent {
  final int id;
  BookListDeleteEvent({required this.id});

  @override
  String toString() {
    return 'Deleted book id: $id';
  }
}

class BookListUpdateTitleEvent extends BookListEvent {
  final String title;
  BookListUpdateTitleEvent({required this.title});
  @override
  String toString() {
    return 'The current title text is $title';
  }
}

class BookListUpdateAuthorEvent extends BookListEvent {
  final String author;
  BookListUpdateAuthorEvent({required this.author});
  @override
  String toString() {
    return 'The current author text is $author';
  }
}

class BookListInitializeTextFieldsEvent extends BookListEvent {
  final String titleText;
  final String authorText;
  BookListInitializeTextFieldsEvent({required this.titleText, required this.authorText});
}
