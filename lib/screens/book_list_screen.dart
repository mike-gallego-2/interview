import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/blocs/book_list_bloc.dart';
import 'package:interview/screens/add_book_screen.dart';
import 'package:interview/widgets/book_tile.dart';
import 'package:lottie/lottie.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Books')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddBookScreen(
                isUpdating: false,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<BookListBloc, BookListState>(
        builder: (context, state) {
          if (state.status == BookStatus.loaded) {
            return ListView(
              children: state.books.map((book) => BookTile(book: book)).toList(),
            );
          } else {
            return Center(child: Lottie.asset('assets/book_loading.json'));
          }
        },
      ),
    );
  }
}
