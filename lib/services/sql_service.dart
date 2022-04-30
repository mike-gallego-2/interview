import 'dart:async';
import 'dart:io';

import 'package:interview/models/book.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SQLService {
  late Database db;

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "book.db");

    db = await openDatabase(path);
  }

  Stream<List<Book>> getBooks() {
    StreamController<List<Book>> controller = StreamController<List<Book>>();
    db.rawQuery('SELECT * FROM book').then((value) {
      controller.add(value.map((e) => Book.fromMap(e)).toList());
    });

    controller.onCancel = () async {
      await db.close();
      controller.close();
    };

    return controller.stream;
  }

  Future<void> addBook({required Book book}) async {
    db.transaction((txn) async {
      txn.rawInsert('INSERT INTO book VALUES (${book.title}, ${book.author}, ${book.coverImage};)');
    });
  }
}
