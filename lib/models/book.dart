class Book {
  final int id;
  final String title;
  final String author;
  final String coverImage;

  Book({required this.id, required this.title, required this.author, required this.coverImage});

  static Book fromMap(Map<String, Object?> e) {
    return Book(
        id: e['ID'] as int,
        title: e['Title'] as String,
        author: e['Author'] as String,
        coverImage: e['CoverImage'] as String);
  }

  Map<String, Object?> toMap() {
    return {'ID': id, 'Title': title, 'Author': author, 'CoverImage': coverImage};
  }

  @override
  String toString() {
    return 'Book{id: $id, title: $title, author: $author, coverImage: $coverImage}';
  }
}
