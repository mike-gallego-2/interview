import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/screens/book_list_screen.dart';
import 'package:interview/services/sql_service.dart';

import 'repositories/book_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // services
    final _sqlService = SQLService();

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
