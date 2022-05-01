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
              canDelete: true,
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
            Expanded(
              child: book.coverImage != null
                  ? Image.network(
                      book.coverImage!,
                      fit: BoxFit.cover,
                      width: 100,
                      errorBuilder: (_, __, ___) {
                        return Container(
                          color: Colors.grey,
                          width: 100,
                        );
                      },
                    )
                  : Container(
                      color: Colors.grey,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                book.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                book.author,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
