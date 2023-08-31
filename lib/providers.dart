import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_books/models/Book.dart';
import 'package:hive/hive.dart';
import 'package:sbcv2/models/book_model.dart';

StateProvider<List<BookModel>> allBooks = StateProvider((ref) => [
      BookModel("a", "b", "c", "d", "e", 4),
      BookModel("a", "bdsa", "cdasdsa", "d", "e", 45)
    ]);

StateProvider<ThemeData> themeProvider =
    StateProvider((ref) => ThemeData.dark());

StateProvider<Icon> iconProvider =
    StateProvider((ref) => Icon(Icons.light_mode));

StateProvider hiveBoxProvider = StateProvider((ref) async {
  if (!await Hive.boxExists("books")) {
    return Hive.openBox("books");
  } else {
    return Hive.box("books");
  }
});

StateProvider shelfProvider = StateProvider((ref) async {
  if (!await Hive.boxExists("shelves")) {
    return Hive.openBox("shelves");
  }
  return Hive.box("shelves");
});
