enum Book {
  table("book"),
  id("id"),
  language("language"),
  title("title"),
  pages("pages"),
  price("price");

  final String value;

  const Book(this.value);

  static String fromString(String name) {
    try {
      return Book.values
          .firstWhere(
            (e) => e.name == name,
            orElse: () => throw ArgumentError('Book not found: $name'),
          )
          .value;
    } catch (e) {
      throw ArgumentError('Book not found: $name');
    }
  }
}
