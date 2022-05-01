import 'package:interview/models/book.dart';
import 'package:interview/services/sql_service.dart';

class BookRepository {
  late SQLService sqlService;

  BookRepository({required this.sqlService});

  Future<Stream<List<Book>>> getBooks() async {
    return await sqlService.getBooks();
  }

  Future<void> addBook({required Book book}) async {
    await sqlService.addBook(book: book);
  }

  Future<void> updateBook({required Book book, required String title, required String author}) async {
    await sqlService.updateBook(book: book, title: title, author: author);
  }

  Future<void> deleteBook({required int id}) async {
    await sqlService.deleteBook(id: id);
  }
}
