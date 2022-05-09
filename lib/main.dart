import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/blocs/book_list_bloc.dart';
import 'package:interview/observers/book_observer.dart';
import 'package:interview/repositories/book_repository.dart';
import 'package:interview/screens/book_list_screen.dart';
import 'package:interview/services/sql_service.dart';
import 'package:interview/utilities/initializer.dart';
import 'package:interview/utilities/localize.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var briteDatabase = await initDb();
  BlocOverrides.runZoned(
    () => runApp(BookDemo(
      briteDatabase: briteDatabase,
    )),
    blocObserver: BookBlocObserver(),
  );
}

class BookDemo extends StatelessWidget {
  final BriteDatabase briteDatabase;
  const BookDemo({Key? key, required this.briteDatabase}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // services
    final _sqlService = SQLService(db: briteDatabase);

    return RepositoryProvider(
      create: (context) => BookRepository(sqlService: _sqlService),
      child: BlocProvider(
        create: (context) => BookListBloc(bookRepository: context.read<BookRepository>())..add(BookListLoadEvent()),
        child: MaterialApp(
          onGenerateTitle: (context) => localize(context).appName,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: const BookListScreen(),
        ),
      ),
    );
  }
}
