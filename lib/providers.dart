import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_books/models/Book.dart';
import 'package:sbcv2/models/book_model.dart';

//books added manually //todo
StateProvider<List<BookModel>> manualBooks =
    StateProvider((ref) => [BookModel("a", "b"), BookModel("d", "c")]);

//books added with isbn, which have more info //todo
StateProvider<List<BookModel>> autoBook =
    StateProvider((ref) => [BookModel("a", "b")]);

StateProvider<List<BookModel>> allBooks = StateProvider(
    (ref) => [BookModel("a", "b"), BookModel("d", "c"), BookModel("k", "c")]);

StateProvider<ThemeData> themeProvider =
    StateProvider((ref) => ThemeData.dark());

StateProvider<Icon> iconProvider =
    StateProvider((ref) => Icon(Icons.light_mode));
