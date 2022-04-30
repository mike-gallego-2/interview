import 'package:flutter/material.dart';
import 'package:interview/models/book.dart';

class BookTile extends StatelessWidget {
  final Book book;
  const BookTile({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Column(
        children: [
          Expanded(
            child: book.coverImage != null
                ? Container(
                    color: Colors.grey,
                  )
                : Image.network(
                    book.coverImage!,
                    fit: BoxFit.cover,
                  ),
          ),
          Text(book.title),
          Text(book.author),
        ],
      ),
    );
  }
}
