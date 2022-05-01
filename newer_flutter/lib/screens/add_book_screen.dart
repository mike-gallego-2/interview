import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/blocs/book_list_bloc.dart';
import 'package:interview/models/book.dart';

class AddBookScreen extends StatefulWidget {
  final bool canDelete;
  final Book? book;
  AddBookScreen({Key? key, required this.canDelete, this.book}) : super(key: key);

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _authorController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book?.title ?? '');
    _authorController = TextEditingController(text: widget.book?.author ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<BookListBloc, BookListState>(
        builder: (context, state) {
          final _bookListBloc = context.read<BookListBloc>();
          return Scaffold(
            appBar: AppBar(
              title: Text('Books'),
              actions: [
                widget.canDelete
                    ? IconButton(
                        onPressed: () {
                          _bookListBloc.add(BookListDeleteEvent(id: widget.book!.id));
                        },
                        icon: Icon(Icons.delete_outline))
                    : SizedBox()
              ],
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: 'Enter the title of the book',
                      focusColor: Colors.blue,
                      labelText: 'Title',
                      labelStyle: TextStyle(fontSize: 12),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                    onChanged: (value) {
                      _bookListBloc.add(BookListUpdateTitleEvent(title: value));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _authorController,
                    decoration: InputDecoration(
                      hintText: 'Enter author name',
                      labelText: 'Author',
                      focusColor: Colors.blue,
                      labelStyle: TextStyle(fontSize: 12),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                    onChanged: (value) {
                      _bookListBloc.add(BookListUpdateAuthorEvent(author: value));
                    },
                  ),
                ),
                if (widget.book != null) ...[
                  if (widget.book!.coverImage != 'null') ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(widget.book!.coverImage, height: 100, width: 100, fit: BoxFit.cover,
                          errorBuilder: (context, _, __) {
                        return Icon(Icons.error);
                      }),
                    ),
                  ] else ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('No cover image'),
                    ),
                  ],
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('No cover image'),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      _bookListBloc.add(BookListAddEvent(
                          book: Book(
                              id: (state.books.length + 1),
                              title: state.titleText,
                              author: state.authorText,
                              coverImage: 'null')));
                      // reload
                      _bookListBloc.add(BookListLoadEvent());
                      _titleController.clear();
                      _authorController.clear();
                      Navigator.pop(context);
                    },
                    child: Container(
                      color: Colors.blue,
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
