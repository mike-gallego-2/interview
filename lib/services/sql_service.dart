import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:interview/exceptions/sql_exception.dart';
import 'package:interview/models/book.dart';
import 'package:sqlbrite/sqlbrite.dart';

class SQLService {
  final BriteDatabase db;

  SQLService({required this.db});

  Either<SQLException, Stream<List<Book>>> getBooks() {
    var query = db.createQuery('book').mapToList((row) => Book.fromMap(row)).asBroadcastStream().handleError((error) {
      return Left(SQLException(error.toString()));
    });

    return Right(query);
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
