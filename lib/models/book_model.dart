import 'package:hive/hive.dart';

part 'book_model.g.dart';

@HiveType(typeId: 1)
class BookModel {
  @HiveField(0)
  String shelf = "";

  @HiveField(1)
  String title = "";

  @HiveField(2)
  String author = "";

  @HiveField(3)
  String description = "";

  @HiveField(4)
  int pageCount = 0;

  @HiveField(5)
  String publisher = "";

  BookModel(this.author, this.description, this.title, this.publisher,
      this.shelf, this.pageCount) {}
}
