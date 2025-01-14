import 'package:either_dart/either.dart';
import 'package:interview/exceptions/sql_exception.dart';
import 'package:interview/models/book.dart';
import 'package:interview/services/sql_service.dart';

class BookRepository {
  late SQLService sqlService;

  BookRepository({required this.sqlService});

  Either<SQLException, Stream<List<Book>>> getBooks() {
    return sqlService.getBooks();
  }

  Future<void> addBook({required Book book}) async {
    sqlService.addBook(book: book);
  }

  Future<void> updateBook({required Book book, required String title, required String author}) async {
    sqlService.updateBook(book: book, title: title, author: author);
  }

  Future<void> deleteBook({required int id}) async {
    sqlService.deleteBook(id: id);
  }
}
