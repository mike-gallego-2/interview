import 'dart:async';

import 'package:interview/models/book.dart';
import 'package:sqflite/sqflite.dart';

class SQLService {
  late final Database db;

  SQLService({required this.db});

  Future<Stream<List<Book>>> getBooks() async {
    StreamController<List<Book>> controller = StreamController<List<Book>>();
    db.rawQuery("SELECT * FROM book").then((value) {
      controller.add(value.map((e) => Book.fromMap(e)).toList());
    });

    controller.onCancel = () async {
      await db.close();
      await controller.close();
    };

    return controller.stream;
  }

  Future<void> addBook({required Book book}) async {
    db.transaction((txn) async {
      txn.rawInsert("INSERT INTO book VALUES ('${book.id}', '${book.title}', '${book.author}', '${book.coverImage}')");
    });
  }

  Future<void> deleteBook({required int id}) async {
    db.transaction((txn) async {
      txn.rawDelete("DELETE FROM book WHERE id = $id");
    });
  }

  Future<void> updateBook({required Book book, required String title, required String author}) async {
    db.transaction((txn) async {
      await txn.rawUpdate("UPDATE book SET title = '$title', author = '$author' WHERE ID = ${book.id}");
    });
  }
}
