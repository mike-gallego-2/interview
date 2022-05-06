import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/blocs/book_list_bloc.dart';
import 'package:interview/models/book.dart';

class AddBookScreen extends StatefulWidget {
  final bool canDelete;
  final Book? book;
  final bool isUpdating;
  const AddBookScreen({Key? key, required this.canDelete, this.book, required this.isUpdating}) : super(key: key);

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
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Books'),
          actions: [
            widget.canDelete
                ? IconButton(
                    onPressed: () {
                      BlocProvider.of<BookListBloc>(context).add(BookListDeleteEvent(id: widget.book!.id));
                    },
                    icon: const Icon(Icons.delete_outline))
                : const SizedBox()
          ],
        ),
        body: BlocConsumer<BookListBloc, BookListState>(
          listener: (context, state) {
            if (state.editStatus == EditStatus.added || state.editStatus == EditStatus.updated) {
              Navigator.maybePop(context);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Enter the title of the book',
                      focusColor: Colors.blue,
                      labelText: 'Title',
                      labelStyle: TextStyle(fontSize: 12),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                    onChanged: (value) {
                      BlocProvider.of<BookListBloc>(context).add(BookListUpdateTitleEvent(title: value));
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _authorController,
                    decoration: const InputDecoration(
                      hintText: 'Enter author name',
                      labelText: 'Author',
                      focusColor: Colors.blue,
                      labelStyle: TextStyle(fontSize: 12),
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                    ),
                    onChanged: (value) {
                      BlocProvider.of<BookListBloc>(context).add(BookListUpdateAuthorEvent(author: value));
                    },
                  ),
                ),
                if (widget.book != null) ...[
                  if (widget.book!.coverImage != 'null') ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(widget.book!.coverImage, height: 100, width: 100, fit: BoxFit.cover,
                          errorBuilder: (context, _, __) {
                        return const Icon(Icons.error);
                      }),
                    ),
                  ] else ...[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('No cover image'),
                    ),
                  ],
                ] else ...[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('No cover image'),
                  ),
                ],
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      if (widget.isUpdating) {
                        BlocProvider.of<BookListBloc>(context).add(BookListUpdateEvent(
                            book: widget.book!, titleText: _titleController.text, authorText: _authorController.text));
                      } else {
                        BlocProvider.of<BookListBloc>(context).add(BookListAddEvent(
                            book: Book(
                                id: (state.books.length + 1),
                                title: state.titleText,
                                author: state.authorText,
                                coverImage: 'null')));
                      }
                      _titleController.clear();
                      _authorController.clear();
                    },
                    child: Container(
                      color: Colors.blue,
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          widget.isUpdating ? 'Update' : 'Save',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
