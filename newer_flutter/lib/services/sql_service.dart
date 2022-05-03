import 'dart:async';

import 'package:interview/models/book.dart';
import 'package:sqlbrite/sqlbrite.dart';

class SQLService {
  late final BriteDatabase db;

  SQLService({required this.db});

  Future<Stream<List<Book>>> getBooks() async {
    StreamController<List<Book>> controller = StreamController<List<Book>>();

    db.createQuery('book').mapToList((row) => Book.fromMap(row)).listen((event) {
      controller.add(event);
    });

    controller.onCancel = () async {
      await db.close();
      await controller.close();
    };

    return controller.stream;
  }

  Future<void> addBook({required Book book}) async {
    db.insert('book', book.toMap());
  }

  Future<void> deleteBook({required int id}) async {
    db.delete('book', where: 'ID = ?', whereArgs: [id]);
  }

  Future<void> updateBook({required Book book, required String title, required String author}) async {
    db.update('book', {'Title': title, 'Author': author}, where: 'ID = ?', whereArgs: [book.id]);
  }
}
