// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:interview/models/book.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

void main() async {
  sqfliteTestInit();
  var db = await openDatabase(inMemoryDatabasePath);

  test('check if db exists', () {
    expect(db, isNotNull);
  });

  test('create from Book class', () async {
    await db.execute('''
      CREATE TABLE book (
        ID INTEGER,
        Title TEXT,
        Author TEXT,
        CoverImage TEXT
      )
    ''');

    await db.insert('book',
        Book.fromMap({'ID': 1, 'Title': 'Harry Potter', 'Author': 'J.K. Rowling', 'CoverImage': 'Image'}).toMap());

    var result = await db.rawQuery('SELECT * FROM book');
    expect(result.length, 1);
  });

  test('update from Book class', () async {
    await db.update(
        'book',
        Book.fromMap({
          'ID': 1,
          'Title': 'Harry Potter and the Goblet of Fire',
          'Author': 'J.K. Rowling',
          'CoverImage': 'Image'
        }).toMap(),
        where: 'ID = ?',
        whereArgs: [1]);

    var result = await db.rawQuery('SELECT * FROM book');
    expect(result[0]['Title'], 'Harry Potter and the Goblet of Fire');
  });

  test('delete from Book class', () async {
    await db.delete('book', where: 'ID = ?', whereArgs: [1]);

    var result = await db.rawQuery('SELECT * FROM book');
    expect(result.length, 0);
  });
}