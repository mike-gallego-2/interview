import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:interview/exceptions/sql_exception.dart';
import 'package:interview/models/book.dart';
import 'package:sqlbrite/sqlbrite.dart';

class SQLService {
  final BriteDatabase db;

  SQLService({required this.db});

  Either<SQLException, Stream<List<Book>>> getBooks() {
    StreamController<List<Book>> controller = StreamController<List<Book>>();

    db.createQuery('book').mapToList((row) => Book.fromMap(row)).listen((event) {
      controller.add(event);
    }, onError: (error, stackTrace) {
      return Left(SQLException(error.toString()));
    });

    controller.onCancel = () async {
      await db.close();
      controller.close();
    };

    return Right(controller.stream);
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
