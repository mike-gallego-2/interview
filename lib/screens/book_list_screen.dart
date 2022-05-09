import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/blocs/book_list_bloc.dart';
import 'package:interview/screens/book_detail_screen.dart';
import 'package:interview/utilities/localize.dart';
import 'package:interview/widgets/widgets.dart';
import 'package:lottie/lottie.dart';

class BookListScreen extends StatelessWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(localize(context).appBarTitle)),
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
          switch (state.status) {
            case BookStatus.loaded:
              return ListView(
                children: state.books.map((book) => BookTile(book: book)).toList(),
              );
            case BookStatus.initial:
            case BookStatus.loading:
              return Center(child: Lottie.asset('assets/book_loading.json'));
            case BookStatus.error:
              return const Center(
                child: Icon(Icons.error),
              );
          }
        },
      ),
    );
  }
}
