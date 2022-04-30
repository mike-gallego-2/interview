import 'package:flutter/material.dart';
import 'package:interview/models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;
  const BookTile({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: 250,
      child: Column(
        children: [
          Expanded(
            child: book.coverImage != null
                ? Image.network(
                    book.coverImage!,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: Colors.grey,
                  ),
          ),
          Text(book.title),
          Text(book.author),
        ],
      ),
    );
  }
}
