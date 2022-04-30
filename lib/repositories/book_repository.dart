import 'package:interview/models/book.dart';
import 'package:interview/services/sql_service.dart';

class BookRepository {
  late SQLService sqlService;

  BookRepository({required this.sqlService});

  Future<void> addBook({required Book book}) async {
    await sqlService.addBook(book: book);
  }
}
