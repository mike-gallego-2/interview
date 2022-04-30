import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/blocs/book_list_bloc.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookListBloc()..add(BookListLoadEvent()),
      child: BlocConsumer<BookListBloc, BookListState>(
        listener: (context, state) => print('BookListScreen: $state'),
        builder: (context, state) {
          final bookListBloc = context.read<BookListBloc>();
          return Scaffold(
            appBar: AppBar(title: Text('Books')),
            floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
          );
        },
      ),
    );
  }
}
