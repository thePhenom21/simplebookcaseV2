import 'package:google_books/models/Book.dart';

class BookModel extends Book {
  String shelf = "";
  String wall = "";

  BookModel(this.shelf, this.wall) {}
}
