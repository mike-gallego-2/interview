import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/blocs/book_list_bloc.dart';
import 'package:interview/repositories/book_repository.dart';
import 'package:interview/screens/add_book_screen.dart';
import 'package:interview/widgets/book_tile.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _bookRepository = context.read<BookRepository>();
    return BlocProvider(
      create: (context) => BookListBloc(bookRepository: _bookRepository)..add(BookListLoadEvent()),
      child: Scaffold(
        appBar: AppBar(title: Text('Books')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddBookScreen()));
          },
          child: Icon(Icons.add),
        ),
        body: BlocConsumer<BookListBloc, BookListState>(
          listener: (context, state) => print('BookListScreen: $state'),
          builder: (context, state) {
            final bookListBloc = context.read<BookListBloc>();
            if (state.status == BookStatus.loaded) {
              debugPrint(state.books.toString());
              return ListView(
                children: state.books.map((book) => BookTile(book: book)).toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
