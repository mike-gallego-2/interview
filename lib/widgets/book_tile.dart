import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:interview/models/book.dart';
import 'package:interview/screens/add_book_screen.dart';

class BookTile extends StatelessWidget {
  final Book book;
  const BookTile({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddBookScreen(
              isUpdating: true,
              book: book,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 250,
        child: Column(
          children: [
            if (book.coverImage != 'null') ...[
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: book.coverImage,
                  fit: BoxFit.cover,
                  width: 100,
                  errorWidget: (_, __, ___) {
                    return Container(
                      color: Colors.grey,
                      width: 100,
                    );
                  },
                ),
              ),
            ] else ...[
              Container(
                color: Colors.grey,
                width: 100,
                height: 150,
              ),
            ],
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                book.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                book.author,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
