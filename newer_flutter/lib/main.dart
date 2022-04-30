import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/repositories/book_repository.dart';
import 'package:interview/screens/book_list_screen.dart';
import 'package:interview/services/sql_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, 'book.db');
  var exists = await databaseExists(path);

  if (!exists) {
    debugPrint('does not exist');
  } else {
    debugPrint('exists');
  }

  if (!exists) {
    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", "book.db"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Write and flush the bytes written
    await File(path).writeAsBytes(bytes, flush: true);
  } else {
    print("Opening existing database");
  }
// open the database
  Database db = await openDatabase(path);

  runApp(MyApp(
    db: db,
  ));
}

class MyApp extends StatelessWidget {
  final Database db;
  MyApp({required this.db});
  @override
  Widget build(BuildContext context) {
    // services
    final _sqlService = SQLService(db: db);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<BookRepository>(
          create: (context) => BookRepository(sqlService: _sqlService),
        ),
      ],
      child: MaterialApp(
        title: 'Book demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: BookListScreen(),
      ),
    );
  }
}
