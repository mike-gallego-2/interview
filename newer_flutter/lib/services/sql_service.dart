import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:interview/models/book.dart';
import 'package:sqflite/sqflite.dart';

class SQLService {
  late final Database db;

  SQLService({required this.db});

  Future<Stream<List<Book>>> getBooks() async {
    debugPrint(db.path);
    StreamController<List<Book>> controller = StreamController<List<Book>>();
    await db.rawQuery("SELECT * FROM book WHERE title IS NOT NULL").then((value) {
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
      txn.rawInsert('INSERT INTO book VALUES (${book.title}, ${book.author}, ${book.coverImage};)');
    });
  }
}
