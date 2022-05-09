import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:interview/blocs/book_list_bloc.dart';
import 'package:interview/models/book.dart';
import 'package:interview/utilities/localize.dart';
import 'package:interview/widgets/book_image.dart';
import 'package:interview/widgets/book_textfield.dart';

class AddBookScreen extends StatefulWidget {
  final Book? book;
  final bool isUpdating;
  const AddBookScreen({Key? key, this.book, required this.isUpdating}) : super(key: key);

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    context
        .read<BookListBloc>()
        .add(BookListInitializeTextFieldsEvent(titleText: _titleController.text, authorText: _authorController.text));
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
            title: Text(localize(context).appBarTitle),
            actions: [
              widget.isUpdating
                  ? IconButton(
                      onPressed: () {
                        context.read<BookListBloc>().add(BookListDeleteEvent(id: widget.book!.id));
                      },
                      icon: const Icon(Icons.delete_outline))
                  : const SizedBox()
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookTextField(
                label: localize(context).title,
                hint: localize(context).titleHint,
                controller: _titleController,
                onChanged: (value) => context.read<BookListBloc>().add(BookListUpdateTitleEvent(title: value)),
              ),
              BookTextField(
                label: localize(context).author,
                hint: localize(context).authorHint,
                controller: _authorController,
                onChanged: (value) => context.read<BookListBloc>().add(BookListUpdateAuthorEvent(author: value)),
              ),
              if (widget.book != null) ...[
                if (widget.book!.coverImage != 'null') ...[
                  BookImage(imageUrl: widget.book!.coverImage)
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(localize(context).noCoverImage),
                  ),
                ],
              ] else ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(localize(context).noCoverImage),
                ),
              ],
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: BlocConsumer<BookListBloc, BookListState>(
                  listener: (context, state) async {
                    if (state.editStatus == EditStatus.added || state.editStatus == EditStatus.updated) {
                      await Navigator.maybePop(context);
                      context.read<BookListBloc>().add(BookListResetEvent());
                    }
                  },
                  builder: (context, state) {
                    return GestureDetector(
                      onTap: () {
                        if (widget.isUpdating) {
                          context.read<BookListBloc>().add(BookListUpdateEvent(
                              book: widget.book!, titleText: state.titleText, authorText: state.authorText));
                        } else {
                          context.read<BookListBloc>().add(
                                BookListAddEvent(
                                  book: Book(
                                    id: (state.books.length + 1),
                                    title: state.titleText,
                                    author: state.authorText,
                                    coverImage: 'null',
                                  ),
                                ),
                              );
                        }
                        _titleController.clear();
                        _authorController.clear();
                      },
                      child: Container(
                        color: Colors.blue,
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            widget.isUpdating ? localize(context).update : localize(context).save,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
